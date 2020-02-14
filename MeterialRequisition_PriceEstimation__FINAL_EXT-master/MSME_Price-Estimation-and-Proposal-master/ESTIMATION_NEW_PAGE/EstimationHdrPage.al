page 50019 "Estimation Header Page"
{
    PageType = Card;
    ApplicationArea = All;
    Editable = true;
    UsageCategory = Administration;
    SourceTable = "Estimation Header";
    InsertAllowed = true;
    ModifyAllowed = true;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Estimation No."; "Estimation No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Estimation Qty."; "Estimated Qty.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    /*
                    this fiedls hide , due to new changes from customer side
                    */

                }
                field("Version No."; "Version No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field("Version No. Disp"; "Version No. Disp")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Total Qty."; "Total Qty.")
                {
                    ApplicationArea = All;
                    //Editable = false;
                    Visible = false;
                    /*
                    this fiedls hide , due to new changes from customer side
                    */

                }
                field("Estimated Value"; "Estimated Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Value"; "Total Value")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Rate per Sq.M"; "Rate per Sq.M")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                }


            }

            // group("Estimation Lines")
            // {
            part("Est. Line"; "Estimation Sheet")
            {
                ApplicationArea = All;
                SubPageLink = "Quote No." = field("Quote No."), "Version No. Disp" = field("Version No. Disp");
                //SubPageLink = "Quote No." = field ("Quote No."), "Version No." = field ("Version No.");
                SubPageView = SORTING("Quote No.", "Drawing Number", "Line No.") order(ascending);
                UpdatePropagation = Both;
                //Enabled = "No." <> '';
            }
            //}
        }
    }

    actions
    {
        area(Processing)
        {
            action(Release)
            {
                ApplicationArea = All;
                Image = ReleaseDoc;
                Promoted = true;
                trigger OnAction()
                // Start 16-07-2019
                var
                    EstimationLineRecL: Record "Estimation Line Tbl";
                    EstimationLineRecL_1: Record "Estimation Line Tbl";
                    JobTaskMasterRecL: Record "Job Task Master";

                // Stop 16-07-2019
                begin

                    If Rec.Status = Status::Open then begin
                        // Job Task Type
                        EstimationLineRecL_1.Reset();
                        EstimationLineRecL_1.SetRange("Quote No.", "Quote No.");
                        EstimationLineRecL_1.SetRange("Version No.", "Version No.");
                        if EstimationLineRecL_1.FindSet() then begin
                            repeat
                                JobTaskMasterRecL.Reset();
                                if JobTaskMasterRecL.Get(EstimationLineRecL_1."Job Task") then
                                    if JobTaskMasterRecL."Job Task Type" <> JobTaskMasterRecL."Job Task Type"::Posting then
                                        Error('Selected Job Task type must be Posting in Line no %1 for Drawing No %2', EstimationLineRecL_1."Line No.", EstimationLineRecL_1."Drawing Number");
                            until EstimationLineRecL_1.Next() = 0;
                        end;
                        // Job Task Type 
                        // if "Rate per Sq.M" <> 0 then begin
                        // Start 16-07-2019
                        EstimationLineRecL.Reset();
                        EstimationLineRecL.SetRange("Quote No.", "Quote No.");
                        if EstimationLineRecL.FindSet() then begin
                            repeat
                                if (EstimationLineRecL."Drawing Number" <> '') and (EstimationLineRecL."Row Type" = EstimationLineRecL."Row Type"::Line) then begin
                                    EstimationLineRecL.TestField("Item Code");
                                    EstimationLineRecL.TestField(Quantity);
                                    EstimationLineRecL.TestField("Unit Price");
                                    EstimationLineRecL.TestField("Total Price");
                                    EstimationLineRecL.TestField("Job Task");
                                end
                                else
                                    if (EstimationLineRecL."Drawing Number" <> '') and (EstimationLineRecL."Row Type" = EstimationLineRecL."Row Type"::Total) then begin
                                        EstimationLineRecL.TestField(Quantity);
                                    end;
                            until EstimationLineRecL.Next() = 0;
                        end;
                        // Stop 16-07-2019
                        // Start 16-Aug-2016
                        CheckEstimatedQtyAndTotalQty("Quote No.", "Version No.", "Estimation No.");
                        // Stop 16-Aug-2016

                        Rec.Status := Status::Released;
                        rec.modify();
                        //end else
                        //  Error('Rate per sq.M should not be empty');
                    end;

                end;
            }
            action("Re-Open")
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;

                trigger OnAction()
                var
                    NewVersion: Integer;
                    LastVersionNo: Integer;
                begin
                    IF Rec.Status = Status::Released then begin
                        VersionNo := Rec."Version No. Disp";
                        VersionNo1 := Rec."Version No.";

                        LastVersionNo := Rec."Version No.";
                        //if VersionNo = 0 then
                        //VersionNo := 1;

                        EstimationArchHdr.Reset();
                        EstimationArchHdr.SetRange("Quote No.", Rec."Quote No.");
                        If EstimationArchHdr.FindLast then
                            VersionNo := EstimationArchHdr."Version No." + 1
                        else
                            VersionNo := 1;
                        //Header Copy to Archieve

                        EstimationArchHdr.TransferFields(Rec);
                        EstimationArchHdr."Version No." += 1; //:= VersionNo;//Krishna
                        EstimationArchHdr.Insert();

                        //Line Copy to Archieve
                        EstimationLineRec.Reset();
                        EstimationLineRec.SetRange("Quote No.", Rec."Quote No.");
                        EstimationLineRec.SetRange("Version No.", Rec."Version No.");
                        if EstimationLineRec.FindSet() then begin
                            repeat
                                EstimationArchLine.TransferFields(EstimationLineRec);
                                EstimationArchLine."Version No." += 1; //:= VersionNo;//Krishna
                                //EstimationArchLine."Version No." := Rec.Version;
                                //EstimationArchLine.Copy(EstimationArchLine);
                                EstimationArchLine.Insert();
                            until EstimationLineRec.next = 0;
                        end;
                        //  Rec."Version No." := VersionNo + 1;//Krishna


                        //Creating estimation header & Line with Next Version No.
                        /*
                        EstimationHdrRec.Reset();
                        EstimationHdrRec.TransferFields(Rec);
                        EstimationHdrRec."Version No." := VersionNo + 1;
                        EstimationHdrRec.Insert();
*/
                        EstimationHdrRec.Reset();
                        EstimationHdrRec.SetRange("Quote No.", Rec."Quote No.");
                        if EstimationHdrRec.FindFirst() then begin
                            EstimationHdrRec."Version No." += 1; //VersionNo + 1;//Krishna
                            NewVersion := EstimationHdrRec."Version No.";
                            EstimationHdrRec.Modify();
                        end;

                        //EstimationHdrRec.TransferFields(Rec);
                        //EstimationHdrRec."Version No." := VersionNo + 1;
                        //EstimationHdrRec.Insert();



                        EstimationLineRec_1.Reset();
                        EstimationLineRec_1.SetRange("Quote No.", Rec."Quote No.");
                        // EstimationLineRec_1.SetRange("Version No.", VersionNo1);//Krishna Removed filter as lines was not geting update in case of wrong version no
                        if EstimationLineRec_1.FindSet() then begin
                            repeat
                                //InsertEstimationLineRec.Reset();
                                //InsertEstimationLineRec.TransferFields(EstimationLineRec_1);
                                //InsertEstimationLineRec."Version No." := VersionNo + 1;
                                //InsertEstimationLineRec.Insert();
                                EstimationLineRec_1."Version No." := NewVersion;// := VersionNo + 1;//Krishna
                                EstimationLineRec_1.Modify();

                            until EstimationLineRec_1.Next = 0;
                        End;
                        /*
                                                EstimationHdrRec_1.Reset();
                                                EstimationHdrRec_1.SetRange("Quote No.", Rec."Quote No.");
                                                EstimationHdrRec_1.SetRange("Version No.", VersionNo + 1);
                                                if EstimationHdrRec_1.FindFirst() then
                                                    CurrPage.SetRecord(EstimationHdrRec_1);
                                                //Modify();
                                                */
                        //Status := Rec.Status::Open;

                        SalesQuoteHdrRec.Reset();
                        SalesQuoteHdrRec.SetRange("No.", Rec."Quote No.");
                        if SalesQuoteHdrRec.FindFirst then begin
                            SalesQuoteHdrRec."Version No." += 1;//:= VersionNo + 1;//Krishna
                            SalesQuoteHdrRec.Modify();
                        End;
                        //CurrPage.Update();

                        //Rec.Modify();
                        OpenEstimationHdrRec.Reset();
                        OpenEstimationHdrRec.SetRange("Quote No.", SalesQuoteHdrRec."No.");
                        OpenEstimationHdrRec.SetRange(Status, Status::Released);
                        if OpenEstimationHdrRec.FindFirst() then begin
                            OpenEstimationHdrRec.Status := OpenEstimationHdrRec.Status::Open;
                            OpenEstimationHdrRec.Modify()
                        end;

                        Commit();
                        OpenEstimationHdrRec.Reset();
                        OpenEstimationHdrRec.SetRange("Quote No.", SalesQuoteHdrRec."No.");
                        OpenEstimationHdrRec.SetRange("Version No.", NewVersion);
                        if OpenEstimationHdrRec.FindFirst() then
                            Page.RunModal(50019, OpenEstimationHdrRec);

                    end else
                        Error('Status must be Released for Re-open');
                end;
            }

            action("Archieved Docs")
            {
                ApplicationArea = All;
                RunObject = page "Estimation Archieve List";
                RunPageLink = "Quote No." = field("Quote No.");

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    // Page.Run(50022);
                end;
            }
            action("Update Value")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    myInt: Integer;
                    EstimationLineRec: Record "Estimation Line Tbl";
                    EstimationLineRec_1: Record "Estimation Line Tbl";
                    EstimationLineRec_2: Record "Estimation Line Tbl";
                    EstimationLineRec_3: Record "Estimation Line Tbl";
                    SalesReceiRec: Record "Sales & Receivables Setup";
                    DrawingNum: Code[20];
                    TotalPrice: Decimal;
                    TotalPrice1: Decimal;
                    TotalEstimatedValue: Decimal;
                    TotalQty: Decimal;
                    EstimatedQtySum: Decimal;
                    TotalQtySum: Decimal;
                    EstimationLineRec_4: Record "Estimation Line Tbl";
                    EstimationLineRec_5: Record "Estimation Line Tbl";
                    LastDrwNumCode: Code[30];
                begin
                    if Rec.Status = rec.Status::Open then begin
                        // Start 22-08-2019
                        EstimationLineRec_5.Reset();
                        EstimationLineRec_5.SetRange("Quote No.", "Quote No.");
                        //EstimationLineRec_5.SetRange("Version No.","Version No.");
                        if EstimationLineRec_5.FindSet() then
                            repeat
                                EstimationLineRec_5.TestField("Drawing Number");
                            until EstimationLineRec_5.Next() = 0;
                        // Stop 22-08-2019
                        Clear(DrawingNum);
                        Clear(TotalPrice);
                        Clear(TotalPrice1);
                        Clear(TotalEstimatedValue);
                        Clear(TotalQty);
                        Clear(EstimatedQtySum);
                        Clear(TotalQtySum);

                        SalesReceiRec.Reset();
                        SalesReceiRec.Get();
                        If SalesReceiRec."Item Type" = SalesReceiRec."Item Type"::" " then
                            Error('Please select the item type from Sales & Receivable setup.');

                        EstimationLineRec.Reset();
                        EstimationLineRec.SetRange("Quote No.", "Quote No.");
                        EstimationLineRec.SetRange("Version No.", "Version No.");
                        if EstimationLineRec.Findset() then begin
                            repeat
                                if EstimationLineRec."Row Type" = EstimationLineRec."Row Type"::Line then
                                    TotalEstimatedValue += EstimationLineRec."Total Price";

                                //  Message('TotalEstimatedValue  %1', TotalEstimatedValue);
                                //TotalQty += EstimationLineRec.Quantity;
                                if DrawingNum <> EstimationLineRec."Drawing Number" then begin
                                    EstimationLineRec_1.Reset();
                                    EstimationLineRec_1.SetRange("Quote No.", EstimationLineRec."Quote No.");
                                    EstimationLineRec_1.SetRange("Version No.", EstimationLineRec."Version No.");
                                    EstimationLineRec_1.SetRange("Drawing Number", EstimationLineRec."Drawing Number");
                                    EstimationLineRec_1.SetRange("Item Type", SalesReceiRec."Item Type");
                                    //EstimationLineRec_1.SetRange("Item Type", EstimationLineRec_1."Item Type"::Fabric);
                                    if EstimationLineRec_1.FindSet then begin
                                        repeat
                                            TotalPrice += EstimationLineRec_1."Total Price";
                                        until EstimationLineRec_1.Next = 0;

                                        EstimationLineRec_2.Reset();
                                        EstimationLineRec_2.SetRange("Quote No.", EstimationLineRec."Quote No.");
                                        EstimationLineRec_2.SetRange("Version No.", EstimationLineRec."Version No.");
                                        EstimationLineRec_2.SetRange("Drawing Number", EstimationLineRec."Drawing Number");
                                        EstimationLineRec_2.SetRange("Item Type", SalesReceiRec."Item Type");
                                        EstimationLineRec_2.SetRange("Row Type", EstimationLineRec_2."Row Type"::Total);
                                        if EstimationLineRec_2.FindFirst then begin
                                            if EstimationLineRec_2.Quantity <> 0 then
                                                TotalPrice1 += EstimationLineRec_2.Quantity
                                            else
                                                TotalPrice1 := 1;
                                        end else
                                            TotalPrice1 := 1;
                                    end;
                                    DrawingNum := EstimationLineRec."Drawing Number";
                                end;
                            Until EstimationLineRec.Next = 0;
                        end;

                        // Start Avinash Modify
                        EstimationLineRec_4.Reset();
                        Clear(LastDrwNumCode);
                        EstimationLineRec_4.SetCurrentKey("Drawing Number");
                        EstimationLineRec_4.SetRange("Quote No.", "Quote No.");
                        EstimationLineRec_4.SetRange("Version No.", "Version No.");
                        if EstimationLineRec_4.Findset() then begin
                            repeat
                                if LastDrwNumCode <> EstimationLineRec_4."Drawing Number" then begin
                                    EstimatedQtySum += EstimationLineRec_4."Estimated Qty.";
                                    TotalQtySum += EstimationLineRec_4."Total Qty.";
                                end;
                                LastDrwNumCode := EstimationLineRec_4."Drawing Number";
                            until EstimationLineRec_4.Next() = 0;
                        end;
                        // Stop Avinash Modify
                        Clear("Rate per Sq.M");
                        //and (TotalPrice <> 0)

                        if TotalEstimatedValue <> 0 then
                            "Estimated Value" := TotalEstimatedValue;
                        FindRatePerSqMeter("Version No.", "Quote No.");
                        Modify();
                        // Message('%1 / %2  * %3', TotalEstimatedValue, EstimatedQtySum, TotalQtySum);
                        // // // // // // //    FindRatePerSqMeter("Version No.", "Quote No.");
                        // // // // // // //     If EstimatedQtySum <> 0 then
                        // // // // // // //         "Total Value" := (TotalEstimatedValue / EstimatedQtySum) * TotalQtySum;

                        // // // // // // //     if (TotalPrice1 <> 0) then
                        // // // // // // //         "Rate per Sq.M" := FindRatePerSqMeter("Version No.", "Quote No.");//"Total Value" / TotalPrice1;

                        // // // // // // //     Modify();
                        //"Total Value" := (TotalEstimatedValue / "Estimated Qty.") * "Total Qty.";
                        //"Total Qty." := TotalQty;
                        //  Message('%1', TotalQty);

                    end else
                        Error('Status should be Open');
                end;
            }
            /*
                        action("Archive Lines")
                        {
                            ApplicationArea = All;
                            RunObject = page "Estimation Archieve List";
                            RunPageLink = "Quote No." = field ("Quote No.");
                            trigger OnAction()
                            begin
                                //page.Run(50020);
                            end;
                        }
                        action("BOQ  Lines")
                        {
                            ApplicationArea = All;
                            trigger OnAction()
                            begin
                                page.Run(50015);
                            end;
                        }*/
        }
    }

    var
        myInt: Integer;
        VersionNo: Integer;
        VersionNo1: Integer;
        EstimationArchHdr: Record "Estimation Archieve Header";
        EstimationArchLine: Record "Estimation Archieve Line";
        EstimationLineRec: Record "Estimation Line Tbl";
        EstimationHdrRec: Record "Estimation Header";
        EstimationLineRec_1: Record "Estimation Line Tbl";
        InsertEstimationLineRec: Record "Estimation Line Tbl";
        EstimationHdrRec_1: Record "Estimation Header";
        SalesQuoteHdrRec: Record "Sales Header";
        OpenEstimationHdrRec: Record "Estimation Header";
        RatePerSqMeter: Decimal;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //if Rec.Status = Status::Open then
        //Error('Please release the document before exiting the page');

    end;

    trigger OnAfterGetCurrRecord()
    var
        RecSalesHeader: Record "Sales Header";
        EstimationHdrRec: Record "Estimation Header";
    begin
        // // // // // // if Rec."Version No." = 0 then begin
        // // // // // //     Rec."Version No." := 1;
        // // // // // //     Rec."Version No. Disp" := 1;
        // // // // // //     Rec.Modify();
        // // // // // // end;

        EstimationHdrRec.Reset();
        EstimationHdrRec.SetRange("Quote No.", Rec."Quote No.");
        if EstimationHdrRec.FindFirst() then begin
            if EstimationHdrRec."Version No." = 0 then begin
                EstimationHdrRec."Version No." := 1;
                // EstimationHdrRec."Version No. Disp" := 1;
                EstimationHdrRec.Modify();
            end;
        end;


        /*
        RecSalesHeader.RESET;
        RecSalesHeader.SetRange("No.", Rec."Quote No.");
        if RecSalesHeader.findfirst then begin
            RecSalesHeader."Version No." := Rec."Version No.";
            RecSalesHeader.modify;
        end;
        */
    end;

    trigger OnDeleteRecord(): Boolean
    var
        EstimationLinesRec: Record "Estimation Line Tbl";
    begin
        EstimationLinesRec.Reset();
        EstimationLinesRec.SetRange("Quote No.", Rec."Quote No.");
        EstimationLinesRec.SetRange("Version No.", Rec."Version No.");
        If EstimationLinesRec.Findset then
            EstimationLinesRec.DeleteAll();
    end;

    trigger OnOpenPage()
    var
        RecSalesHeader: Record "Sales Header";
        EstimationHeaderRec: Record "Estimation Header";
    Begin
        /*
        RecSalesHeader.RESET;
        RecSalesHeader.SetRange("No.", Rec."Quote No.");
        if RecSalesHeader.findfirst then begin
            RecSalesHeader."Version No." := Rec."Version No.";
            RecSalesHeader.modify;
        end;
        */
        //if Rec."Version No. Disp" = 0 then

        EstimationHeaderRec.Reset();
        EstimationHeaderRec.SetRange("Quote No.", Rec."Quote No.");
        if not EstimationHeaderRec.FindFirst() then
            CurrPage.Update();
        CurrPage.Editable();

    End;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    procedure CheckEstimatedQtyAndTotalQty(Quote: Code[20]; VersionNo: Integer; EstimationNo: Code[20])
    var
        EstimationLineRecL_1: Record "Estimation Line Tbl";
        EstimationLineRecL_2: Record "Estimation Line Tbl";
        PreEstiQtyDecL: Decimal;
        PreTotalQtyDecL: Decimal;
    begin


        //Message('Calling');
        // Start 15-Aug-2019
        Clear(PreEstiQtyDecL);
        Clear(PreTotalQtyDecL);
        EstimationLineRecL_1.SetCurrentKey("Quote No.", "Version No.", "Drawing Number");
        EstimationLineRecL_1.Reset();
        EstimationLineRecL_1.SetRange("Quote No.", Quote);
        EstimationLineRecL_1.SetRange("Version No.", VersionNo);
        if EstimationLineRecL_1.FindSet() then begin
            repeat
                Clear(PreEstiQtyDecL);
                Clear(PreTotalQtyDecL);
                EstimationLineRecL_2.Reset();
                EstimationLineRecL_2.SetRange("Quote No.", EstimationLineRecL_1."Quote No.");
                EstimationLineRecL_2.SetRange("Version No.", EstimationLineRecL_1."Version No.");
                EstimationLineRecL_2.SetRange("Drawing Number", EstimationLineRecL_1."Drawing Number");
                if EstimationLineRecL_2.FindSet() then begin
                    repeat
                        if (PreEstiQtyDecL <> 0) and (PreTotalQtyDecL <> 0) then begin
                            //Message('PreEstiQtyDecL %1 & PreTotalQtyDecL %2 ', PreEstiQtyDecL, PreTotalQtyDecL);
                            //Message('Est Qty - %1  Tot Qty. - %2', EstimationLineRecL_2."Estimated Qty.", EstimationLineRecL_2."Total Qty.");
                            if (EstimationLineRecL_2."Estimated Qty." <> PreEstiQtyDecL) OR (EstimationLineRecL_2."Total Qty." <> PreTotalQtyDecL) then begin
                                Error('Line No. %4 Drwaring No. %1 Estimated Qty. %2 and Total Qty. %3 must be Same', EstimationLineRecL_2."Drawing Number", EstimationLineRecL_2."Estimated Qty.", EstimationLineRecL_2."Total Qty.", EstimationLineRecL_2."Line No.");
                            end;
                        end;
                    until EstimationLineRecL_2.Next() = 0;
                end;
                PreEstiQtyDecL := EstimationLineRecL_1."Estimated Qty.";
                PreTotalQtyDecL := EstimationLineRecL_1."Total Qty.";
            until EstimationLineRecL_1.Next() = 0;
        end;
        // Stop 15-Aug-2019
    end;

    // Start Rate Per Sq Meter
    procedure FindRatePerSqMeter(VersionNo: Integer; QuoteNo: Code[30])
    var
        EstimationLineRecL_1: Record "Estimation Line Tbl";
        EstimationLineRecL_2: Record "Estimation Line Tbl";
        EstimationLineRec_3: Record "Estimation Line Tbl";
        EstimationLineRec_4: Record "Estimation Line Tbl";
        SalesReceiRec: Record "Sales & Receivables Setup";
        TotalPriceSumG: array[50] of Decimal;
        TotalPriceSumAllG: Decimal;
        FebricQtyOnlyTotal: array[50] of Decimal;
        FebricQtyOnlyTotalAllG: Decimal;
        LastDrwNumCode: Code[30];
        I: Integer;
        J: Integer;
        EstimatedQtyDec: array[50] of Decimal;
        TotalQtyDec: array[50] of Decimal;
        TotalValueDec: Decimal;
    begin
        // Start Check Estimation Qty and Total Qty
        EstimationLineRec_3.Reset();
        EstimationLineRec_3.SetCurrentKey("Drawing Number", "Version No.", "Quote No.");
        EstimationLineRec_3.SetRange("Quote No.", QuoteNo);
        //EstimationLineRec_3.SetRange("Version No.", VersionNo);
        EstimationLineRec_3.SetRange("Version No. Disp", "Version No. Disp");
        if EstimationLineRec_3.Findset() then begin
            repeat
                EstimationLineRec_3.TestField("Estimated Qty.");
                EstimationLineRec_3.TestField("Total Qty.");
            until EstimationLineRec_3.Next() = 0;
        end;
        // Stop Check Estimation Qty and Total Qty
        // Start Sum of Total Price 
        Clear(I);
        Clear(RatePerSqMeter);
        Clear(EstimatedQtyDec);
        Clear(TotalQtyDec);
        Clear(J);
        Clear(TotalValueDec);
        I := 1;
        SalesReceiRec.Reset();
        SalesReceiRec.Get();
        EstimationLineRec_4.Reset();
        EstimationLineRec_4.SetCurrentKey("Drawing Number", "Version No.", "Quote No.");////////////////////////////////
        EstimationLineRec_4.SetRange("Quote No.", QuoteNo);
        //EstimationLineRec_4.SetRange("Version No.", VersionNo);
        EstimationLineRec_4.SetRange("Version No. Disp", "Version No. Disp");
        if EstimationLineRec_4.Findset() then begin
            repeat
                if LastDrwNumCode <> EstimationLineRec_4."Drawing Number" then begin
                    // Start Estimated Qty and Total Qty
                    EstimatedQtyDec[I] := EstimationLineRec_4."Estimated Qty.";
                    TotalQtyDec[I] := EstimationLineRec_4."Total Qty.";
                    // Message('Dr %1   Est Qty %2     Total Qty %3', EstimationLineRec_4."Drawing Number", EstimationLineRec_4."Estimated Qty.", EstimationLineRec_4."Total Qty.");
                    // Stop Estimated Qty and Total Qty
                    // Start Sum of Totla Price With Drawing No.
                    Clear(TotalPriceSumAllG);
                    EstimationLineRecL_1.Reset();
                    EstimationLineRecL_1.SetCurrentKey("Drawing Number", "Version No.", "Quote No.");//////////////////////
                    EstimationLineRecL_1.SetRange("Quote No.", EstimationLineRec_4."Quote No.");
                    //EstimationLineRecL_1.SetRange("Version No.", EstimationLineRec_4."Version No.");
                    EstimationLineRecL_1.SetRange("Version No. Disp", "Version No. Disp");
                    EstimationLineRecL_1.SetRange("Drawing Number", EstimationLineRec_4."Drawing Number");
                    if EstimationLineRecL_1.FindSet() then begin
                        repeat
                            TotalPriceSumAllG += EstimationLineRecL_1."Total Price";
                        until EstimationLineRecL_1.Next() = 0;
                    end;
                    // Stop Sum of Totla Price With Drawing No.
                    // Start Febric Qty
                    EstimationLineRecL_2.Reset();
                    Clear(FebricQtyOnlyTotalAllG);
                    EstimationLineRecL_2.SetCurrentKey("Drawing Number", "Version No.", "Quote No.");/////////////////
                    EstimationLineRecL_2.SetRange("Quote No.", EstimationLineRec_4."Quote No.");
                    //EstimationLineRecL_2.SetRange("Version No.", EstimationLineRec_4."Version No.");
                    EstimationLineRecL_2.SetRange("Version No. Disp", "Version No. Disp");
                    EstimationLineRecL_2.SetRange("Drawing Number", EstimationLineRec_4."Drawing Number");
                    EstimationLineRecL_2.SetRange("Item Type", SalesReceiRec."Item Type");
                    EstimationLineRecL_2.SetRange("Row Type", EstimationLineRecL_2."Row Type"::Total);
                    if EstimationLineRecL_2.FindFirst then begin
                        if EstimationLineRecL_2.Quantity <> 0 then
                            FebricQtyOnlyTotalAllG += EstimationLineRecL_2.Quantity
                        else
                            FebricQtyOnlyTotalAllG := 1;
                    end else
                        FebricQtyOnlyTotalAllG := 1;
                    // Stop Febric Qty
                    // Start Assign Value 
                    TotalPriceSumG[I] := TotalPriceSumAllG;
                    FebricQtyOnlyTotal[I] := FebricQtyOnlyTotalAllG;
                    I += 1;
                    // Stop Assign Value
                end;
                LastDrwNumCode := EstimationLineRec_4."Drawing Number";

            until EstimationLineRec_4.Next() = 0;
        end;
        // Stop Sum of Total Price 

        // SortDecArray(TotalPriceSumG);
        // SortDecArray(EstimatedQtyDec);
        // SortDecArray(TotalQtyDec);
        // SortDecArray(FebricQtyOnlyTotal);
        SortDecArrayWithoutSort(TotalPriceSumG);
        SortDecArrayWithoutSort(EstimatedQtyDec);
        SortDecArrayWithoutSort(TotalQtyDec);
        SortDecArrayWithoutSort(FebricQtyOnlyTotal);

        for J := 1 to ArrayLen(TotalPriceSumG) do begin
            if (TotalPriceSumG[J] <> 0) and (EstimatedQtyDec[J] <> 0) then begin
                TotalValueDec += (TotalPriceSumG[J] / EstimatedQtyDec[J]) * TotalQtyDec[J];
                //Message('Febric %1', FebricQtyOnlyTotal[J]);
                if FebricQtyOnlyTotal[J] <> 1 then
                    RatePerSqMeter += ((TotalPriceSumG[J] / EstimatedQtyDec[J]) * TotalQtyDec[J]) / FebricQtyOnlyTotal[J]
                else
                    RatePerSqMeter := 0;
                //RatePerSqMeter += TotalPriceSumG[J] / FebricQtyOnlyTotal[J];
            end;
        end;
        //exit(RatePerSqMeter);
        "Total Value" := TotalValueDec;
        "Rate per Sq.M" := RatePerSqMeter;
    end;
    // Stop Rate Per Sq Meter 
    procedure SortDecArray(var rankArray: array[50] of Decimal)
    var
        numLength: Integer;
        flag: Boolean;
        i: Integer;
        j: Integer;
        temp: Decimal;
    begin
        numLength := ARRAYLEN(rankArray);
        flag := TRUE;
        FOR i := 1 TO numLength - 1 DO BEGIN
            flag := FALSE;
            FOR j := 1 TO numLength - 1 DO BEGIN
                IF rankArray[j] < rankArray[j + 1] THEN BEGIN
                    temp := rankArray[j + 1];
                    rankArray[j + 1] := rankArray[j];
                    rankArray[j] := temp;
                    flag := TRUE;
                END;
            END;
        END;

    end;

    // Testing new one
    procedure SortDecArrayWithoutSort(var rankArray: array[50] of Decimal)
    var
        numLength: Integer;
        flag: Boolean;
        i: Integer;
        j: Integer;
        temp: Decimal;
        TempArray: array[50] of Decimal;
    begin
        numLength := ARRAYLEN(rankArray);
        j := 1;
        i := 1;
        FOR i := 1 TO numLength DO BEGIN
            if rankArray[i] > 0 then begin
                TempArray[j] := rankArray[i];
                j += 1;
            end;
        END;
        Clear(rankArray);
        FOR i := 1 TO numLength DO BEGIN
            rankArray[i] := TempArray[i];
        END;
    end;
}