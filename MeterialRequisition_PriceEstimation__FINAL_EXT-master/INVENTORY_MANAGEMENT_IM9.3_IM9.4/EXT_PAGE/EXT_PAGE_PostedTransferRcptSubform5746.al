pageextension 50017 "Ext. Posted Trans Rcpt Subform" extends "Posted Transfer Rcpt. Subform"
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