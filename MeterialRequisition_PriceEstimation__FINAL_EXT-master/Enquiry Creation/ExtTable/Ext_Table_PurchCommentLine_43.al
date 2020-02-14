tableextension 50038 "Ext Purch Comment Line" extends "Purch. Comment Line"
{
    fields
    {
        field(50000; "Term/Condition"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text" where ("Term/Condition" = const (true));
            Caption = 'Terms Code';
        }
    }
}