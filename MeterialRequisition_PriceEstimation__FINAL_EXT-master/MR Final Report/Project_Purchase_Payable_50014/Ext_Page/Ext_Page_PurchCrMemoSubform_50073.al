pageextension 50073 "Ext Purch. Credit Memo subform" extends "Purch. Cr. Memo Subform"
{
    layout
    {

        addafter("Job Task No.")
        {
            field("Appl-to Item Entry"; "Appl.-to Item Entry")
            {
                ApplicationArea = All;
            }

        }
    }
}