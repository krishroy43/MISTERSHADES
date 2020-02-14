tableextension 50053 "Ext. Contact" extends Contact
{
    fields
    {
        field(50000; "Purch. Enquiry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}