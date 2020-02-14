pageextension 50346 CurrencyPageExtends extends "Currency Card"
{
    layout
    {
        addlast(General)
        {
            field(CurrencyDescription; CurrencyDescription)
            {
                ApplicationArea = All;
                Caption = 'Currency Description';
            }
            field("Decimal Place Name"; "Decimal Place Name")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}