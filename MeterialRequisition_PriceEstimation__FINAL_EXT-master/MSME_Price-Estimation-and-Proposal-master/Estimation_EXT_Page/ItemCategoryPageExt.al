pageextension 50028 "Ext.ItemCategoryCode" extends "Item Category Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Code)
        {
            field("Margin %"; "Margin %")
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