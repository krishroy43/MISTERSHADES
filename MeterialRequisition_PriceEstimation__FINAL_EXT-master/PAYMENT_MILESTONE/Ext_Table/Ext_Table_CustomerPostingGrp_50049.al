
tableextension 50049 "Ext. CustPostGrp" extends "Customer Posting Group"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Advance A/C"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50001; "Retention A/C"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

    var
        myInt: Integer;
}
