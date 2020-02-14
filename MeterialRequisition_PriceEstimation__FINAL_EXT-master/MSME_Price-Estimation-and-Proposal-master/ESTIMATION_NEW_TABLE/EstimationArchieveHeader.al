table 50012 "Estimation Archieve Header"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Estimation Archieve List";


    fields
    {
        field(10; "Quote No."; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Estimation No."; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Estimation Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Version No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Estimated Qty."; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(15; "Total Qty."; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Rate per Sq.M"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(17; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released;

        }
        field(18; "Version No. Disp"; Integer)
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(PK; "Version No.", "Quote No.")
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