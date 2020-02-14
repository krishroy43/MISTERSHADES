pageextension 50082 "Sales Journal  Extend SO" extends "Sales Journal"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Document Date_"; "Document Date")
            {
                ApplicationArea = All;
            }
            field("Due Date_"; "Due Date")
            {
                ApplicationArea = All;
            }
            field("Payment Terms Code_"; "Payment Terms Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

    }

    var
        myInt: Integer;
}