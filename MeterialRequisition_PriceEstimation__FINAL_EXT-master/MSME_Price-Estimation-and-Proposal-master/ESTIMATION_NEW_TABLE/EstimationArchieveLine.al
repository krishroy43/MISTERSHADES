table 50013 "Estimation Archieve Line"
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
            OptionMembers = " ",Fabric,Paint,Steel;

        }
        field(14; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;


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
            trigger OnValidate()
            begin
                if "Row Type" = "Row Type"::Total then
                    Error('Do not specify the Unit price for Row Type: ' + 'Total')
                else
                    "Total Price" := Quantity * "Unit Price";
            end;

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
        field(25; "BOQ Imported"; Boolean)
        {
            DataClassification = ToBeClassified;



        }
        field(26; "Version No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Version No. Disp"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Quote No.", "Line No.", "Version No.", "Drawing Number")
        {
            Clustered = true;
        }


    }

    var

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