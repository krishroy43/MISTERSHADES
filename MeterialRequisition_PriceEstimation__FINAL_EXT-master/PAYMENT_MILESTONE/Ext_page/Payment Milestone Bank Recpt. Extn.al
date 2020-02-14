pageextension 50078 "Payment Milestone Bank Recpt" extends "Cash Receipt Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Posting Type"; "Posting Type")
            {
                ApplicationArea = All;
            }
            // Start 09-07-2019
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
            // Start 09-07-2019
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}