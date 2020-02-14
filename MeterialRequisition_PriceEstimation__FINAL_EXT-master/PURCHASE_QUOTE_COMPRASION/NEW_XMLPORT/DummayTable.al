table 50010 "Import/Export Xmlport"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Drawing number"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Company Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Item desc. and Specification"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Unit of measure"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }



    }

    keys
    {
        key(PK; "Drawing number")
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