pageextension 50083 "Ext Bank Account Card" extends "Bank Account Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Check Report ID"; "Check Report ID")
            {
                ApplicationArea = All;
            }
            field("Check Report Name"; "Check Report Name")
            {
                ApplicationArea = All;
            }
        }

    }
}