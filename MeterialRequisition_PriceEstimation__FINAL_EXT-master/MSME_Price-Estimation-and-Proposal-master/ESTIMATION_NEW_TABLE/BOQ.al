table 50008 "BOQ Tbl"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Quote No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Sales Header" where ("Document Type" = FILTER (Quote));

        }
        field(11; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Row Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Line,Total;

        }
        field(13; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Fabrication,Paint;

        }
        field(14; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;


        }

        field(15; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Description 2"; Text[250])
        {
            DataClassification = ToBeClassified;

        }

        field(17; "Length Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","3","6";

        }
        field(18; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Drawing Number"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(20; "Company Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(21; "Company Item Description"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(22; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(23; "Total Price"; Decimal)
        {
            DataClassification = ToBeClassified;


        }
        field(24; "Unit Of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";


        }
        field(25; "Version No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        // Start 16-07-2019
        field(26; "Job Task"; Code[20])
        {
            Caption = 'Job Task';
            TableRelation = "Job Task Master";
            DataClassification = ToBeClassified;
        }
        // Stop 16-07-2019
        // Start 15-Aug-2019
        field(27; "Estimated Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Total Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        // Stop 15-Aug-2019
    }

    keys
    {
        key(PK; "Drawing Number", "Line No.")
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