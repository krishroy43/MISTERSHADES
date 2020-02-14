pageextension 50090 "Ext Sales Quote Subform" extends "Sales Quote Subform"
{
    layout
    {
        addafter(Type)
        {
            field("Drawing No."; "Drawing No.")
            {
                ApplicationArea = All;
            }
            //added additional field option on 21 dec 2019 
            field(Option; Option)
            {
                ApplicationArea = All;
            }
        }
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