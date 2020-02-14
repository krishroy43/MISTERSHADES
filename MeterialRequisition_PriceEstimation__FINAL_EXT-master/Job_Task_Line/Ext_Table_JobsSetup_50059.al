tableextension 50061 "Ext Jobs Setup" extends "Jobs Setup"
{
    fields
    {
        field(50000; "Completion Date Calc."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        // Start 01-07-2019
        field(50001; "Project Dimension"; Code[50])
        {
            TableRelation = Dimension;
        }
        // Stop 01-07-2019
    }
}