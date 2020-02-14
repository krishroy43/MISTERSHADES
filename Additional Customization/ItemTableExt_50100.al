tableextension 50100 ItemExt extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50000; "No. 3"; Code[20])
        {
            Caption = 'No. 2';
            DataClassification = ToBeClassified;
        }
        modify("No. 2")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                "No. 3" := "No. 2";
            end;
        }
    }

    keys
    {
        key(PK2; "No. 3")
        {

        }
    }
    fieldgroups
    {
        addlast(DropDown; "No. 3")
        {

        }
    }

    var
        myInt: Integer;
}