// Start 04-07-2019
pageextension 50188 "Ext Job Planning Line" extends "Job Planning Lines"
{
    layout
    {
        addafter("Job Task No.")
        {
            field("Drawing No."; "Drawing No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Qty. to Transfer to Invoice")
        {
            // Start 07.05.2019
            //New field added to check Requisition Line Qty for each line
            field("Requisition Qty."; "Requisition Qty.")
            {
                ApplicationArea = All;
                trigger
                OnDrillDown()
                var
                    MRListPageL: Page "Material Requisition List Page";
                    MRListRecL: Record "Material Requisition Line";
                begin
                    Clear(MRListRecL);
                    MRListRecL.Reset();
                    MRListRecL.SetRange("Job No.", "Job No.");
                    MRListRecL.SetRange("Job task No.", "Job Task No.");
                    MRListRecL.SetRange("Job Planning Line No.", "Line No.");
                    MRListRecL.SetFilter("Qty. to Enquiry", '<>%1', 0);
                    if MRListRecL.FindSet() then
                        Page.RunModal(50026, MRListRecL);
                end;
            }
            field("Version No."; "Version No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Qty. Enquired"; "Qty. Enquired")
            {
                ApplicationArea = All;
                trigger
                OnDrillDown()
                var
                    PELinesRecL: Record "Purch. Enquiry Line";
                begin
                    Clear(PELinesRecL);
                    PELinesRecL.Reset();
                    PELinesRecL.SetRange("Job No.", "Job No.");
                    PELinesRecL.SetRange("Job task No.", "Job Task No.");
                    PELinesRecL.SetRange("Job Planning Line No.", "Line No.");
                    PELinesRecL.SetFilter(Quantity, '<>%1', 0);
                    if PELinesRecL.FindSet() then
                        Page.RunModal(50025, PELinesRecL);
                end;
            }
            // Stop 07.05.2019
        }
        modify("Unit Cost")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Unit Cost (LCY)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Unit Price")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Unit Price (LCY)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Total Cost")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Total Cost (LCY)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Line Amount")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Line Amount (LCY)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Job Task No.")
        {
            trigger
            OnAfterValidate()
            var
                JobRec: Record Job;
            begin
                if JobRec.Get("Job No.") then begin
                    "Version No." := JobRec."Version No.";

                end;
            end;
        }

    }

    var
        UserSetupRecG: Record "User Setup";
        HidePlanningLinesAmountFieldsG: Boolean;

    trigger
    OnOpenPage()
    begin
        HidePlanningLinesAmountFieldsG := false;
        UserSetupRecG.Reset();
        if UserSetupRecG.Get(UserId) then
            if Not UserSetupRecG."Job Planning Lines Fields" then
                HidePlanningLinesAmountFieldsG := true
            else
                HidePlanningLinesAmountFieldsG := false;



    end;

    // Start 24-07-2019
    trigger
    OnModifyRecord(): Boolean
    var
        JobRecL: Record Job;
    begin
        JobRecL.Reset();
        if JobRecL.Get("Job No.") then
            if JobRecL."Workflow Status" = JobRecL."Workflow Status"::Released then
                Error('Status must be Open');
    end;
    // Stop 24-07-2019
}

// Stop 04-07-2019