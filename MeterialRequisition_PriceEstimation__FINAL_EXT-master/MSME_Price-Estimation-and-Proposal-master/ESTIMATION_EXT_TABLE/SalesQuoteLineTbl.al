tableextension 50026 SalesQuoteLineExt extends "Sales Line"
{
    fields
    {
        field(50000; Estimations; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50001; "Drawing No."; Text[100])
        {
            DataClassification = ToBeClassified;
            //Caption = ' Customer Drawing Details';
        }
        // Start 27-08-2019
        field(50032; Narration; Text[250])
        {

        }

        // Stop 27-08-2019
        //Added an additional field for sales quote sub form - Option text
        field(50033; Option; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger
            OnAfterValidate()
            begin
                if ("Job No." <> '') or ("Job Task No." <> '') then begin
                    Clear("Job Task No.");
                    Clear("Job No.");
                end;
            end;
        }
    }

    var
        myInt: Integer;
}