tableextension 50037 "Ext Currency Tab" extends Currency
{
    fields
    {
        field(50000; CurrencyDescription; Text[50])
        {

            DataClassification = ToBeClassified;
        }
        field(50001; "Decimal Place Name"; Code[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub Currency';
        }
    }

    var
        myInt: Integer;
}