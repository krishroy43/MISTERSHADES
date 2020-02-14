tableextension 50030 PurchaseQline extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Brand; Text[250])
        { }
        field(50001; "Average Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger
            OnAfterValidate()
            var
                RecItem: Record Item;
            begin
                //Message('line %1', "Document No.");
                // // PurchHeaderRecG.Reset();
                // // PurchHeaderRecG.Get("Document Type", "Document No.");
                // // "Job No." := PurchHeaderRecG."Job No.";
                // // "Job Task No." := PurchHeaderRecG."Job Task No.";
                // // Validate("Job No.", PurchHeaderRecG."Job No.");
                // // Validate("Job Task No.", PurchHeaderRecG."Job Task No.");
                //Modify();
                Clear(RecItem);
                if Type = Type::Item then begin
                    if RecItem.GET("No.") then begin
                        "Average Unit Cost" := RecItem."Unit Cost";
                    end;
                end;
            end;
        }


    }

    var
        myInt: Integer;
        PurchHeaderRecG: Record "Purchase Header";

    trigger
    OnAfterInsert()
    begin


    end;
}