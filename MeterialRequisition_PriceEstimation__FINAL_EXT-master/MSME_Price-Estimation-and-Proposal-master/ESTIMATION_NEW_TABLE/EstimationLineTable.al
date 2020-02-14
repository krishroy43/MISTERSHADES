table 50007 "Estimation Line Tbl"
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
            trigger
            OnValidate()
            var
            begin
                If ("Row Type" = "Row Type"::Line) and ("Item Type" <> "Item Type"::" ") then begin
                    EstimationRec.Reset();
                    EstimationRec.SetRange("Row Type", EstimationRec."Row Type"::Total);
                    EstimationRec.SetRange("Drawing Number", Rec."Drawing Number");
                    EstimationRec.SetRange("Item Type", Rec."Item Type");
                    If EstimationRec.FindFirst() then begin
                        //Quantity := EstimationRec.Quantity;
                        validate(Quantity, EstimationRec.Quantity);
                        //"Estimated Qty." := EstimationRec."Estimated Qty.";
                        //"Total Qty." := EstimationRec."Total Qty.";
                    end;
                end;
                if ("Item Type" = "Item Type"::" ") AND ("Row Type" = "Row Type"::Line) then begin
                    Clear(Quantity);
                end
            end;
        }
        field(14; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
            trigger OnValidate()
            var
                myInt: Integer;
                ItemRec: Record Item;
                ItemCatRecL: Record "Item Category";
                ItemRecL: Record Item;
                EstimationRec_1: Record "Estimation Line Tbl";
            begin
                // Start 23-08-2019
                EstimationRec_1.Reset();
                EstimationRec_1.SetRange("Drawing Number", "Drawing Number");
                EstimationRec_1.SetRange("Quote No.", "Quote No.");
                EstimationRec_1.SetRange("Version No.", "Version No.");
                if EstimationRec_1.FindFirst() then begin
                    "Estimated Qty." := EstimationRec_1."Estimated Qty.";
                    "Total Qty." := EstimationRec_1."Total Qty.";
                end;
                // Start 23-08-2019
                // // ItemRec.Reset();
                // // If ItemRec.Get("Item Code") then begin
                // //     // // Description := ItemRec.Description;
                // //     // // "Unit Of Measure" := ItemRec."Base Unit of Measure";
                // //     // // "Description 2" := ItemRec."Description 2";
                // //     //Modify();
                // // End;

                //if ("Unit Price" <> xRec."Unit Price") then begin
                If ("Row Type" = "Row Type"::Line) then begin//and ("Item Type" = "Item Type"::" ")
                    if ItemRecL.get("Item Code") then begin
                        if ItemCatRecL.Get(ItemRecL."Item Category Code") then begin
                            if ItemCatRecL."Margin %" > 0 then
                                "Unit Price" := ItemRecL."Unit Cost" + ((ItemRecL."Unit Cost" * ItemCatRecL."Margin %") / 100)
                            else
                                "Unit Price" := ItemRecL."Unit Cost";
                        end
                        else
                            "Unit Price" := ItemRecL."Unit Cost";

                        Description := ItemRecL.Description;
                        "Unit Of Measure" := ItemRecL."Base Unit of Measure";
                        "Description 2" := ItemRecL."Description 2";
                        "Total Price" := Quantity * "Unit Price";
                    end;
                end;

                // // // // // Clear(UnitCost);
                // // // // // If ("Row Type" = "Row Type"::Line) and ("Item Type" <> "Item Type"::" ") then begin// AND ("Drawing Number" <> ' ') 
                // // // // //     EstimationRec.Reset();
                // // // // //     EstimationRec.SetRange("Row Type", EstimationRec."Row Type"::Total);
                // // // // //     EstimationRec.SetRange("Drawing Number", Rec."Drawing Number");
                // // // // //     EstimationRec.SetRange("Item Type", Rec."Item Type");
                // // // // //     If EstimationRec.FindFirst() then begin
                // // // // //         Quantity := EstimationRec.Quantity;
                // // // // //         itemRec.Reset();
                // // // // //         IF itemRec.Get("Item Code") then begin
                // // // // //             itemCategoryCodeRec.Reset();
                // // // // //             if itemCategoryCodeRec.Get(ItemRec."Item Category Code") then begin
                // // // // //                 if itemCategoryCodeRec."Margin %" <> 0 then
                // // // // //                     UnitCost := ItemRec."Unit Price" + (ItemRec."Unit Price" * (itemCategoryCodeRec."Margin %" / 100))
                // // // // //                 Else
                // // // // //                     UnitCost := ItemRec."Unit Price";
                // // // // //             End;
                // // // // //             "Unit Price" := UnitCost;
                // // // // //             "Total Price" := Quantity * UnitCost;
                // // // // //             "Unit Of Measure" := ItemRec."Base Unit of Measure";
                // // // // //         END;
                // // // // //     end;
                // // // // // end;
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
            // Start 04-09-2019
            trigger
            OnValidate()
            begin
                "Total Price" := Quantity * "Unit Price";
            end;
            // Stop 04-09-2019

        }
        field(19; "Drawing Number"; Text[250])
        {
            DataClassification = ToBeClassified;
            // Start 30-08-2019
            trigger
            OnValidate()
            var
                EstimationLineTblRecL: Record "Estimation Line Tbl";
                EstimationLineTblRec2L: Record "Estimation Line Tbl";
                EstimationHeaderRec: Record "Estimation Header";
            begin
                //Message('Dr %1  Ver  %2', "Drawing Number", xRec."Version No.");

                EstimationLineTblRecL.Reset();
                EstimationLineTblRecL.SetRange("Drawing Number", "Drawing Number");
                EstimationLineTblRecL.SetRange("Version No.", xRec."Version No.");
                if EstimationLineTblRecL.FindFirst() then begin
                    "Estimated Qty." := EstimationLineTblRecL."Estimated Qty.";
                    "Total Qty." := EstimationLineTblRecL."Total Qty.";
                    "Version No." := EstimationLineTblRecL."Version No.";
                end
                else begin
                    EstimationHeaderRec.Reset();
                    EstimationHeaderRec.SetRange("Quote No.", "Quote No.");
                    //EstimationLineTblRec2L.SetRange("Version No.", xRec."Version No.");
                    if EstimationHeaderRec.FindFirst() then
                        "Version No." := EstimationHeaderRec."Version No.";
                end;


            end;
            // Stop 30-08-2019

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
            var
                myInt: Integer;
                ItemCatRecL: Record "Item Category";
                ItemRecL: Record Item;
            begin
                "Total Price" := Quantity * "Unit Price";

                // Start 01-07-2019

                /*
                if ("Unit Price" <> xRec."Unit Price") then begin
                    "Price updated" := true;
                    if ItemRecL.get("Item Code") then
                        if ItemCatRecL.Get(ItemRecL."Item Category Code") then
                            "Unit Price" := ItemRecL."Unit Cost" + ((ItemRecL."Unit Cost" * ItemCatRecL."Margin %") / 100);
                end; */
                // Stop 01-07-2019

            end;

        }
        field(23; "Total Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Unit Of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Unit of Measure";
            TableRelation = IF ("Item Code" = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("Item Code"));



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
        // Start Creating new field for creating Job through Sales Quote.
        field(28; "Job Task"; Code[20])
        {
            Caption = 'Job Task';
            TableRelation = "Job Task Master" where ("Job Task Type" = const (Posting));
        }

        // Stop Creating new field for creating Job through Sales Quote.
        // Start 01-07-2019
        field(29; "Price updated"; Boolean)
        {
            Editable = false;
        }
        // Stop 01-07-2019
        // Start 02-067-2019
        field(30; "Estimated Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            ////Editable = false;
        }
        field(31; "Total Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            /////Editable = false;
        }
        // Stop 02-07-2019

    }

    keys
    {
        key(PK; "Quote No.", "Drawing Number", "Version No. Disp", "Line No.")
        {
            Clustered = true;
        }
        Key(Secondary; "Quote No.", "Drawing Number", "Line No.")
        {
            Enabled = true;
        }


    }

    var
        EstimationRec: Record "Estimation Line Tbl";
        itemRec: Record Item;
        itemCategoryCodeRec: Record "Item Category";
        UnitCost: Decimal;

    trigger OnInsert()
    var

    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        EstmationHeaderRecL: Record "Estimation Header";
    begin
        EstmationHeaderRecL.Reset();
        EstmationHeaderRecL.SetRange("Quote No.", "Quote No.");
        EstmationHeaderRecL.SetRange("Version No. Disp", "Version No. Disp");
        if EstmationHeaderRecL.FindSet() then
            if EstmationHeaderRecL.Status <> EstmationHeaderRecL.Status::Open then
                Error('Status must be Open.');

    end;

    trigger OnRename()
    begin

    end;

}