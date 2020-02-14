pageextension 50006 "Ext. Order Processor RC" extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Tasks)
        {
            action("Purchase Enquiry Page")
            {
                ApplicationArea = All;
                RunObject = page "Purch. Enquiry List";
            }
        }
    }

    var
        myInt: Integer;
}

