pageextension 50208 PageExtension50108 extends "Sales Order Subform"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Job Task No."; "Job Task No.")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
    actions
    {
    }
}
