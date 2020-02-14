pageextension 50013 "Ext. Transfer Order Subform" extends "Transfer Order Subform"
{
    layout
    {
        addafter("Receipt Date")
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