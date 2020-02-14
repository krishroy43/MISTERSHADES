tableextension 50023 "Ext. Vendor" extends Vendor
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