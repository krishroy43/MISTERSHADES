tableextension 50025 "Ext. Sales & Receivable Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Estimation No."; Code[20])
        {
            TableRelation = "No. Series";
        }

        field(50001; "Sales A/c"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50002; "Item Type"; Option)
        {
            OptionMembers = " ",Fabric,Paint,Steel;
        }
        Field(50003; "Over Head %"; Decimal)
        {


        }
        field(50004; "Margin %"; Decimal)
        {

        }
        field(50005; "Sales Commission A/c No."; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Sales Target Budget"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Budget Name".Name;
        }
        field(50111; "Retention Reversal No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50112; "Dispatch Note No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

}