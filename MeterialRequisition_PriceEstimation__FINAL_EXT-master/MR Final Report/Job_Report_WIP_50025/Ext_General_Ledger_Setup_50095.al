tableextension 50059 "Ext Gen. Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "WIP Account"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Site Status Doc No."; code[20])
        {
            TableRelation = "No. Series";
        }
        field(50101; "Site Status Released Doc No."; Code[20])
        {
            TableRelation = "No. Series";
        }

    }
}

pageextension 50095 "Ext Gen. Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addlast(Reporting)
        {
            field("WIP Account"; "WIP Account")
            {
                ApplicationArea = All;
            }
        }
        addafter("Max. Payment Tolerance Amount")
        {
            field("Site Status Doc No."; "Site Status Doc No.")
            {
                ApplicationArea = All;
            }
            field("Site Status -Released Doc No."; "Site Status Released Doc No.")
            {
                ApplicationArea = All;
            }
        }
    }
}