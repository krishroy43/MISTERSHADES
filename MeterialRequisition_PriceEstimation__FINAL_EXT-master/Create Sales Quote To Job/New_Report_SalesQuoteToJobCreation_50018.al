report 50018 "Sales Quote To Job Creation"
{
    //UsageCategory = Administration;
    //ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "Job Task" = rimd, tabledata "Default Dimension" = rimd, tabledata "Comment Line" = rimd, tabledata "Dimension Set Entry" = rimd;

    dataset
    {
        dataitem(SalesHeader_; "Sales Header")
        {
            trigger
            OnAfterGetRecord()
            begin
                SalesHeader_.TestField(Status, Status::Released);
                if SalesHeader_."Job No." = '' then
                    InsertJobDetail(SalesHeader_)
                else
                    UpdateJobDetail(SalesHeader_);
                //SalesHeader_."Job No." := JobNumberG;
                //SalesHeader_.modify;
            end;
        }
    }

    var
        JobRecG: Record Job;
        JobSetupRecG: Record "Jobs Setup";
        JobTaskRecG: Record "Job Task";
        JobTaskMasterRecG: Record "Job Task Master";
        EstimationLineRecG: Record "Estimation Line Tbl";
        JobPlanningLineRecG: Record "Job Planning Line";
        NoSeriesMgtCUG: Codeunit NoSeriesManagement;
        JobNumberG: Code[20];
        JobTaskIndentCUL: Codeunit "Job Task-Indent";
        JobCard: Page "Job Card";

    trigger
        OnInitReport()
    begin
        TestNoSeries();
    end;

    procedure TestNoSeries()
    begin
        JobSetupRecG.Reset();
        JobSetupRecG.Get();
        JobSetupRecG.TestField("Job Nos.");
    end;

    // Ankur.Begin
    procedure UpdateJobDetail(SalesHeader1: Record "Sales Header")
    var
        JobPlanningLine: Record "Job Planning Line";
        EstimationDetails: Record "Estimation Line Tbl";
        EstimationLine2: Record "Estimation Line Tbl";
        EstimationHeader: Record "Estimation Header";
        JobPlanningLineRecL: Record "Job Planning Line";
        LineNo: Integer;
        Qty: Decimal;
        LineAmount: Decimal;

    begin
        EstimationHeader.reset;
        EstimationHeader.SetRange("Quote No.", SalesHeader1."No.");
        if EstimationHeader.findfirst then;

        EstimationDetails.reset;
        EstimationDetails.SetRange("Quote No.", SalesHeader1."No.");
        EstimationDetails.SetRange("Row Type", EstimationDetails."Row Type"::Line);
        if EstimationDetails.findset then
            repeat
                Qty := 0;
                LineAmount := 0;
                LineNo := 0;

                JobPlanningLine.reset;
                JobPlanningLine.SetRange("Job No.", SalesHeader1."Job No.");
                JobPlanningLine.SetRange("Drawing No.", EstimationDetails."Drawing Number");
                JobPlanningLine.SetRange("No.", EstimationDetails."Item Code");
                if JobPlanningLine.findfirst then begin
                    EstimationLine2.reset;
                    EstimationLine2.setrange("Quote No.", SalesHeader1."No.");
                    EstimationLine2.SetRange("Drawing Number", JobPlanningLine."Drawing No.");
                    EstimationLine2.SetRange("Item Code", JobPlanningLine."No.");
                    if EstimationLine2.findset then
                        repeat
                            Qty += ((EstimationLine2.Quantity * EstimationLine2."Total Qty.") / EstimationLine2."Estimated Qty.");
                            LineAmount += EstimationLine2."Total Price";
                        until EstimationLine2.NEXT = 0;

                    if JobPlanningLine.Quantity < Qty then Begin
                        JobPlanningLine.validate(Quantity, Qty);
                        JobPlanningLine.Validate("Line Amount", LineAmount);
                        JobPlanningLine.modify;
                    End;
                end else Begin
                    JobPlanningLineRecL.Reset();
                    JobPlanningLineRecL.SetRange("Job No.", SalesHeader1."Job No.");
                    //JobPlanningLineRecL.SetRange("Job Task No.", EstimationDetails."Job Task");
                    IF JobPlanningLineRecL.FindLast() then
                        LineNo := JobPlanningLineRecL."Line No." + 10000
                    else
                        LineNo := 10000;

                    JobPlanningLine.init;
                    JobPlanningLine."Line No." := LineNo;
                    JobPlanningLine."Planning Date" := Estimationheader."Estimation Date";
                    JobPlanningLine.Type := JobPlanningLine.Type::Item;
                    JobPlanningLine.Validate("No.", EstimationDetails."Item Code");
                    JobPlanningLine.Validate(Description, EstimationDetails.Description);
                    JobPlanningLine.Validate("Description 2", EstimationDetails."Description 2");
                    JobPlanningLine.Quantity := ((EstimationDetails.Quantity * EstimationDetails."Total Qty.") / EstimationDetails."Estimated Qty.");
                    JobPlanningLine.Validate("Unit of Measure Code", EstimationDetails."Unit Of Measure");
                    JobPlanningLine.Validate("Unit Cost", EstimationDetails."Unit Price");
                    JobPlanningLine.Validate("Unit Price", EstimationDetails."Unit Price");
                    JobPlanningLine.Validate("Line Amount", EstimationDetails."Total Price");
                    JobPlanningLine.validate("Drawing No.", Estimationdetails."Drawing Number");
                    JobPlanningLine.Validate("Total Cost", (EstimationDetails."Unit Price" * ((EstimationDetails.Quantity * EstimationDetails."Total Qty.") / EstimationDetails."Estimated Qty.")));
                    JobPlanningLine.Validate("Company Item Description", EstimationDetails."Company Item Description");
                    JobPlanningLine."Version No." := 1;
                    JobPlanningLine.Validate("Usage Link", true);
                    JobPlanningLine.Validate("Currency Code", SalesHeader1."Currency Code");
                    JobPlanningLine.Validate("Currency Factor", SalesHeader1."Currency Factor");
                    JobPlanningLine.Insert();
                End;
            until EstimationDetails.next = 0;
        Message('Job Updated successfully');
    end;
    // Ankur.End

    procedure InsertJobDetail(SalesHeaderPar: Record "Sales Header")
    begin
        TestNoSeries();
        JobRecG.Reset();
        JobRecG.Init();
        // Start No. Series  
        if JobRecG."No." = '' then begin
            JobRecG."No." := NoSeriesMgtCUG.GetNextNo(JobSetupRecG."Job Nos.", Today, true);
            JobNumberG := JobRecG."No.";

        end;
        // Stop No. Series 
        //JobRecG.Validate();
        JobRecG.Validate("Bill-to Customer No.", SalesHeaderPar."Bill-to Customer No.");
        JobRecG.Validate("Bill-to Name", SalesHeaderPar."Bill-to Name");
        JobRecG.Validate("Bill-to Name 2", SalesHeaderPar."Bill-to Name 2");
        JobRecG.Validate("Bill-to Address", SalesHeaderPar."Bill-to Address");
        JobRecG.Validate("Bill-to Address 2", SalesHeaderPar."Bill-to Address 2");
        JobRecG.Validate("Bill-to City", SalesHeaderPar."Bill-to City");
        JobRecG.Validate("Bill-to Post Code", SalesHeaderPar."Bill-to Post Code");
        JobRecG.Validate("Bill-to County", SalesHeaderPar."Bill-to County");
        // Start there fields are dependency from Enquiry Creation
        JobRecG.Validate("Product Type", SalesHeaderPar."Product Type");
        JobRecG.Validate("Project Location", SalesHeaderPar."Location Details");
        JobRecG.Validate("Scope Of Work 1", SalesHeaderPar."Scope Of Work 1");
        JobRecG.Validate("Scope Of Work 2", SalesHeaderPar."Scope Of Work 2");
        JobRecG.Validate("Sales Quote", SalesHeaderPar."No.");
        JobRecG.Validate("Sales Enquiry", SalesHeaderPar."Opportunity No.");
        JobRecG.Validate("Starting Date", Today);
        // Start 02-07-2019
        JobRecG.Description := SalesHeaderPar."Project Description";
        JobRecG."Version No." := 1;
        JobRecG."Fabric Type" := SalesHeaderPar."Fabric Type";
        // Stop 02-07-2019
        // Start 07-09-2019
        JobRecG."Creation Date" := Today();
        // Stop 07-09-2019
        JobRecG."Salesperson Code" := SalesHeaderPar."Salesperson Code";
        //JobRecG.Validate("Ending Date", Today);        

        // Stop there fields are dependency from Enquiry Creation

        //JobRecG.Validate("Person Responsible", SalesHeaderPar."Salesperson Code");

        //JobRecG.Validate(pro);
        // JobRecG.Insert();

        if JobRecG.Insert() then begin
            SalesHeader_."Job No." := JobNumberG;
            SalesHeader_.modify;
            InsertJobTaskDetails(JobNumberG, SalesHeaderPar);
            InsertJobPlanningLineDetail(SalesHeaderPar, JobNumberG);
            CopyPaymentMolestoneLineQuoteToJob(SalesHeaderPar, JobNumberG);
            InsertSaleQuoteToJobTermCondition(SalesHeaderPar, JobNumberG);

            CopyDimenstionSalesQuoteToJobs(SalesHeaderPar, JobNumberG);
            // Start 01-07-2019
            // comments as per Ankur covers.
            //CreatingLocationForJob(SalesHeaderPar, JobNumberG);
            CreatingDimensionValueForProject(SalesHeaderPar, JobNumberG);

            Commit();
            JobTaskIndentCUL.Run(JobTaskRecG);
            // Stop 01-07-2019
            // Start 08-09-2019
            CreatingJobPlnningLineWithPaymentMilestoneLine(JobNumberG, SalesHeaderPar."No.");
            // Stop 08-09-2019
            commit();
            clear(JobCard);
            JobCard.SetTableView(JobRecG);
            jobcard.SetRecord(JobrecG);
            //JobCard.Run(JobRecG);
            JobCard.RunModal;
            //Message('Job Created Successfully Job No. %1', JobNumberG);
        end else
            Error('this is Error : %1', GetLastErrorCode);
        //Message('Job Created Successfully Job No. %1', JobNumberG);
    end;

    procedure InsertJobTaskDetails(JobNoP: Code[20]; SalesHeaderPar: Record "Sales Header")
    var

    begin
        JobTaskMasterRecG.Reset();
        if JobTaskMasterRecG.FindSet() then begin
            repeat
                JobTaskRecG.Init();
                JobTaskRecG.Validate("Job No.", JobNoP);
                JobTaskRecG.Validate("Job Task No.", JobTaskMasterRecG."Job Task No.");

                JobTaskRecG.Validate("Job Task Type", JobTaskMasterRecG."Job Task Type");
                JobTaskRecG.Validate(Description, JobTaskMasterRecG.Description);
                // Start 08-09-2019
                JobTaskRecG.Validate(Billable, JobTaskMasterRecG.Billable);
                // Stop 08-09-2019
                JobTaskRecG."Version No." := 1;
                JobTaskRecG.Insert;
            until JobTaskMasterRecG.Next() = 0;
        end else
            Error('Job Task Master Table cannot Blank.');
        // Start 01-07-2019
        // Commit();
        // JobTaskIndentCUL.Run(JobTaskRecG);
        // Stop 01-07-2019
    end;

    procedure InsertJobPlanningLineDetail(SalesHeaderPar: Record "Sales Header"; JobNoP: Code[20])
    var
        EstimationHeaderRecL: Record "Estimation Header";
        JobPlanningLineRecL: Record "Job Planning Line";
        JobPlanningLineRecL2: Record "Job Planning Line";
    begin
        EstimationLineRecG.Reset();
        EstimationHeaderRecL.Get(SalesHeaderPar."No.", '1');
        EstimationLineRecG.SetRange("Quote No.", SalesHeaderPar."No.");
        EstimationLineRecG.SetRange("Version No.", SalesHeaderPar."Version No.");
        EstimationLineRecG.SetRange("Row Type", EstimationLineRecG."Row Type"::Line);
        if EstimationLineRecG.FindSet() then begin
            repeat
                JobPlanningLineRecG.Validate("Job No.", JobNoP);
                if EstimationLineRecG."Job Task" = '' then
                    Error('Job Task cannot blank for Line No. %1 and Item No. %2 in Document No. %3', EstimationLineRecG."Line No.", EstimationLineRecG."Item Code", EstimationLineRecG."Quote No.")
                else
                    JobPlanningLineRecG.Validate("Job Task No.", EstimationLineRecG."Job Task");

                // Ankur Begin
                JobPlanningLineRecL2.reset;
                JobPlanningLineRecL2.setrange("Job No.", JobNoP);
                JobPlanningLineRecL2.SetRange("Job Task No.", EstimationLineRecG."Job Task");
                JobPlanningLineRecL2.SetRange("Drawing No.", EstimationLineRecG."Drawing Number");
                JobPlanningLineRecL2.SetRange("No.", EstimationLineRecG."Item Code");
                if not JobPlanningLineRecL2.findfirst then begin
                    // Ankur End

                    // Start Line Number for new Job Planning Line
                    JobPlanningLineRecL.Reset();
                    JobPlanningLineRecL.SetRange("Job No.", JobNoP);
                    JobPlanningLineRecL.SetRange("Job Task No.", EstimationLineRecG."Job Task");
                    IF JobPlanningLineRecL.FindLast() then
                        JobPlanningLineRecG."Line No." := JobPlanningLineRecL."Line No." + 10000
                    else
                        JobPlanningLineRecG."Line No." := 10000;
                    // Stop Line Number for new Job Planning Line

                    //JobPlanningLineRecG."Line Type"
                    JobPlanningLineRecG."Planning Date" := EstimationHeaderRecL."Estimation Date";
                    JobPlanningLineRecG.Type := JobPlanningLineRecG.Type::Item;
                    JobPlanningLineRecG.Validate("No.", EstimationLineRecG."Item Code");
                    JobPlanningLineRecG.Validate(Description, EstimationLineRecG.Description);
                    JobPlanningLineRecG.Validate("Description 2", EstimationLineRecG."Description 2");
                    // Start 02-07-2019
                    //JobPlanningLineRecG.Validate(Quantity, EstimationLineRecG.Quantity);
                    JobPlanningLineRecG.Quantity := ((EstimationLineRecG.Quantity * EstimationLineRecG."Total Qty.") / EstimationLineRecG."Estimated Qty.");
                    // Stop 02-07-2019
                    JobPlanningLineRecG.Validate("Unit of Measure Code", EstimationLineRecG."Unit Of Measure");
                    JobPlanningLineRecG.Validate("Unit Cost", EstimationLineRecG."Unit Price");
                    JobPlanningLineRecG.Validate("Unit Price", EstimationLineRecG."Unit Price");
                    JobPlanningLineRecG.Validate("Line Amount", EstimationLineRecG."Total Price");
                    JobPlanningLineRecG.validate("Drawing No.", EstimationLineRecG."Drawing Number");
                    // Start 02-07-2019
                    //JobPlanningLineRecG.Validate("Total Cost", EstimationLineRecG."Total Price");
                    JobPlanningLineRecG.Validate("Total Cost", (EstimationLineRecG."Unit Price" * ((EstimationLineRecG.Quantity * EstimationLineRecG."Total Qty.") / EstimationLineRecG."Estimated Qty.")));
                    // Stop 02-07-2019
                    JobPlanningLineRecG.Validate("Company Item Description", EstimationLineRecG."Company Item Description");
                    JobPlanningLineRecG."Version No." := 1;
                    //Message('InsertJobPlanningLineDetail B4');
                    // Start 26-07-2019
                    JobPlanningLineRecG.Validate("Usage Link", true);
                    // Stop 26-07-2019
                    JobPlanningLineRecG.Validate("Currency Code", SalesHeaderPar."Currency Code");
                    JobPlanningLineRecG.Validate("Currency Factor", SalesHeaderPar."Currency Factor");
                    // Start 12-08-2019
                    // Stop 12-08-2019
                    JobPlanningLineRecG.Insert();
                end else begin
                    JobPlanningLineRecL2.Quantity := (JobPlanningLineRecL2.Quantity + ((EstimationLineRecG.Quantity * EstimationLineRecG."Total Qty.") / EstimationLineRecG."Estimated Qty."));
                    JobPlanningLineRecL2.Validate("Line Amount", (Jobplanninglinerecl2."Line amount" + EstimationLineRecG."Total Price"));
                    JobPlanningLineRecL2.Validate("Total Cost", (Jobplanninglinerecl2."Total Cost" + (EstimationLineRecG."Unit Price" * ((EstimationLineRecG.Quantity * EstimationLineRecG."Total Qty.") / EstimationLineRecG."Estimated Qty."))));
                    JobPlanningLineRecL2.modify;
                end;
            //Message('InsertJobPlanningLineDetail Aftr');

            until EstimationLineRecG.Next() = 0;
        end;
        // Message('Job Created Successfully Job No. %1', JobNoP);

    end;


    procedure CopyPaymentMolestoneLineQuoteToJob(SalesHeaderRecP: Record "Sales Header"; JobNumberG: code[20])
    var
        PaymentMilestone2: Record "Payment Milestone";
        PaymentMilestone3: Record "Payment Milestone";
    begin
        PaymentMilestone2.Reset();
        PaymentMilestone2.SetRange("Document Type", SalesHeaderRecP."Document Type"::Quote);
        PaymentMilestone2.SetRange("Document No.", SalesHeaderRecP."No.");
        IF PaymentMilestone2.FindSet() THEN BEGIN
            REPEAT
                PaymentMilestone3.LockTable();
                PaymentMilestone3.Init();
                PaymentMilestone3."Document Type" := PaymentMilestone3."Document Type"::Job;
                PaymentMilestone3."Document No." := JobNumberG;
                PaymentMilestone3."Line No." := PaymentMilestone2."Line No.";
                //PaymentMilestone3.Insert(true);
                PaymentMilestone3."Document Date" := Today();// PaymentMilestone2."Document Date";
                PaymentMilestone3.Amount := PaymentMilestone2.Amount;
                PaymentMilestone3."Total Value" := PaymentMilestone2."Total Value";
                PaymentMilestone3."Amount(LCY)" := PaymentMilestone2."Amount(LCY)";
                PaymentMilestone3."Total Value(LCY)" := PaymentMilestone2."Total Value(LCY)";
                PaymentMilestone3."Milestone %" := PaymentMilestone2."Milestone %";
                PaymentMilestone3."Currency Factor" := PaymentMilestone2."Currency Factor";
                PaymentMilestone3."Milestone Description" := PaymentMilestone2."Milestone Description";
                PaymentMilestone3."Payment Terms" := PaymentMilestone2."Payment Terms";
                PaymentMilestone3."Due Date" := PaymentMilestone2."Due Date";

                PaymentMilestone3.Validate("Posting Type", PaymentMilestone2."Posting Type");
                //Message('CopyPaymentMolestoneLineQuoteToJob B4');
                PaymentMilestone3.Insert(true);
                PaymentMilestone3.Modify();
            //Message('CopyPaymentMolestoneLineQuoteToJob After ');
            UNTIL PaymentMilestone2.NEXT = 0;
        END;
    end;
    // Start Date : 25-06-2019
    procedure InsertSaleQuoteToJobTermCondition(SalesQuoteHeaderPar: Record "Sales Header"; JobNoP: code[20])
    var
        SalesCommentLineRecL: Record "Sales Comment Line";
        CommentLineRecL: Record "Comment Line";
    begin
        SalesCommentLineRecL.Reset();
        SalesCommentLineRecL.SetRange("No.", SalesQuoteHeaderPar."No.");
        SalesCommentLineRecL.SetRange("Document Type", SalesQuoteHeaderPar."Document Type"::Quote);
        if SalesCommentLineRecL.FindSet() then
            repeat
                CommentLineRecL.Init();
                CommentLineRecL."No." := JobNoP;
                CommentLineRecL."Table Name" := CommentLineRecL."Table Name"::Job;
                CommentLineRecL."Line No." += 10000;
                CommentLineRecL.Comment := SalesCommentLineRecL.Comment;
                CommentLineRecL."Term/Condition" := SalesCommentLineRecL."Term/Condition";
                CommentLineRecL.Date := SalesCommentLineRecL.Date;
                CommentLineRecL.Code := SalesCommentLineRecL.Code;
                // Message('InsertSaleQuoteToJobTermCondition B$');
                CommentLineRecL.Insert();
            //Message('InsertSaleQuoteToJobTermCondition After');
            until SalesCommentLineRecL.Next() = 0;
    end;
    // Stop Date : 25-06-2019

    // Start Date 29-06-2019
    procedure CopyDimenstionSalesQuoteToJobs(SalesQuoteHeaderPar: Record "Sales Header"; JobNoP: code[20])
    var
        DimensionSetEntrySalesQuoteRecL: Record "Dimension Set Entry";
        DefaultDimensionRecJobsRecL: Record "Default Dimension";
    begin
        DimensionSetEntrySalesQuoteRecL.Reset();
        DimensionSetEntrySalesQuoteRecL.SetRange("Dimension Set ID", SalesQuoteHeaderPar."Dimension Set ID");
        if DimensionSetEntrySalesQuoteRecL.FindSet() then begin
            repeat
                DefaultDimensionRecJobsRecL.Init();
                //DefaultDimensionRecJobsRecL.Validate("No.", JobNoP);
                DefaultDimensionRecJobsRecL."No." := JobNoP;

                //DefaultDimensionRecJobsRecL.Validate("Table ID", Database::Job);
                DefaultDimensionRecJobsRecL."Table ID" := Database::Job;

                //DefaultDimensionRecJobsRecL.Validate("Dimension Code", DimensionSetEntrySalesQuoteRecL."Dimension Code");
                DefaultDimensionRecJobsRecL."Dimension Code" := DimensionSetEntrySalesQuoteRecL."Dimension Code";

                //DefaultDimensionRecJobsRecL.Validate("Dimension Value Code", DimensionSetEntrySalesQuoteRecL."Dimension Value Code");
                DefaultDimensionRecJobsRecL."Dimension Value Code" := DimensionSetEntrySalesQuoteRecL."Dimension Value Code";

                DefaultDimensionRecJobsRecL.Validate("Value Posting", DefaultDimensionRecJobsRecL."Value Posting"::"Same Code");
                //Message('Copy Dimenstion SalesQuoteToJobs  Before');
                if DefaultDimensionRecJobsRecL.Insert then;//(true);
                                                           //Message('CopyDimenstionSalesQuoteToJobs  After');
            until DimensionSetEntrySalesQuoteRecL.Next() = 0;
        end;
    end;
    // Stop Date 29-06-2019

    // Start 01-07-2019
    procedure CreatingLocationForJob(SalesQuoteHeaderPar: Record "Sales Header"; JobNoP: code[20])
    var
        LocationRecL: Record Location;
    begin
        LocationRecL.Init();
        LocationRecL.Validate(code, JobNoP);
        LocationRecL.Validate(Name, SalesHeader_."Project Description");
        LocationRecL.Insert(true);
    end;

    procedure CreatingDimensionValueForProject(SalesQuoteHeaderPar: Record "Sales Header"; JobNoP: code[20])
    var
        JobSetupRecL: Record "Jobs Setup";
        DimensionRecL: Record Dimension;
        DimemsionValueRecL: Record "Dimension Value";
    begin
        JobSetupRecL.Reset();
        if JobSetupRecL.Get() then begin
            DimensionRecL.Reset();
            if DimensionRecL.Get(JobSetupRecL."Project Dimension") then begin
                DimemsionValueRecL.Init();
                // DimemsionValueRecL.Validate("Dimension Code", JobSetupRecL."Project Dimension");
                // DimemsionValueRecL.Validate(code, JobNoP);
                // DimemsionValueRecL.Validate(Name, SalesHeader_."Project Description");
                // DimemsionValueRecL.Validate("Dimension Value Type", DimemsionValueRecL."Dimension Value Type"::Standard);
                DimemsionValueRecL.Validate("Dimension Code", JobSetupRecL."Project Dimension");
                DimemsionValueRecL.Validate(code, JobNoP);
                DimemsionValueRecL.Validate(Name, SalesHeader_."Project Description");
                DimemsionValueRecL.Validate("Dimension Value Type", DimemsionValueRecL."Dimension Value Type"::Standard);
                DimemsionValueRecL.Insert();
                Message('Job Created Successfully Job No. %1', JobNumberG);
            end;
        end;
    end;
    // Stop 01-07-2019
    procedure CreatingJobPlnningLineWithPaymentMilestoneLine(JobNo: Code[30]; SalesQuoeNo: Code[30])
    var
        PaymentMilestoneRecL: Record "Payment Milestone";
        JobPlanningLineRecL: Record "Job Planning Line";
        SalesQuoteLineRecL: Record "Sales Line";
        JobTaskRecL: Record "Job Task";
        SalesQuoteHeaderRecL: Record "Sales Header";
        PlanningType: Text[50];
    begin
        if SalesQuoteHeaderRecL.Get(SalesQuoteHeaderRecL."Document Type"::Quote, SalesQuoeNo) then begin
            SalesQuoteLineRecL.Reset();
            SalesQuoteLineRecL.SetRange("Document Type", SalesQuoteLineRecL."Document Type"::Quote);
            SalesQuoteLineRecL.SetRange("Document No.", SalesQuoeNo);
            SalesQuoteLineRecL.SetFilter("No.", '<>%1', '');
            SalesQuoteLineRecL.SetFilter(Type, '<>%1', SalesQuoteLineRecL.Type::" ");
            SalesQuoteLineRecL.SetFilter("Drawing No.", '<>%1', '');
            if SalesQuoteLineRecL.FindFirst() then begin
                JobTaskRecL.Reset();
                JobTaskRecL.SetRange("Job No.", JobNo);
                JobTaskRecL.SetRange(Billable, true);
                if JobTaskRecL.FindFirst() then begin
                    PaymentMilestoneRecL.Reset();
                    PaymentMilestoneRecL.SetRange("Document Type", PaymentMilestoneRecL."Document Type"::Quote);
                    PaymentMilestoneRecL.SetRange("Document No.", SalesQuoeNo);
                    if PaymentMilestoneRecL.FindSet() then begin
                        repeat
                            JobPlanningLineRecL.Init();
                            JobPlanningLineRecL.Validate("Job No.", JobNo);
                            JobPlanningLineRecL.Validate("Job Task No.", JobTaskRecL."Job Task No.");
                            JobPlanningLineRecL.Validate("Line No.", JobPlanningLineLastNo(JobNo, JobTaskRecL."Job Task No."));
                            JobPlanningLineRecL.Validate("Line Type", JobPlanningLineRecL."Line Type"::Billable);
                            JobPlanningLineRecL.Validate("Planning Date", PaymentMilestoneRecL."Due Date");
                            JobPlanningLineRecL.Insert();

                            PlanningType := format(SalesQuoteLineRecL.Type);


                            case (PlanningType) of
                                'G/L Account':
                                    JobPlanningLineRecL.Validate(Type, JobPlanningLineRecL.Type::"G/L Account");
                                'Resource':
                                    JobPlanningLineRecL.Validate(Type, JobPlanningLineRecL.Type::Resource);
                                'Item':
                                    JobPlanningLineRecL.Validate(Type, JobPlanningLineRecL.Type::Item);
                                'Text':
                                    JobPlanningLineRecL.Validate(Type, JobPlanningLineRecL.Type::Text);
                            end;

                            JobPlanningLineRecL.Validate("No.", SalesQuoteLineRecL."No.");
                            JobPlanningLineRecL.Description := SalesQuoteLineRecL.Description;
                            JobPlanningLineRecL."Description 2" := SalesQuoteLineRecL."Description 2";
                            JobPlanningLineRecL.Narration := SalesQuoteLineRecL.Narration;
                            JobPlanningLineRecL.Validate(Quantity, 1);
                            JobPlanningLineRecL.Validate("Unit Price", PaymentMilestoneRecL.Amount);
                            // JobPlanningLineRecL.Validate("Unit Price (LCY)", PaymentMilestoneRecL."Amount(LCY)");
                            JobPlanningLineRecL.Validate("Currency Code", SalesQuoteHeaderRecL."Currency Code");
                            JobPlanningLineRecL.Validate("Currency Factor", PaymentMilestoneRecL."Currency Factor");
                            JobPlanningLineRecL.Validate("Location Code", SalesQuoteLineRecL."Location Code");

                            JobPlanningLineRecL.Modify();
                        until PaymentMilestoneRecL.Next() = 0;
                    end;

                end;
            end;
        end;
    end;

    procedure JobPlanningLineLastNo(JobNo: Code[30]; JobTask: Code[30]): Integer
    var
        JobPlanningLineRecL: Record "Job Planning Line";
        NewLineNo: Integer;
    begin
        JobPlanningLineRecL.Reset();
        JobPlanningLineRecL.SetRange("Job No.", JobNo);
        JobPlanningLineRecL.SetRange("Job Task No.", JobTask);
        if JobPlanningLineRecL.FindLast() then
            NewLineNo := JobPlanningLineRecL."Line No." + 10000
        else
            NewLineNo := 10000;

        exit(NewLineNo);
    end;
    // Start 08-09-2019

}