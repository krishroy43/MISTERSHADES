page 50045 "Std Term Condition Description"
{
    Caption = 'Standard Term & Condition';
    pageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Std Term & Condition Descp";

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                    //Visible = false;
                    Editable = false;
                }
                field("Term/Condition"; "Term/Condition")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }

    }
}