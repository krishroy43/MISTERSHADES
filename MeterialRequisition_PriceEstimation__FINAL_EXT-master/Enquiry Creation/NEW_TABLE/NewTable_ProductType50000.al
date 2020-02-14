/*
New Table created for MSME Enquiry Creation CR
*/

table 50000 "Product Type"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(21; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        // Start 27-06-2019
        field(22; "Fabric Type"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // Stop 27-06-2019
        // Start 30-07-2019
        field(23; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // Stop 30-07-2019
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}

