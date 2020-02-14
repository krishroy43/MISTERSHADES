table 50020 "Std Term & Condition Descp"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Document Type"; Option)
        {
            //OptionMembers = " ","Sales Quote","Sales Order","Sales Invoice","Sales Credit Memo","Sales Blanket Order","Sales Return Order","Purch. Quote","Purch. Order","Purch. Invoice","Purch. Credit Memo","Purch. Blanket Order","Purch. Return Order";
            OptionMembers = "Sales Quote";
        }
        field(3; "Term/Condition"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text" where ("Term/Condition" = const (true));
            Caption = 'Terms Code';
        }
        field(4; "Description"; Text[80])
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            begin
                if ("Term/Condition" = '') then begin
                    Error('Document Type or Term & Condition Code must not blank');
                end;

            end;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}