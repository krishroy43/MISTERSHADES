pageextension 50015 "Ext. Posted Trans Shpt Subform" extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
            }
            field("Job description"; "Job description")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Job Task No"; "Job Task No")
            {
                ApplicationArea = All;
            }
            field("Job Task Description"; "Job Task Description")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Requisition No."; "Requisition No.")
            {
                ApplicationArea = All;
            }
        }
    }


}