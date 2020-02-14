pageextension 50506 "Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
        }
    }
}