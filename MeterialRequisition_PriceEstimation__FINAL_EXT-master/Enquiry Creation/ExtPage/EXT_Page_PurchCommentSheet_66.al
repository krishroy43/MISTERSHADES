pageextension 50049 "Ext Purch. Comment Sheet" extends "Purch. Comment Sheet"
{
    Caption = 'Tems & Condition';
    layout
    {
        addbefore(Date)
        {
            field("Term/Condition"; "Term/Condition")
            {
                ApplicationArea = All;
            }
        }

        modify(Comment)
        {
            Caption = 'Description';
        }
    }

}

