pageextension 50096 "Ext. Customer Podting Grp" extends "Customer Posting Groups"
{
    layout
    {
        // Add changes to page layout here
        addafter("Credit Rounding Account")
        {
            field("Advance A/C"; "Advance A/C")
            {
                ApplicationArea = All;
            }
            field("Retention A/C"; "Retention A/C")
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