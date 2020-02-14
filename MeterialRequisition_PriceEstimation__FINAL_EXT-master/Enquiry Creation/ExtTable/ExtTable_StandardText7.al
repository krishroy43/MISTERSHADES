tableextension 50032 "Ext. Standard Text" extends "Standard Text"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Term/Condition"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    var
        myInt: Integer;
}

pageextension 50037 "Ext Standard Text Codes" extends "Standard Text Codes"
{
    layout
    {
        addafter(Description)
        {
            field("Term/Condition"; "Term/Condition")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}