pageextension 50036 "Ext. Page Job Card" extends "Job Card"
{
    layout
    {
        addafter("Project Manager")
        {

            field("Advance Received"; "Advance Received")
            {
                Editable = false;
                ApplicationArea = All;
                trigger
                OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Project Amount (Planned)"; "Project Amount (Planned)")
            {
                Editable = false;
                ApplicationArea = All;
                trigger
               OnValidate()
                begin
                    CheckJobStatus();
                end;
            }


            field("Advance Amount"; "Advance Amount")
            {
                //Editable = false;
                ApplicationArea = All;
                trigger
               OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            // Start 17-07-2019
            field("Version No."; "Version No.")
            {
                Editable = false;
                ApplicationArea = All;
                trigger
               OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            // Stop 17-07-2019


        }
        addafter("No.")
        {
            field("Job Type"; "Job Type")
            {
                ApplicationArea = All;
                trigger
               OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Salesperson Code"; "Salesperson Code")
            {
                ApplicationArea = All;
                trigger
               OnValidate()
                begin
                    CheckJobStatus();
                end;
            }

        }
        addafter("Person Responsible")
        {
            field("Contract Ref."; "Contract Ref.")
            {
                ApplicationArea = All;
                trigger
               OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Scope Of Work 1"; "Scope Of Work 1")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Scope Of Work 2"; "Scope Of Work 2")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
        }
        // Add changes to page layout here
        addafter("Project Manager")
        {
            field("Customer PO No."; "Customer PO No.")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Customer Po. Date."; "Customer Po. Date.")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Project Location"; "Project Location")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Recipients Name"; "Recipients Name")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Product Type"; "Product Type")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Fabric Type"; "Fabric Type")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;
            }
            field("Sales Quote"; "Sales Quote")
            {
                ApplicationArea = All;
                ToolTip = 'Select Sales Quote';
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;

            }
            field("Sales Enquiry"; "Sales Enquiry")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CheckJobStatus();
                end;
            }

            group("Project Contacts")
            {
                field(Finance; Finance)
                {
                    ApplicationArea = All;
                    trigger
                    OnLookup(var Text: Text): Boolean
                    var
                        ContBusinessRelation: Record "Contact Business Relation";
                        Cont: Record Contact;
                        TempCust: Record Customer temporary;
                        Cust: Record Customer;
                    begin
                        IF ("Bill-to Customer No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
                            Cont.SETRANGE("Company No.", Cont."Company No.")
                        ELSE
                            IF Cust.GET("Bill-to Customer No.") THEN BEGIN
                                IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.") THEN
                                    Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                            END ELSE
                                Cont.SETFILTER("Company No.", '<>%1', '''');

                        IF "Bill-to Contact No." <> '' THEN
                            IF Cont.GET("Bill-to Contact No.") THEN;
                        IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                            xRec := Rec;
                            VALIDATE(Finance, Cont."No.");
                            finance_Var := Cont.Name;
                        END;

                    end;

                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;

                }
                field("Financer's Name"; finance_Var)
                {
                    ApplicationArea = All;

                    Editable = false;
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field("Site Project manager"; "Site Project manager")
                {
                    ApplicationArea = All;
                    trigger
                    OnLookup(var Text: Text): Boolean
                    var
                        ContBusinessRelation: Record "Contact Business Relation";
                        Cont: Record Contact;
                        TempCust: Record Customer temporary;
                        Cust: Record Customer;
                    begin
                        IF ("Bill-to Customer No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
                            Cont.SETRANGE("Company No.", Cont."Company No.")
                        ELSE
                            IF Cust.GET("Bill-to Customer No.") THEN BEGIN
                                IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.") THEN
                                    Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                            END ELSE
                                Cont.SETFILTER("Company No.", '<>%1', '''');

                        IF "Bill-to Contact No." <> '' THEN
                            IF Cont.GET("Bill-to Contact No.") THEN;
                        IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                            xRec := Rec;
                            VALIDATE("Site Project manager", Cont."No.");
                            SiteProjMgr_Var := Cont.Name;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;


                }
                field("Site Project Manager's Name"; SiteProjMgr_Var)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger
                   OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field(Procurement; Procurement)
                {
                    ApplicationArea = All;
                    trigger
                      OnLookup(var Text: Text): Boolean
                    var
                        ContBusinessRelation: Record "Contact Business Relation";
                        Cont: Record Contact;
                        TempCust: Record Customer temporary;
                        Cust: Record Customer;
                    begin
                        IF ("Bill-to Customer No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
                            Cont.SETRANGE("Company No.", Cont."Company No.")
                        ELSE
                            IF Cust.GET("Bill-to Customer No.") THEN BEGIN
                                IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.") THEN
                                    Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                            END ELSE
                                Cont.SETFILTER("Company No.", '<>%1', '''');

                        IF "Bill-to Contact No." <> '' THEN
                            IF Cont.GET("Bill-to Contact No.") THEN;
                        IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                            xRec := Rec;
                            VALIDATE(Procurement, Cont."No.");
                            Procu_Var := Cont.Name;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field("Procurement's Name"; Procu_Var)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field("Quantity Surveyor"; "Quantity Surveyor")
                {
                    ApplicationArea = All;
                    trigger
                    OnLookup(var Text: Text): Boolean
                    var
                        ContBusinessRelation: Record "Contact Business Relation";
                        Cont: Record Contact;
                        TempCust: Record Customer temporary;
                        Cust: Record Customer;
                        JobCard: Page "Job Card";
                    begin
                        IF ("Bill-to Customer No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
                            Cont.SETRANGE("Company No.", Cont."Company No.")
                        ELSE
                            IF Cust.GET("Bill-to Customer No.") THEN BEGIN
                                IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.") THEN
                                    Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                            END ELSE
                                Cont.SETFILTER("Company No.", '<>%1', '''');

                        IF "Bill-to Contact No." <> '' THEN
                            IF Cont.GET("Bill-to Contact No.") THEN;
                        IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                            xRec := Rec;
                            VALIDATE("Quantity Surveyor", Cont."No.");
                            QuiltSur_Var := Cont.Name;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field("Quantity Surveyor's Name"; QuiltSur_Var)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }

            }
        }
        // Start 01-07-2019
        addfirst(Duration)
        {
            field("Completion date"; "Completion date")
            {
                ApplicationArea = All;

            }

        }
        modify("Starting Date")
        {
            trigger
            OnBeforeValidate()
            begin
                CheckJobStatus();
            end;
        }
        modify("Ending Date")
        {
            trigger
           OnBeforeValidate()
            begin
                CheckJobStatus();
            end;
        }
        modify("Currency Code")
        {

            trigger
           OnBeforeValidate()
            begin
                CheckJobStatus();
            end;
        }
        modify("Invoice Currency Code")
        {

            trigger
           OnBeforeValidate()
            begin
                CheckJobStatus();
            end;
        }
        modify("Exch. Calculation (Cost)")
        {

            trigger
           OnBeforeValidate()
            begin
                CheckJobStatus();
            end;
        }
        modify("Exch. Calculation (Price)")
        {

            trigger
           OnBeforeValidate()
            begin
                CheckJobStatus();
            end;
        }
        // Stop 01-07-2019

        addafter(General)
        {

            group("Project Completion")
            {
                group("Design \ Quantity Surveyor")
                {
                    field("Approved Drawing"; "Approved Drawing")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                    field("Material Mill Certificate"; "Material Mill Certificat")
                    {
                        ApplicationArea = All;
                        Caption = 'Material Mill Certificate  ';
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                    field("Painting Technical Data"; "Painting Technical Data")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                    field("Operation and Maintnc Manual"; "Operation and Maintnc Manual")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                    field("As Built Drawing"; "As Built Drawing")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                    field("Apprv. Struct. Design Calc."; "Apprv. Struct. Design Calc.")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                }
                group(Productions)
                {
                    field("Welding Statement"; "Welding Statement")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                    field("Elcomtr Calibrt. Certi. Paint"; "Elcomtr Calibrt. Certi. Paint")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                }
                group(Projects)
                {
                    field("Election Method Statement"; "Erection Method Statement")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                    field("Painting Method Statement"; "Painting Method Statement")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                    field("Magnetic Particle Test Report"; "Magnetic Particle Test Report")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                    field("Painting Report DFT"; "Painting Report DFT")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CheckJobStatus();
                        end;
                    }
                }

            }

            group("Documents and Approval")
            {
                field(" Material Finalization"; " Material Finalization")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field("Phy. and Material Approval"; "Phy. and Material Approval")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field("Shop Drawing Approval"; "Shop Drawing Approval")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field("Prototype Requested"; "Prototype Requested")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field("Proforma Invoice created"; "Proforma Invoice created")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field(Standard; "Standard 2")
                {
                    ApplicationArea = All;
                    Caption = 'Standard';
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
                field("Workflow Status"; "Workflow Status")
                {
                    ApplicationArea = all;
                    Caption = 'Status';
                    Editable = false;
                    trigger OnValidate()
                    begin
                        CheckJobStatus();
                    end;
                }
            }

        }
        //modify()


    }


    actions
    {
        // Add changes to page actions here
        addafter("W&IP")
        {
            group("Request Approval")
            {
                Image = Approval;
                action("Send Approval Request")
                {
                    ApplicationArea = All;
                    Image = SendApprovalRequest;
                    trigger
                    OnAction()
                    var
                        PaymentMileStoneRecL: Record "Payment Milestone";
                    begin
                        // Start 22-07-2019
                        // PaymentMileStoneRecL.Reset();
                        // PaymentMileStoneRecL.SetRange("Document No.", "No.");
                        // PaymentMileStoneRecL.SetRange("Document Type", PaymentMileStoneRecL."Document Type"::Job);
                        // PaymentMileStoneRecL.SetRange("Posting Type", PaymentMileStoneRecL."Posting Type"::Advance);
                        // if PaymentMileStoneRecL.FindFirst() then begin
                        // Stop 22-07-2019
                        ////if "Advance Received" = true then
                        InitCuCodeunitG.OnSendJobforApproval(Rec)
                        //else
                        //     // Error('Advance not recieve for Job %1', "No.");
                        // end Else begin
                        //     InitCuCodeunitG.OnSendJobforApproval(Rec);
                        // end;
                        // ;


                        // Testpage1.Run();
                    end;

                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = All;
                    Image = CancelApprovalRequest;
                    trigger
                    OnAction()
                    begin
                        //If Rec."Advance Received" = true then
                        InitCuCodeunitG.OnCancelJobforApproval(Rec)
                        //else
                        // Error('No Advance received for the current Job');
                    end;
                }
                action("Delete Arch")
                {
                    Image = Delete;
                    ApplicationArea = All;
                    trigger
                    OnAction()
                    var
                        ArchJobPlanningLine: Record "Archieved Job Planning Line";
                        ArchJobTaskRecL: Record "Archieved Job Task";
                        ArchJobRecG: Record "Archieved Job";
                    begin
                        //ArchJobPlanningLine.DeleteAll();
                        // ArchJobTaskRecL.DeleteAll();
                        // ArchJobRecG.DeleteAll();
                    end;
                }
                action("Reopen")
                {
                    ApplicationArea = All;
                    Image = ReOpen;
                    trigger
                    OnAction()
                    var
                        JobArchProcessCUL: Codeunit "Job Archieved Process";
                        JobRecL: Record Job;
                        JobRec2L: Record Job;
                        JobTaskRecL: Record "Job Task";
                        JobPlanningLineRecL: Record "Job Planning Line";
                    begin
                        if "Workflow Status" = "Workflow Status"::Released then begin
                            if "Version No." = 0 then begin
                                "Version No." := 1;
                                Modify();
                            end;
                            // JobRecL.Reset();
                            //CurrPage.SetSelectionFilter(JobRecL);
                            // Message('Going Version %1', Rec."Version No.");
                            JobArchProcessCUL.InsertJobToArchievedJob(Rec, Rec."Version No.");

                            JobPlanningLineRecL.Reset();
                            JobPlanningLineRecL.SetRange("Job No.", Rec."No.");
                            JobPlanningLineRecL.SetRange("Version No.", Rec."Version No.");
                            if JobPlanningLineRecL.FindSet() then begin
                                JobPlanningLineRecL.ModifyAll("Version No.", (Rec."Version No." + 1));
                                Commit();
                                // Message('Card Jobs Palnning Line');
                            end;

                            JobTaskRecL.Reset();
                            JobTaskRecL.SetRange("Job No.", "No.");
                            JobTaskRecL.SetRange("Version No.", Rec."Version No.");
                            if JobTaskRecL.FindSet() then begin
                                JobTaskRecL.ModifyAll("Version No.", (Rec."Version No." + 1));
                                Commit();
                                //  Message('Card Jobs Task');
                            end;

                            JobRec2L.Reset();
                            JobRec2L.SetRange("No.", Rec."No.");
                            JobRec2L.SetRange("Version No.", Rec."Version No.");
                            if JobRec2L.FindFirst() then begin
                                // JobRec2L.ModifyAll("Version No.", ("Version No." + 1));
                                JobRec2L."Version No." := (Rec."Version No." + 1);
                                JobRec2L."Workflow Status" := JobRec2L."Workflow Status"::Open;
                                JobRec2L.Modify();
                                Commit();
                                Message('Job %1 Reopen Successfully', "No.");
                            end;
                        end;
                    end;
                }
                action(Approvals)
                {
                    Image = Approvals;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        ApprovalEntry.SETFILTER("Table ID", '%1', DATABASE::Job);
                        ApprovalEntry.SETFILTER("Record ID to Approve", '%1', Rec.RecordId);
                        ApprovalEntry.SETRANGE("Related to Change", FALSE);
                        PAGE.RUN(PAGE::"Jobs Approvals", ApprovalEntry);
                    end;
                }

                action(Approve)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(rec.Recordid);
                    end;
                }

                action(Reject)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(rec.Recordid);
                    end;
                }

                action(Delegate)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.Recordid);
                    end;
                }

                action(Comment)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(rec.Recordid);
                    end;
                }

                action(RUNCU)
                {
                    ApplicationArea = all;
                    Image = Company;
                    Visible = false;
                    trigger OnAction()
                    var
                        CompanyInitialize: Codeunit "Company-Initialize";
                        WorkflowSetup: Codeunit "Workflow Setup";
                    begin
                        CompanyInitialize.run;
                        WorkflowSetup.Run();
                    end;
                }
            }
        }
        addafter(Attachments)
        {
            action("Archived Jobs")
            {
                Image = Archive;
                ApplicationArea = All;
                trigger
                OnAction()
                var
                    ArchJobRecG: Record "Archieved Job";
                begin
                    ArchJobRecG.Reset();
                    ArchJobRecG.SetRange("No.", "No.");
                    Page.RunModal(50440, ArchJobRecG);

                end;
            }
            action("Payment Milestones")
            {
                Image = Payment;
                ApplicationArea = All;
                RunObject = page "Payment Milestone List";
                RunPageLink = "Document No." = field("No."), "Document Type" = const(Job);
                TRIGGER OnAction()
                var
                    PaymentMilestone: Record "Payment Milestone";
                BEGIN
                    TestField("Creation Date");
                    PaymentMilestone.Reset();
                    PaymentMilestone.SetRange("Document Type", PaymentMilestone."Document Type"::Job);
                    PaymentMilestone.SetRange("Document No.", Rec."No.");
                    if PaymentMilestone.Find() then
                        PAGE.RUNMODAL(50033, PaymentMilestone);
                END;
            }

            action("Retention Due Details")
            {
                ApplicationArea = All;
                Image = DueDate;
                // Start 02-09-2019 
                // Filter base on Job No. While Opening page
                ////RunObject = Page "Retention Due Details";
                trigger
                OnAction()
                var
                    CustLedgerEntryRecL: Record "Cust. Ledger Entry";
                begin
                    CustLedgerEntryRecL.Reset();
                    CustLedgerEntryRecL.SetRange("Job No.", "No.");
                    Page.RunModal(50034, CustLedgerEntryRecL);
                end;
                // Stop 02-09-2019

            }

            action("Retention Reversal")
            {
                ApplicationArea = All;
                Image = ReverseLines;
                //RunObject = Page "Retention Due Details";
                trigger OnAction()
                var
                    ReversalReport: Report "Retention Reversal";
                begin
                    ReversalReport.SetValues(Rec."No.", Rec."Bill-to Customer No.");
                    ReversalReport.RunModal();
                end;

            }
        }
        modify("Co&mments")
        {
            Caption = 'Term & Condition';
        }
        // Start 17-07-2019

        // Stop 17-07-2019
        addafter("Job - Suggested Billing")
        {
            action("Print JCC and HOC")
            {
                Image = Certificate;
                ApplicationArea = All;
                trigger
                OnAction()
                var
                    JobRecL: Record Job;
                begin
                    CurrPage.SetSelectionFilter(JobRecL);
                    Report.RunModal(50007, true, true, JobRecL);
                end;
            }
            action("Advance Rc")
            {
                Image = AdjustVATExemption;
                ApplicationArea = All;
                trigger
                OnAction()
                begin
                    "Advance Received" := true;
                    Modify();
                end;
            }

        }

    }

    var
        finance_Var: Text[100];
        SiteProjMgr_Var: Text[100];
        QuiltSur_Var: Text[100];
        Procu_Var: Text[100];
        InitCuCodeunitG: Codeunit IntJobCodeunit;
        TestPAge1: Page WFResponses_s;
        ApprovalEntry: Record "Approval Entry";


    trigger
    OnOpenPage()
    var
        ContactRecG: Record Contact;
        CustLedgerEntryRecL: Record "Cust. Ledger Entry";
        CustLedgerEntryPage: page "Customer Ledger Entries";
        AmountSumDecL: Decimal;
    begin

        // Stop 17-07-2019
        // Start 23-07-2019
        if "No." <> '' then begin

            if ContactRecG.get(Finance) then
                finance_Var := ContactRecG.Name;

            if ContactRecG.get("Site Project manager") then
                SiteProjMgr_Var := ContactRecG.Name;

            if ContactRecG.get("Quantity Surveyor") then
                QuiltSur_Var := ContactRecG.Name;

            if ContactRecG.get(Procurement) then
                Procu_Var := ContactRecG.Name;




            Clear(AmountSumDecL);
            CustLedgerEntryRecL.Reset();
            CustLedgerEntryRecL.SetRange("Job No.", "No.");
            CustLedgerEntryRecL.SetRange("Posting Type", CustLedgerEntryRecL."Posting Type"::Advance);
            if CustLedgerEntryRecL.FindSet() then begin
                repeat
                    CustLedgerEntryRecL.CalcFields(Amount);
                    AmountSumDecL += CustLedgerEntryRecL.Amount
                until CustLedgerEntryRecL.Next() = 0;
                "Advance Amount" := abs(AmountSumDecL);
                Modify();

            end;
        end;
        // Stop 23-0-2019
    end;

    trigger
    OnModifyRecord(): Boolean
    begin
        // Start 17-07-2019

    end;

    trigger OnAfterGetCurrRecord()
    var
        CustLedgerEntryRecL: Record "Cust. Ledger Entry";
    begin

        if "No." <> '' then begin
            CustLedgerEntryRecL.Reset();
            CustLedgerEntryRecL.SetRange("Customer No.", "Bill-to Customer No.");
            CustLedgerEntryRecL.SetRange("Job No.", "No.");
            CustLedgerEntryRecL.SetRange("Posting Type", CustLedgerEntryRecL."Posting Type"::Advance);
            if CustLedgerEntryRecL.FindSet() then begin
                CustLedgerEntryRecL.CalcFields(Amount);
                "Advance Amount" := CustLedgerEntryRecL.Amount;
            end;
        end;
    end;

    // Start 24-07-2019
    procedure CheckJobStatus()
    begin
        if "No." <> '' then
            if "Workflow Status" = "Workflow Status"::Released then
                Error('Status must be Open');
    end;


    // Stop 24-07-2019

}