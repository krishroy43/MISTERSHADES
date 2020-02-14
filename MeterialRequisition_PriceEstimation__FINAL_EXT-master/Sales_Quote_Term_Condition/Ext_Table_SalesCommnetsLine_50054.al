tableextension 50054 "Ext Sales Commnets Line" extends "Sales Comment Line"
{
    fields
    {
        field(50000; "Term/Condition"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text" where("Term/Condition" = const(true));
            Caption = 'Terms Code';
            trigger
            OnValidate()
            var
                SalesQuoteRecL: Record "Sales Header";
            begin
                SalesQuoteRecL.Reset();
                if SalesQuoteRecL.Get("Document Type", "No.") then begin
                    if (SalesQuoteRecL.Status = SalesQuoteRecL.Status::Released) then
                        Error('Sales Quote Status Should be Open');
                end;
                Date := SalesQuoteRecL."Document Date";

            end;
        }
        //Additonal field for desc with 250 char
        field(50001; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger
    OnBeforeInsert()
    var
        SalesQuoteRecL: Record "Sales Header";
    begin
        SalesQuoteRecL.Reset();
        if SalesQuoteRecL.Get("Document Type", "No.") then begin
            if (SalesQuoteRecL.Status = SalesQuoteRecL.Status::Released) then
                Error('Sales Quote Status Should be Open');
        end;
    end;
}


