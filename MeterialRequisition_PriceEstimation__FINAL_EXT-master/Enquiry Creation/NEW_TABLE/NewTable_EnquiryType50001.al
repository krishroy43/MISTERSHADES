table 50001 "Enquiry Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Enquiry Type";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Due Date Calculation"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
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