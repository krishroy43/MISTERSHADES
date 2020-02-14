codeunit 50440 "Job Archieved Process"
{

    trigger OnRun()
    begin

    end;

    var
        ArchJobRecG: Record "Archieved Job";
        ArchJobTaskRecG: Record "Archieved Job Task";
        ArchJobPlanningLineRecG: Record "Archieved Job Planning Line";

    procedure InsertJobToArchievedJob(JobRecL: Record Job; VersionNoIntL: Integer)
    begin
        JobRecL.CalcFields("Scheduled Res. Qty.", "Scheduled Res. Gr. Qty.", "Total WIP Cost Amount", "Total WIP Cost G/L Amount", "Recog. Sales Amount", "Recog. Sales G/L Amount", "Recog. Costs Amount", "Recog. Costs G/L Amount", "Total WIP Sales Amount", "Total WIP Sales G/L Amount", "Applied Costs G/L Amount", "Applied Sales G/L Amount", "Calc. Recog. Sales Amount", "Calc. Recog. Costs Amount", "Calc. Recog. Sales G/L Amount", "Calc. Recog. Costs G/L Amount");
        ArchJobRecG.Init();
        ArchJobRecG.Validate("No.", JobRecL."No.");
        ArchJobRecG.Validate("Archieved Version No.", VersionNoIntL);

        ArchJobRecG.Validate("Search Description", JobRecL."Search Description");
        ArchJobRecG.Validate(Description, JobRecL.Description);
        ArchJobRecG.Validate("Description 2", JobRecL."Description 2");
        ArchJobRecG.Validate("Bill-to Customer No.", JobRecL."Bill-to Customer No.");
        ArchJobRecG.Validate("Creation Date", JobRecL."Creation Date");
        ArchJobRecG.Validate("Starting Date", JobRecL."Starting Date");
        ArchJobRecG.Validate("Ending Date", JobRecL."Ending Date");
        ArchJobRecG.Validate(Status, JobRecL.Status);
        ArchJobRecG.Validate("Person Responsible", JobRecL."Person Responsible");
        ArchJobRecG.Validate("Global Dimension 1 Code", JobRecL."Global Dimension 1 Code");
        ArchJobRecG.Validate("Global Dimension 2 Code", JobRecL."Global Dimension 2 Code");
        ArchJobRecG.Validate("Job Posting Group", JobRecL."Job Posting Group");
        ArchJobRecG.Validate(Blocked, JobRecL.Blocked);
        ArchJobRecG.Validate("Last Date Modified", JobRecL."Last Date Modified");
        ArchJobRecG.Validate(Comment, JobRecL.Comment);
        ArchJobRecG.Validate("Customer Disc. Group", JobRecL."Customer Disc. Group");
        ArchJobRecG.Validate("Customer Price Group", JobRecL."Customer Price Group");
        ArchJobRecG.Validate("Language Code", JobRecL."Language Code");
        ArchJobRecG.Validate("Scheduled Res. Qty.", JobRecL."Scheduled Res. Qty.");
        ArchJobRecG.Validate("Resource Filter", JobRecL."Resource Filter");
        ArchJobRecG.Validate("Posting Date Filter", JobRecL."Posting Date Filter");
        ArchJobRecG.Validate("Resource Gr. Filter", JobRecL."Resource Gr. Filter");
        ArchJobRecG.Validate("Scheduled Res. Gr. Qty.", JobRecL."Scheduled Res. Gr. Qty.");
        //ArchJobRecG.Validate(Picture, JobRecL.Picture);
        ArchJobRecG.Validate("Bill-to Name", JobRecL."Bill-to Name");
        ArchJobRecG.Validate("Bill-to Address", JobRecL."Bill-to Address");
        ArchJobRecG.Validate("Bill-to Address 2", JobRecL."Bill-to Address 2");
        ArchJobRecG.Validate("Bill-to City", JobRecL."Bill-to City");
        ArchJobRecG.Validate("Bill-to County", JobRecL."Bill-to County");
        ArchJobRecG.Validate("Bill-to Post Code", JobRecL."Bill-to Post Code");
        ArchJobRecG.Validate("No. Series", JobRecL."No. Series");
        ArchJobRecG.Validate("Bill-to Country/Region Code", JobRecL."Bill-to Country/Region Code");
        ArchJobRecG.Validate("Bill-to Name 2", JobRecL."Bill-to Name 2");
        ArchJobRecG.Validate(Reserve, JobRecL.Reserve);
        ArchJobRecG.Validate(Image, JobRecL.Image);
        ArchJobRecG.Validate("WIP Method", JobRecL."WIP Method");
        ArchJobRecG.Validate("Currency Code", JobRecL."Currency Code");
        ArchJobRecG.Validate("Bill-to Contact No.", JobRecL."Bill-to Contact No.");
        ArchJobRecG.Validate("Bill-to Contact", JobRecL."Bill-to Contact");
        ArchJobRecG.Validate("Planning Date Filter", JobRecL."Planning Date Filter");
        ArchJobRecG.Validate("Total WIP Cost Amount", JobRecL."Total WIP Cost Amount");
        ArchJobRecG.Validate("Total WIP Cost G/L Amount", JobRecL."Total WIP Cost G/L Amount");
        ArchJobRecG.Validate("WIP Entries Exist", JobRecL."WIP Entries Exist");
        ArchJobRecG.Validate("WIP Posting Date", JobRecL."WIP Posting Date");
        ArchJobRecG.Validate("WIP G/L Posting Date", JobRecL."WIP G/L Posting Date");
        ArchJobRecG.Validate("Invoice Currency Code", JobRecL."Invoice Currency Code");
        ArchJobRecG.Validate("Exch. Calculation (Cost)", JobRecL."Exch. Calculation (Cost)");
        ArchJobRecG.Validate("Exch. Calculation (Price)", JobRecL."Exch. Calculation (Price)");
        ArchJobRecG.Validate("Allow Schedule/Contract Lines", JobRecL."Allow Schedule/Contract Lines");
        ArchJobRecG.Validate(Complete, JobRecL.Complete);
        ArchJobRecG.Validate("Recog. Sales Amount", JobRecL."Recog. Sales Amount");
        ArchJobRecG.Validate("Recog. Sales G/L Amount", JobRecL."Recog. Sales G/L Amount");
        ArchJobRecG.Validate("Recog. Costs Amount", JobRecL."Recog. Costs Amount");
        ArchJobRecG.Validate("Recog. Costs G/L Amount", JobRecL."Recog. Costs G/L Amount");
        ArchJobRecG.Validate("Total WIP Sales Amount", JobRecL."Total WIP Sales Amount");
        ArchJobRecG.Validate("Total WIP Sales G/L Amount", JobRecL."Total WIP Sales G/L Amount");
        ArchJobRecG.Validate("WIP Completion Calculated", JobRecL."WIP Completion Calculated");
        ArchJobRecG.Validate("Next Invoice Date", JobRecL."Next Invoice Date");
        ArchJobRecG.Validate("Apply Usage Link", JobRecL."Apply Usage Link");
        ArchJobRecG.Validate("WIP Warnings", JobRecL."WIP Warnings");
        ArchJobRecG.Validate("WIP Posting Method", JobRecL."WIP Posting Method");
        ArchJobRecG.Validate("Applied Costs G/L Amount", JobRecL."Applied Costs G/L Amount");
        ArchJobRecG.Validate("Applied Sales G/L Amount", JobRecL."Applied Sales G/L Amount");
        ArchJobRecG.Validate("Calc. Recog. Sales Amount", JobRecL."Calc. Recog. Sales Amount");
        ArchJobRecG.Validate("Calc. Recog. Costs Amount", JobRecL."Calc. Recog. Costs Amount");
        ArchJobRecG.Validate("Calc. Recog. Sales G/L Amount", JobRecL."Calc. Recog. Sales G/L Amount");
        ArchJobRecG.Validate("Calc. Recog. Costs G/L Amount", JobRecL."Calc. Recog. Costs G/L Amount");
        ArchJobRecG.Validate("WIP Completion Posted", JobRecL."WIP Completion Posted");
        ArchJobRecG.Validate("Over Budget", JobRecL."Over Budget");
        ArchJobRecG.Validate("Project Manager", JobRecL."Project Manager");
        ArchJobRecG.Validate("Customer PO No.", JobRecL."Customer PO No.");
        ArchJobRecG.Validate("Project Location", JobRecL."Project Location");
        ArchJobRecG.Validate("Recipients Name", JobRecL."Recipients Name");
        ArchJobRecG.Validate("Product Type", JobRecL."Product Type");
        ArchJobRecG.Validate("Sales Quote", JobRecL."Sales Quote");
        ArchJobRecG.Validate("Sales Enquiry", JobRecL."Sales Enquiry");
        ArchJobRecG.Validate("Approved Drawing", JobRecL."Approved Drawing");
        ArchJobRecG.Validate("Material Mill Certificat", JobRecL."Material Mill Certificat");
        ArchJobRecG.Validate("Painting Technical Data", JobRecL."Painting Technical Data");
        ArchJobRecG.Validate("Operation and Maintnc Manual", JobRecL."Operation and Maintnc Manual");
        ArchJobRecG.Validate("As Built Drawing", JobRecL."As Built Drawing");
        ArchJobRecG.Validate("Apprv. Struct. Design Calc.", JobRecL."Apprv. Struct. Design Calc.");
        ArchJobRecG.Validate("Welding Statement", JobRecL."Welding Statement");
        ArchJobRecG.Validate("Elcomtr Calibrt. Certi. Paint", JobRecL."Elcomtr Calibrt. Certi. Paint");
        ArchJobRecG.Validate("Erection Method Statement", JobRecL."Erection Method Statement");
        ArchJobRecG.Validate("Painting Method Statement", JobRecL."Painting Method Statement");
        ArchJobRecG.Validate("Magnetic Particle Test Report", JobRecL."Magnetic Particle Test Report");
        ArchJobRecG.Validate("Painting Report DFT", JobRecL."Painting Report DFT");
        ArchJobRecG.Validate(Finance, JobRecL.Finance);
        ArchJobRecG.Validate("Site Project manager", JobRecL."Site Project manager");
        ArchJobRecG.Validate(Procurement, JobRecL.Procurement);
        ArchJobRecG.Validate("Quantity Surveyor", JobRecL."Quantity Surveyor");
        ArchJobRecG.Validate(" Material Finalization", JobRecL." Material Finalization");
        ArchJobRecG.Validate("Phy. and Material Approval", JobRecL."Phy. and Material Approval");
        ArchJobRecG.Validate("Shop Drawing Approval", JobRecL."Shop Drawing Approval");
        ArchJobRecG.Validate("Prototype Requested", JobRecL."Prototype Requested");
        ArchJobRecG.Validate("Proforma Invoice created", JobRecL."Proforma Invoice created");
        ArchJobRecG.Validate(Standard, JobRecL.Standard);
        ArchJobRecG.Validate("Standard 2", JobRecL."Standard 2");
        ArchJobRecG.Validate("Job Type", JobRecL."Job Type");
        ArchJobRecG.Validate("Scope Of Work 1", JobRecL."Scope Of Work 1");
        ArchJobRecG.Validate("Scope Of Work 2", JobRecL."Scope Of Work 2");
        ArchJobRecG.Validate("Contract Ref.", JobRecL."Contract Ref.");
        ArchJobRecG.Validate("Customer Po. Date.", JobRecL."Customer Po. Date.");
        ArchJobRecG.Validate("Workflow Status", JobRecL."Workflow Status");
        ArchJobRecG.Validate("Salesperson Code", JobRecL."Salesperson Code");
        ArchJobRecG.Validate("Completion date", JobRecL."Completion date");
        ArchJobRecG.Validate("Project Amount (Planned)", JobRecL."Project Amount (Planned)");
        ArchJobRecG.Validate("Advance Received", JobRecL."Advance Received");
        ArchJobRecG.Validate("Advance Amount", JobRecL."Advance Amount");
        ArchJobRecG.Insert();
        Commit();
        // Message('CU Jobs');
        // Start Calling Archieved Job Task Table insert Funcation        
        InsertJobTaskToArchievedJobTask(JobRecL, VersionNoIntL);
        Commit();

        // Stop Calling Archieved Job Task Table insert Funcation
        // Start Calling Archieved Job Planning Line Table insert Funcation
        InsertJobPlanningLineToArchievedJobPlanningLine(JobRecL, VersionNoIntL);
        Commit();

        // Stop Calling Archieved Job Planning Line Table insert Funcation
        // Message('Currect Version %1', VersionNoIntL);
    end;

    procedure InsertJobTaskToArchievedJobTask(JobRecL: Record Job; VersionNoIntL: Integer)
    var
        JobTaskRecL: Record "Job Task";
        ArchJobTaskRecL: Record "Archieved Job Task";
    begin
        JobTaskRecL.Reset();
        JobTaskRecL.SetRange("Job No.", JobRecL."No.");
        JobTaskRecL.SetRange("Version No.", JobRecL."Version No.");
        if JobTaskRecL.FindSet() then begin
            repeat
                JobTaskRecL.CalcFields("Schedule (Total Cost)", "Schedule (Total Price)", "Usage (Total Cost)", "Usage (Total Price)", "Contract (Total Cost)", "Contract (Total Price)", "Contract (Invoiced Price)", "Contract (Invoiced Cost)", "Outstanding Orders", "Amt. Rcd. Not Invoiced", "Remaining (Total Cost)", "Remaining (Total Price)");
                ArchJobTaskRecL.Init();
                // Start below are primary keys
                ArchJobTaskRecL.Validate("Job No.", JobTaskRecL."Job No.");
                ArchJobTaskRecL.Validate("Archieved Version No.", JobTaskRecL."Version No.");
                ArchJobTaskRecL.Validate("Job Task No.", JobTaskRecL."Job Task No.");
                // Stop below are primary keys
                ArchJobTaskRecL.Validate(Description, JobTaskRecL.Description);
                ArchJobTaskRecL.Validate("Job Task Type", JobTaskRecL."Job Task Type");
                ArchJobTaskRecL.Validate("WIP-Total", JobTaskRecL."WIP-Total");
                ArchJobTaskRecL.Validate("Job Posting Group", JobTaskRecL."Job Posting Group");
                ArchJobTaskRecL.Validate("WIP Method", JobTaskRecL."WIP Method");
                ArchJobTaskRecL.Validate("Schedule (Total Cost)", JobTaskRecL."Schedule (Total Cost)");
                ArchJobTaskRecL.Validate("Schedule (Total Price)", JobTaskRecL."Schedule (Total Price)");
                ArchJobTaskRecL.Validate("Usage (Total Cost)", JobTaskRecL."Usage (Total Cost)");
                ArchJobTaskRecL.Validate("Usage (Total Price)", JobTaskRecL."Usage (Total Price)");
                ArchJobTaskRecL.Validate("Contract (Total Cost)", JobTaskRecL."Contract (Total Cost)");
                ArchJobTaskRecL.Validate("Contract (Total Price)", JobTaskRecL."Contract (Total Price)");
                ArchJobTaskRecL.Validate("Contract (Invoiced Price)", JobTaskRecL."Contract (Invoiced Price)");
                ArchJobTaskRecL.Validate("Contract (Invoiced Cost)", JobTaskRecL."Contract (Invoiced Cost)");
                ArchJobTaskRecL.Validate("Posting Date Filter", JobTaskRecL."Posting Date Filter");
                ArchJobTaskRecL.Validate("Planning Date Filter", JobTaskRecL."Planning Date Filter");
                ArchJobTaskRecL.Validate(Totaling, JobTaskRecL.Totaling);
                ArchJobTaskRecL.Validate("New Page", JobTaskRecL."New Page");
                ArchJobTaskRecL.Validate("No. of Blank Lines", JobTaskRecL."No. of Blank Lines");
                ArchJobTaskRecL.Validate(Indentation, JobTaskRecL.Indentation);
                ArchJobTaskRecL.Validate("Recognized Sales Amount", JobTaskRecL."Recognized Sales Amount");
                ArchJobTaskRecL.Validate("Recognized Costs Amount", JobTaskRecL."Recognized Costs Amount");
                ArchJobTaskRecL.Validate("Recognized Sales G/L Amount", JobTaskRecL."Recognized Sales G/L Amount");
                ArchJobTaskRecL.Validate("Recognized Costs G/L Amount", JobTaskRecL."Recognized Costs G/L Amount");
                ArchJobTaskRecL.Validate("Global Dimension 1 Code", JobTaskRecL."Global Dimension 1 Code");
                ArchJobTaskRecL.Validate("Global Dimension 2 Code", JobTaskRecL."Global Dimension 2 Code");
                ArchJobTaskRecL.Validate("Outstanding Orders", JobTaskRecL."Outstanding Orders");
                ArchJobTaskRecL.Validate("Amt. Rcd. Not Invoiced", JobTaskRecL."Amt. Rcd. Not Invoiced");
                ArchJobTaskRecL.Validate("Remaining (Total Cost)", JobTaskRecL."Remaining (Total Cost)");
                ArchJobTaskRecL.Validate("Remaining (Total Price)", JobTaskRecL."Remaining (Total Price)");
                ArchJobTaskRecL.Validate("Start Date", JobTaskRecL."Start Date");
                ArchJobTaskRecL.Validate("End Date", JobTaskRecL."End Date");
                ArchJobTaskRecL.Insert();
                Commit();
            until JobTaskRecL.Next() = 0;
        end;
        // Message('CU Jobs Task');
    end;

    procedure InsertJobPlanningLineToArchievedJobPlanningLine(JobRecL: Record Job; VersionNoIntL: Integer)
    var
        JonPlanningLineRecL: Record "Job Planning Line";
        ArchJobPlanningLine: Record "Archieved Job Planning Line";
    begin
        JonPlanningLineRecL.Reset();
        JonPlanningLineRecL.SetRange("Job No.", JobRecL."No.");
        JonPlanningLineRecL.SetRange("Version No.", JobRecL."Version No.");
        if JonPlanningLineRecL.FindSet() then begin
            repeat
                JonPlanningLineRecL.CalcFields("Invoiced Amount (LCY)", "Invoiced Cost Amount (LCY)", "Qty. Transferred to Invoice", "Qty. Invoiced", "Reserved Quantity", "Reserved Qty. (Base)");
                ArchJobPlanningLine.Init();
                ArchJobPlanningLine.Validate("Job No.", JonPlanningLineRecL."Job No.");
                ArchJobPlanningLine.Validate("Job Task No.", JonPlanningLineRecL."Job Task No.");
                ArchJobPlanningLine.Validate("Archieved Version No.", JonPlanningLineRecL."Version No.");

                ArchJobPlanningLine.Validate("Line No.", JonPlanningLineRecL."Line No.");
                ArchJobPlanningLine.Validate("Job No.", JonPlanningLineRecL."Job No.");
                ArchJobPlanningLine.Validate("Planning Date", JonPlanningLineRecL."Planning Date");
                ArchJobPlanningLine.Validate("Document No.", JonPlanningLineRecL."Document No.");
                ArchJobPlanningLine.Validate(Type, JonPlanningLineRecL.Type);
                ArchJobPlanningLine.Validate("No.", JonPlanningLineRecL."No.");
                ArchJobPlanningLine.Validate(Description, JonPlanningLineRecL.Description);
                ArchJobPlanningLine.Validate(Quantity, JonPlanningLineRecL.Quantity);
                ArchJobPlanningLine.Validate("Direct Unit Cost (LCY)", JonPlanningLineRecL."Direct Unit Cost (LCY)");
                ArchJobPlanningLine.Validate("Unit Cost (LCY)", JonPlanningLineRecL."Unit Cost (LCY)");
                ArchJobPlanningLine.Validate("Total Cost (LCY)", JonPlanningLineRecL."Total Cost (LCY)");
                ArchJobPlanningLine.Validate("Unit Price (LCY)", JonPlanningLineRecL."Unit Price (LCY)");
                ArchJobPlanningLine.Validate("Total Price (LCY)", JonPlanningLineRecL."Total Price (LCY)");
                ArchJobPlanningLine.Validate("Resource Group No.", JonPlanningLineRecL."Resource Group No.");
                ArchJobPlanningLine.Validate("Unit of Measure Code", JonPlanningLineRecL."Unit of Measure Code");
                ArchJobPlanningLine.Validate("Location Code", JonPlanningLineRecL."Location Code");
                ArchJobPlanningLine.Validate("Last Date Modified", JonPlanningLineRecL."Last Date Modified");
                ArchJobPlanningLine.Validate("User ID", JonPlanningLineRecL."User ID");
                ArchJobPlanningLine.Validate("Work Type Code", JonPlanningLineRecL."Work Type Code");
                ArchJobPlanningLine.Validate("Customer Price Group", JonPlanningLineRecL."Customer Price Group");
                ArchJobPlanningLine.Validate("Country/Region Code", JonPlanningLineRecL."Country/Region Code");
                ArchJobPlanningLine.Validate("Gen. Bus. Posting Group", JonPlanningLineRecL."Gen. Bus. Posting Group");
                ArchJobPlanningLine.Validate("Gen. Prod. Posting Group", JonPlanningLineRecL."Gen. Prod. Posting Group");
                ArchJobPlanningLine.Validate("Document Date", JonPlanningLineRecL."Document Date");
                ArchJobPlanningLine.Validate("Job Task No.", JonPlanningLineRecL."Job Task No.");
                ArchJobPlanningLine.Validate("Line Amount (LCY)", JonPlanningLineRecL."Line Amount (LCY)");
                ArchJobPlanningLine.Validate("Unit Cost", JonPlanningLineRecL."Unit Cost");
                ArchJobPlanningLine.Validate("Total Cost", JonPlanningLineRecL."Total Cost");
                ArchJobPlanningLine.Validate("Unit Price", JonPlanningLineRecL."Unit Price");
                ArchJobPlanningLine.Validate("Total Price", JonPlanningLineRecL."Total Price");
                ArchJobPlanningLine.Validate("Line Amount", JonPlanningLineRecL."Line Amount");
                ArchJobPlanningLine.Validate("Line Discount Amount", JonPlanningLineRecL."Line Discount Amount");
                ArchJobPlanningLine.Validate("Line Discount Amount (LCY)", JonPlanningLineRecL."Line Discount Amount (LCY)");
                ArchJobPlanningLine.Validate("Cost Factor", JonPlanningLineRecL."Cost Factor");
                ArchJobPlanningLine.Validate("Serial No.", JonPlanningLineRecL."Serial No.");
                ArchJobPlanningLine.Validate("Lot No.", JonPlanningLineRecL."Lot No.");
                ArchJobPlanningLine.Validate("Line Discount %", JonPlanningLineRecL."Line Discount %");
                ArchJobPlanningLine.Validate("Line Type", JonPlanningLineRecL."Line Type");
                ArchJobPlanningLine.Validate("Currency Code", JonPlanningLineRecL."Currency Code");
                ArchJobPlanningLine.Validate("Currency Date", JonPlanningLineRecL."Currency Date");
                ArchJobPlanningLine.Validate("Currency Factor", JonPlanningLineRecL."Currency Factor");
                ArchJobPlanningLine.Validate("Schedule Line", JonPlanningLineRecL."Schedule Line");
                ArchJobPlanningLine.Validate("Contract Line", JonPlanningLineRecL."Contract Line");
                ArchJobPlanningLine.Validate("Job Contract Entry No.", JonPlanningLineRecL."Job Contract Entry No.");
                ArchJobPlanningLine.Validate("Invoiced Amount (LCY)", JonPlanningLineRecL."Invoiced Amount (LCY)");
                ArchJobPlanningLine.Validate("Invoiced Cost Amount (LCY)", JonPlanningLineRecL."Invoiced Cost Amount (LCY)");
                ArchJobPlanningLine.Validate("VAT Unit Price", JonPlanningLineRecL."VAT Unit Price");
                ArchJobPlanningLine.Validate("VAT Line Discount Amount", JonPlanningLineRecL."VAT Line Discount Amount");
                ArchJobPlanningLine.Validate("VAT Line Amount", JonPlanningLineRecL."VAT Line Amount");
                ArchJobPlanningLine.Validate("VAT %", JonPlanningLineRecL."VAT %");
                ArchJobPlanningLine.Validate("Description 2", JonPlanningLineRecL."Description 2");
                ArchJobPlanningLine.Validate("Job Ledger Entry No.", JonPlanningLineRecL."Job Ledger Entry No.");
                ArchJobPlanningLine.Validate(Status, JonPlanningLineRecL.Status);
                ArchJobPlanningLine.Validate("Ledger Entry Type", JonPlanningLineRecL."Ledger Entry Type");
                ArchJobPlanningLine.Validate("Ledger Entry No.", JonPlanningLineRecL."Ledger Entry No.");
                ArchJobPlanningLine.Validate("System-Created Entry", JonPlanningLineRecL."System-Created Entry");
                ArchJobPlanningLine.Validate("Usage Link", JonPlanningLineRecL."Usage Link");
                ArchJobPlanningLine.Validate("Remaining Qty.", JonPlanningLineRecL."Remaining Qty.");
                ArchJobPlanningLine.Validate("Remaining Qty. (Base)", JonPlanningLineRecL."Remaining Qty. (Base)");
                ArchJobPlanningLine.Validate("Remaining Total Cost", JonPlanningLineRecL."Remaining Total Cost");
                ArchJobPlanningLine.Validate("Remaining Total Cost (LCY)", JonPlanningLineRecL."Remaining Total Cost (LCY)");
                ArchJobPlanningLine.Validate("Remaining Line Amount", JonPlanningLineRecL."Remaining Line Amount");
                ArchJobPlanningLine.Validate("Remaining Line Amount (LCY)", JonPlanningLineRecL."Remaining Line Amount (LCY)");
                ArchJobPlanningLine.Validate("Qty. Posted", JonPlanningLineRecL."Qty. Posted");
                ArchJobPlanningLine.Validate("Qty. to Transfer to Journal", JonPlanningLineRecL."Qty. to Transfer to Journal");
                ArchJobPlanningLine.Validate("Posted Total Cost", JonPlanningLineRecL."Posted Total Cost");
                ArchJobPlanningLine.Validate("Posted Total Cost (LCY)", JonPlanningLineRecL."Posted Total Cost (LCY)");
                ArchJobPlanningLine.Validate("Posted Line Amount", JonPlanningLineRecL."Posted Line Amount");
                ArchJobPlanningLine.Validate("Posted Line Amount (LCY)", JonPlanningLineRecL."Posted Line Amount (LCY)");
                ArchJobPlanningLine.Validate("Qty. Transferred to Invoice", JonPlanningLineRecL."Qty. Transferred to Invoice");
                ArchJobPlanningLine.Validate("Qty. to Transfer to Invoice", JonPlanningLineRecL."Qty. to Transfer to Invoice");
                ArchJobPlanningLine.Validate("Qty. Invoiced", JonPlanningLineRecL."Qty. Invoiced");
                ArchJobPlanningLine.Validate("Qty. to Invoice", JonPlanningLineRecL."Qty. to Invoice");
                ArchJobPlanningLine.Validate("Reserved Quantity", JonPlanningLineRecL."Reserved Quantity");
                ArchJobPlanningLine.Validate("Reserved Qty. (Base)", JonPlanningLineRecL."Reserved Qty. (Base)");
                ArchJobPlanningLine.Validate(Reserve, JonPlanningLineRecL.Reserve);
                ArchJobPlanningLine.Validate(Planned, JonPlanningLineRecL.Planned);
                ArchJobPlanningLine.Validate("Variant Code", JonPlanningLineRecL."Variant Code");
                ArchJobPlanningLine.Validate("Bin Code", JonPlanningLineRecL."Bin Code");
                ArchJobPlanningLine.Validate("Qty. per Unit of Measure", JonPlanningLineRecL."Qty. per Unit of Measure");
                ArchJobPlanningLine.Validate("Quantity (Base)", JonPlanningLineRecL."Quantity (Base)");
                ArchJobPlanningLine.Validate("Requested Delivery Date", JonPlanningLineRecL."Requested Delivery Date");
                ArchJobPlanningLine.Validate("Promised Delivery Date", JonPlanningLineRecL."Promised Delivery Date");
                ArchJobPlanningLine.Validate("Planned Delivery Date", JonPlanningLineRecL."Planned Delivery Date");
                ArchJobPlanningLine.Validate("Service Order No.", JonPlanningLineRecL."Service Order No.");
                ArchJobPlanningLine.Validate("Enquiry Item", JonPlanningLineRecL."Enquiry Item");
                ArchJobPlanningLine.Validate("Requisition Qty.", JonPlanningLineRecL."Requisition Qty.");
                ArchJobPlanningLine.Validate("Qty. Enquired", JonPlanningLineRecL."Qty. Enquired");
                ArchJobPlanningLine.Validate("Company Item Description", JonPlanningLineRecL."Company Item Description");
                ArchJobPlanningLine.Insert();
                Commit();
            until JonPlanningLineRecL.Next() = 0;
        end;
        // Message('CU Jobs Planning Line');

    end;


}