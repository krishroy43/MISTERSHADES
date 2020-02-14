tableextension 50033 "Ext Comment Line" extends "Comment Line"
{
    fields
    {
        field(50000; "Term/Condition"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text" where("Term/Condition" = const(true));
            Caption = 'Terms Code';
        }
    }

    var
        myInt: Integer;
}

pageextension 50038 "Ext. Comment Line" extends "Comment Sheet"
{
    Caption = 'Term & Condition';
    layout
    {
        //addafter(Comment)
        addbefore(Date)
        {
            field("Term/Condition"; "Term/Condition")
            {
                ApplicationArea = All;
            }
        }
        modify(Comment)
        {
            Caption = 'Description';
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}

pageextension 50091 "Ext Job List" extends "Job List"
{
    layout
    {
        //modify()
        addafter("Bill-to Customer No.")
        {
            field("Bill-to Name"; "Bill-to Name")
            {
                ApplicationArea = All;
            }
        }
    }

}