codeunit 50006 "Process"
{
    trigger OnRun()
    begin
        Clear(DrawingNumber);
        BOQRec.Reset();
        BOQRec.SetFilter("Quote No.", '<>%1', ' ');
        If BOQRec.FindSet then begin
            repeat
                EstimationRec.Reset();
                EstimationRec.SetRange("Drawing Number", BOQRec."Drawing Number");
                EstimationRec.SetRange("Line No.", BOQRec."Line No.");
                //EstimationRec.SetRange();
                if EstimationRec.FindFirst then begin
                    if DrawingNumber <> BOQRec."Drawing Number" then begin
                        if EstimationRec."Quote No." <> BOQRec."Quote No." then
                            Error('BOQ Details with Drawing Number %1 is already present in Sales quote %2', BOQRec."Drawing Number", EstimationRec."Quote No.")
                        else
                            UpdateEstimation(BOQRec);

                    end else
                        UpdateEstimation(BOQRec);
                end else
                    CreateEstimation(BOQRec);


                DrawingNumber := BOQRec."Drawing Number";


            until BOQRec.next = 0;
        end;
    end;

    procedure UpdateEstimation(Var BOQUpdateRec: Record "BOQ Tbl")
    var
        myInt: Integer;
        ItemUOMRecL: Record "Item Unit of Measure";
    begin
        EstimationREC_1.Reset();
        EstimationREC_1.SetRange("Drawing Number", BOQRec."Drawing Number");
        EstimationREC_1.SetRange("Quote No.", BOQRec."Quote No.");
        EstimationREC_1.SetRange("Line No.", BOQRec."Line No.");
        if EstimationREC_1.FindFirst then begin
            EstimationREC_1."Row Type" := BOQUpdateRec."Row Type";
            EstimationREC_1."Line No." := BOQUpdateRec."Line No.";
            EstimationREC_1.Validate("Company Item Code", BOQUpdateRec."Company Item Code");
            ItemRec.Reset();
            ItemRec.SetRange("No. 2", EstimationREC_1."Company Item Code");
            //ItemRec.GET(EstimationREC_1."Company Item Code");
            if ItemRec.FindFirst() then begin
                EstimationREC_1."Item Code" := ItemRec."No.";
                EstimationREC_1.Description := ItemRec.Description;
                EstimationREC_1."Description 2" := ItemRec."Description 2";
                itemCategoryCodeRec.Reset();
                if itemCategoryCodeRec.Get(ItemRec."Item Category Code") then begin
                    if itemCategoryCodeRec."Margin %" <> 0 then
                        UnitCost := ItemRec."Unit Cost" + (ItemRec."Unit Cost" * (itemCategoryCodeRec."Margin %" / 100))
                    Else
                        UnitCost := ItemRec."Unit Cost";
                End
                // Start 05-09-2019
                else
                    UnitCost := ItemRec."Unit Cost";
                // Start 05-0-2019

                ItemUOMRecL.Reset();
                if ItemUOMRecL.Get(ItemRec."No.", BOQUpdateRec."Unit Of Measure") then
                    EstimationREC_1.Validate("Unit Of Measure", BOQUpdateRec."Unit Of Measure")
                else
                    Error('The Field Unit Of Measure of table Estimation Line Tbl Contains a value %1 for the Item-Code %2 in the related table', BOQUpdateRec."Unit Of Measure", BOQUpdateRec."Company Item Code");

            end
            else
                if EstimationREC_1."Row Type" = EstimationREC_1."Row Type"::Line then
                    Error('Company code %1 specified in BoQ doesnt matches with Item No.-2 or Its is Blank ', EstimationREC_1."Company Item Code");

            EstimationREC_1."Company Item Description" := BOQUpdateRec.Description;


            EstimationREC_1."Length Type" := BOQUpdateRec."Length Type";
            EstimationREC_1.Quantity := BOQUpdateRec.Quantity;
            EstimationREC_1."Drawing Number" := BOQUpdateRec."Drawing Number";
            EstimationREC_1."Total Price" := UnitCost * BOQUpdateRec.Quantity;
            EstimationREC_1."Version No." := BOQUpdateRec."Version No.";
            //EstimationREC_1."Version No. Disp" := BOQUpdateRec."Version No.";
            EstimationREC_1."Version No. Disp" := 1;
            // Stat 18-07-2019
            EstimationREC_1."Job Task" := BOQUpdateRec."Job Task";
            // Stop 18-07-2019
            // Start 15-Aug-2019
            EstimationREC_1."Estimated Qty." := BOQUpdateRec."Estimated Qty.";
            EstimationREC_1."Total Qty." := BOQUpdateRec."Total Qty.";
            // Stop 15-Aug-2019
            // Start 15-09-2019
            EstimationREC_1."Price updated" := false;
            // Stop 15-09-2019
            EstimationREC_1.Modify();
        end;
    End;

    local procedure CreateEstimation(Var BOQUpdateRec: Record "BOQ Tbl")
    var
        myInt: Integer;
        ItemUOMRecL: Record "Item Unit of Measure";
    begin
        EstimationREC_1.Init();
        EstimationREC_1."Quote No." := BOQUpdateRec."Quote No.";
        EstimationREC_1."Row Type" := BOQUpdateRec."Row Type";
        EstimationREC_1."Line No." := BOQUpdateRec."Line No.";
        EstimationREC_1.Validate("Company Item Code", BOQUpdateRec."Company Item Code");
        Clear(UnitCost);
        ItemRec.Reset();
        ItemRec.SetRange("No. 2", EstimationREC_1."Company Item Code");
        //ItemRec.GET(EstimationREC_1."Company Item Code");
        if ItemRec.FindFirst() then begin
            EstimationREC_1."Item Code" := ItemRec."No.";
            EstimationREC_1.Description := ItemRec.Description;
            EstimationREC_1."Description 2" := ItemRec."Description 2";
            itemCategoryCodeRec.Reset();
            if itemCategoryCodeRec.Get(ItemRec."Item Category Code") then begin
                if itemCategoryCodeRec."Margin %" <> 0 then
                    UnitCost := ItemRec."Unit Cost" + (ItemRec."Unit Cost" * (itemCategoryCodeRec."Margin %" / 100))
                Else
                    UnitCost := ItemRec."Unit Cost";
            End
            // Start 05-09-2019
            else
                UnitCost := ItemRec."Unit Cost";
            // Stop 05-09-2019

            ItemUOMRecL.Reset();
            if ItemUOMRecL.Get(ItemRec."No.", BOQUpdateRec."Unit Of Measure") then
                EstimationREC_1.Validate("Unit Of Measure", BOQUpdateRec."Unit Of Measure")
            else
                Error('The Field Unit Of Measure of table Estimation Line Tbl Contains a value %1 for the item-Code %2 in the related table', BOQUpdateRec."Unit Of Measure", BOQUpdateRec."Company Item Code");

        end
        else
            if EstimationREC_1."Row Type" = EstimationREC_1."Row Type"::Line then
                Error('Company code %1 specified in BoQ doesnt matches with Item No.-2 or Its is Blank ', EstimationREC_1."Company Item Code");

        // EstimationREC_1."Unit Price" := UnitCost;
        // Start 05-09-2019

        EstimationREC_1."Company Item Description" := BOQUpdateRec.Description;
        //EstimationREC_1.Validate("Unit Of Measure", BOQUpdateRec."Unit Of Measure");

        EstimationREC_1."Length Type" := BOQUpdateRec."Length Type";
        If EstimationREC_1."Length Type" = EstimationREC_1."Length Type"::"3" then
            EstimationREC_1.Quantity := BOQUpdateRec.Quantity / 2
        else
            EstimationREC_1.Quantity := BOQUpdateRec.Quantity;
        EstimationREC_1."Drawing Number" := BOQUpdateRec."Drawing Number";
        EstimationREC_1."Total Price" := UnitCost * BOQUpdateRec.Quantity;
        EstimationRec_1."BOQ Imported" := true;
        EstimationREC_1."Version No." := BOQUpdateRec."Version No.";
        //EstimationREC_1."Version No. Disp" := BOQUpdateRec."Version No.";
        EstimationREC_1."Version No. Disp" := 1;
        // Start 01-07-2019
        EstimationREC_1."Price updated" := false;
        // Stop 01-07-2019
        // Start 18-07-2019
        EstimationREC_1."Job Task" := BOQUpdateRec."Job Task";
        // Stop 18-07-2019
        // Start 15-Aug-2019
        EstimationREC_1."Estimated Qty." := BOQUpdateRec."Estimated Qty.";
        EstimationREC_1."Total Qty." := BOQUpdateRec."Total Qty.";
        // Stop 15-Aug-2019
        // Vlidating Unit Price
        EstimationREC_1.Validate("Unit Price", UnitCost);
        // Stop 05-09-2019

        EstimationREC_1.Insert();

    end;

    //SALES Quote Line creation from Estimation
    procedure SalesQuoteLineCreate(Var QuoteNo: Code[20]; VersionNo: Integer)
    var
        EstimationTblRec: Record "Estimation Line Tbl";
        EstimationTblRec_1: Record "Estimation Line Tbl";
        EstimationHdrRec: Record "Estimation Header";
        DrawingNumberQ: Code[20];
        TotalPrice: Decimal;
        SalesLineRec: Record "Sales Line";
        SalesLine_Rec: Record "Sales Line";
        LineNo: Integer;
        SalesHdrRec: Record "Sales Header";
        OverHeadPercent: Decimal;
        MarginPercent: Decimal;
        EstimatedQty: Decimal;
        UnitPriceInit: Decimal;
        UnitPrice1: Decimal;
        UnitPriceFinal: Decimal;
        SalesLineQty: Decimal;
        SalesLine_Rec_1: Record "Sales Line";
    begin
        Clear(DrawingNumberQ);
        Clear(OverHeadPercent);
        Clear(MarginPercent);
        Clear(EstimatedQty);
        Clear(LineNo);
        Clear(SalesLineQty);

        EstimationTblRec.Reset();
        EstimationTblRec.SetRange("Quote No.", QuoteNo);
        EstimationTblRec.SetRange("Version No.", VersionNo);
        if EstimationTblRec.FindSet then begin
            repeat
                //Message('hi');
                if DrawingNumberQ <> EstimationTblRec."Drawing Number" then begin
                    Clear(TotalPrice);
                    EstimationTblRec_1.Reset();
                    EstimationTblRec_1.SetRange("Quote No.", EstimationTblRec."Quote No.");
                    EstimationTblRec_1.SetRange("Drawing Number", EstimationTblRec."Drawing Number");
                    if EstimationTblRec_1.FindSet then begin
                        repeat
                            TotalPrice += EstimationTblRec_1."Total Price";
                        until EstimationTblRec_1.Next = 0;

                        // // EstimationHdrRec.Reset();
                        // // EstimationHdrRec.SetRange("Quote No.", QuoteNo);
                        // // EstimationHdrRec.SetRange("Version No.", VersionNo);
                        // // if EstimationHdrRec.FindFirst then begin
                        // //     If (EstimationHdrRec."Estimated Qty." = 0) OR (EstimationHdrRec."Total Qty." = 0) then
                        // //         Error('Estimated Qty. Or Total Qty. should not be 0');

                        //EstimatedQty := EstimationHdrRec."Estimated Qty.";
                        //SalesLineQty := EstimationHdrRec."Total Qty.";

                        ///end;
                        EstimatedQty := EstimationTblRec."Estimated Qty.";
                        SalesLineQty := EstimationTblRec."Total Qty.";


                        ///////  UnitPriceInit := TotalPrice / EstimatedQty; //comment By Avinash
                        EstimationHdrRec.Reset();
                        EstimationHdrRec.SetRange("Quote No.", QuoteNo);
                        EstimationHdrRec.SetRange("Version No.", VersionNo);
                        if EstimationHdrRec.FindFirst then
                            UnitPriceInit := EstimationHdrRec."Estimated Value" / EstimatedQty;

                        SalesHdrRec.Reset();
                        SalesHdrRec.SetRange("No.", QuoteNo);
                        if SalesHdrRec.FindFirst then begin
                            UnitPrice1 := UnitPriceInit + (UnitPriceInit * SalesHdrRec."Over Head %" / 100);
                            UnitPriceFinal := UnitPrice1 + (UnitPrice1 * SalesHdrRec."Margin %" / 100);
                        end;

                        SalesLine_Rec.Reset();
                        SalesLine_Rec.SetRange("Document No.", QuoteNo);
                        if SalesLine_Rec.FindLast then
                            LineNo := SalesLine_Rec."Line No." + 10000
                        else
                            LineNo := 10000;

                        SalesLineRec.Init();
                        SalesLineRec."Document Type" := SalesLineRec."Document Type"::Quote;
                        SalesLineRec."Line No." := LineNo;
                        SalesLineRec."Document No." := EstimationTblRec_1."Quote No.";
                        SalesLineRec.Type := SalesLineRec.Type::"G/L Account";


                        // Sales Line No. From Sales and receivable setup
                        SalesandRecieSetup.Reset();
                        SalesandRecieSetup.get();
                        SalesandRecieSetup.TestField("Estimation No.");
                        SalesandRecieSetup.TestField("Sales A/c");
                        // End
                        SalesLineRec.validate("No.", SalesandRecieSetup."Sales A/c");
                        SalesLineRec.Description := EstimationTblRec."Drawing Number";
                        SalesLineRec."Drawing No." := SalesLineRec.Description;
                        SalesLineRec.Validate(Quantity, SalesLineQty);

                        //SalesLineRec.Validate("Line Amount", UnitPriceFinal);
                        //SalesLineRec."Unit Price" := UnitPriceFinal / SalesLineQty;

                        ///////SalesLineRec.Validate("Unit Price", (UnitPriceFinal / SalesLineQty));//comment By Avinash

                        SalesLineRec."Unit Price" := UnitPriceFinal;//comment By Avinash
                                                                    // Message('UP in sales line %1', SalesLineRec."Unit Price");

                        /////SalesLineRec.Validate("Line Amount", SalesLineQty * (UnitPriceFinal / SalesLineQty));//comment By Avinash
                        /////// SalesLineRec.Validate();//comment By Avinash

                        SalesLineRec.Estimations := false;
                        SalesLineRec.Insert();
                    end;
                    DrawingNumberQ := EstimationTblRec."Drawing Number";
                end;
            until EstimationTblRec.Next = 0;
        end;
    end;

    procedure DeleteAll()
    var
        EstimationHdrRec: Record "Estimation Header";
        EstimationLineRec: Record "Estimation Line Tbl";
        EstimationArcHdrRec: Record "Estimation Archieve Header";
        EstimationArcLineRec: Record "Estimation Archieve Line";
    begin
        EstimationArcHdrRec.DeleteAll();
        EstimationArcLineRec.DeleteAll();
        EstimationHdrRec.DeleteAll();
        EstimationLineRec.DeleteAll();
        //Message('Done');
    end;

    var
        BOQRec: Record "BOQ Tbl";
        BOQRec_1: Record "BOQ Tbl";
        EstimationRec: Record "Estimation Line Tbl";
        EstimationREC_1: Record "Estimation Line Tbl";
        DrawingNumber: Code[20];
        ItemRec: Record Item;
        itemCategoryCodeRec: Record "Item Category";
        UnitCost: Decimal;
        SalesandRecieSetup: Record "Sales & Receivables Setup";


    // Start 02-07-2019
    //procedure UpdateUnitPriceExclVAT(SalesQuoteNoP: code[20])
    //procedure UpdateUnitPriceExclVAT(SalesQuoteNoP: code[20]; DrwNo: Code[50])
    procedure UpdateUnitPriceExclVAT(SalesQuoteNoP: code[20])
    var
        SalesHeaderRecL: Record "Sales Header";
        SalesLineRecL: Record "Sales Line";
        SalesLineRec2L: Record "Sales Line";
        EstimationLineRecL: Record "Estimation Line Tbl";
        TotalPriceSumDecL: Decimal;
        DivMulDecWith_TotalPriceSumDecL: Decimal;
        OverHeadValDecL: Decimal;
        MarginValDecL: Decimal;
    begin
        //Message('%1    ', SalesQuoteNoP);
        SalesHeaderRecL.Reset();
        SalesHeaderRecL.get(SalesHeaderRecL."Document Type"::Quote, SalesQuoteNoP);
        // Message('Doc No %1', SalesQuoteNoP);
        SalesHeaderRecL.TestField("Over Head %");
        SalesHeaderRecL.TestField("Margin %");

        SalesLineRecL.Reset();
        SalesLineRecL.SetRange("Document Type", SalesHeaderRecL."Document Type");
        SalesLineRecL.SetRange("Document No.", SalesQuoteNoP);
        if SalesLineRecL.FindSet() then begin
            repeat
                Clear(TotalPriceSumDecL);
                Clear(DivMulDecWith_TotalPriceSumDecL);
                Clear(OverHeadValDecL);
                Clear(MarginValDecL);
                EstimationLineRecL.Reset();
                EstimationLineRecL.SetRange("Quote No.", SalesLineRecL."Document No.");
                EstimationLineRecL.SetRange("Drawing Number", SalesLineRecL."Drawing No.");
                EstimationLineRecL.SetRange("Row Type", EstimationLineRecL."Row Type"::Line);
                if EstimationLineRecL.FindSet() then begin
                    repeat
                        TotalPriceSumDecL += EstimationLineRecL."Total Price";
                    until EstimationLineRecL.Next() = 0;
                    //Message('Total Price Sum %1', TotalPriceSumDecL);
                    DivMulDecWith_TotalPriceSumDecL := (TotalPriceSumDecL / EstimationLineRecL."Estimated Qty.");//* EstimationLineRecL."Total Qty.";
                    //Message('DivMulDecWith_TotalPriceSumDecL %1', DivMulDecWith_TotalPriceSumDecL);
                end;


                OverHeadValDecL := (DivMulDecWith_TotalPriceSumDecL * SalesHeaderRecL."Over Head %") / 100;
                //MarginValDecL := ((DivMulDecWith_TotalPriceSumDecL + OverHeadValDecL) * SalesHeaderRecL."Margin %") / 100;
                MarginValDecL := ((DivMulDecWith_TotalPriceSumDecL + OverHeadValDecL) / (1 - (SalesHeaderRecL."Margin %" / 100))) * (SalesHeaderRecL."Margin %" / 100);


                SalesLineRec2L.Reset();
                SalesLineRec2L.SetRange("Document No.", SalesLineRecL."Document No.");
                SalesLineRec2L.SetRange("Document Type", SalesLineRecL."Document Type");
                SalesLineRec2L.SetRange("Line No.", SalesLineRecL."Line No.");
                if SalesLineRec2L.FindFirst() then begin
                    SalesLineRec2L.Validate("Unit Price", ((DivMulDecWith_TotalPriceSumDecL + OverHeadValDecL) + MarginValDecL));
                    SalesLineRec2L.Modify();
                end
            until SalesLineRecL.Next() = 0;
        end;
    end;
    // Stop 02-07-2019
}