pageextension 50114 "Ext Job Task Page" extends "Job Task Lines Subform"
{
    layout
    {
        addafter("Job Task Type")
        {
            field("Task Completed"; "Task Completed")
            {
                ApplicationArea = All;
            }
            field("Completion Date"; "Completion Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Completed By"; "Completed By")
            {
                ApplicationArea = All;
            }
            field("Version No."; "Version No.")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
        // Start 04-07-2019
        modify("Schedule (Total Cost)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Schedule (Total Price)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Usage (Total Cost)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Usage (Total Price)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Contract (Total Cost)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Contract (Total Price)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Contract (Invoiced Price)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Contract (Invoiced Cost)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        // modify("Recognized Sales Amount")
        // {
        //     Visible = HidePlanningLinesAmountFieldsG;
        // }
        // modify("Recognized Costs Amount")
        // {
        //     Visible = HidePlanningLinesAmountFieldsG;
        // }
        // modify("Recognized Sales G/L Amount")
        // {
        //     Visible = HidePlanningLinesAmountFieldsG;
        // }
        // modify("Recognized Costs G/L Amount")
        // {
        //     Visible = HidePlanningLinesAmountFieldsG;
        // }
        modify("Outstanding Orders")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Amt. Rcd. Not Invoiced")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Remaining (Total Cost)")
        {
            Visible = HidePlanningLinesAmountFieldsG;
        }
        modify("Remaining (Total Price)")
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

                    CheckJobStatus();
                end;
            end;
        }
        modify(Description)
        {
            trigger
            OnBeforeValidate()
            begin
                CheckJobStatus();
            end;
        }
        modify("Job Task Type")
        {
            trigger
            OnBeforeValidate()
            begin
                CheckJobStatus();
            end;
        }


        // Stop 04-07-2019

    }
    // Start 04-07-2019
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

        // if "Version No." = 0 then begin
        //     "Version No." := 1;
        //     Modify();
        // end;
    end;
    // Stop 04-07-2019

    // Start 24-07-2019
    // trigger
    // OnModifyRecord(): Boolean
    // var
    //     JobRecL: Record Job;
    // begin
    //     JobRecL.Reset();
    //     if JobRecL.Get("Job No.") then
    //         if JobRecL."Workflow Status" = JobRecL."Workflow Status"::Released then
    //             //Error('Status must be Open');
    // end;
    // Stop 24-07-2019
    // Start 25-07-2019
    procedure CheckJobStatus()
    var
        JobRecL: Record Job;
    begin
        JobRecL.Reset();
        if JobRecL.Get("Job No.") then
            if JobRecL."Workflow Status" = JobRecL."Workflow Status"::Released then
                Error('Status must be Open');
    end;
    // stop 25-07-2019

}