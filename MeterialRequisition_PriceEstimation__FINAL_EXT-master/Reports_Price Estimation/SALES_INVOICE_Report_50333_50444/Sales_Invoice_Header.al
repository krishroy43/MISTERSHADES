tableextension 50333 "Ext Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(50011; "Work Done"; Decimal)
        {

        }
        field(50506; "Progressive Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

}

tableextension 50334 "Ext Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(50032; Narration; Text[250])
        {

        }
    }
}
