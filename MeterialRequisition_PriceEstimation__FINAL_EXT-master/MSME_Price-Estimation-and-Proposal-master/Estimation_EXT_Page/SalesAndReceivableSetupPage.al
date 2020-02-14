
pageextension 50029 "Ext. Sales & Recei Setup Page" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here

        addlast("Number Series")
        {
            field("Estimation No."; "Estimation No.")
            {
                Visible = true;
                Importance = Promoted;
                ApplicationArea = All;
                Caption = 'Estimation Nos.';

            }
            field("Dispatch Note No. Series"; "Dispatch Note No. Series")
            {
                ApplicationArea = All;
            }
        }
        addlast("Number Series")
        {
            field("Retention Reversal No."; "Retention Reversal No.")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Sales A/c"; "Sales A/c")
            {
                ApplicationArea = All;
            }
            field("Item Type"; "Item Type")
            {
                ApplicationArea = all;
            }
            Field("Over Head %"; "Over Head %")
            {
                ApplicationArea = all;


            }
            field("Margin %"; "Margin %")
            {
                ApplicationArea = all;
            }
            field("Sales Commission A/c No."; "Sales Commission A/c No.")
            {
                ApplicationArea = All;
                TableRelation = "G/L Account";
            }
            field("Sales Target Budget"; "Sales Target Budget")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {


    }

    var


}