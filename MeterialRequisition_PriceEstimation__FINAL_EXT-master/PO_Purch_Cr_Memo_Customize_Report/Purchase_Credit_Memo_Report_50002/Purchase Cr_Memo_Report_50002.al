report 50002 "Purchase Cr_Memo"
{
    // version MSBM

    DefaultLayout = RDLC;
    //RDLCLayout = 'RDL_REPORT_FILE/CrMemo_50121.rdl';
    Caption = 'Purchase Credit Memo Msme';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING ("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Buy-from Vendor No.";

            column(Posting_Date; FORMAT("Posting Date", 10, '<Day,2>/<Month,2>/<year,2>'))
            { }
            column(Doc_No; "No.")
            { }
            column(Location_Code; "Location Code")
            { }
            column(Currency_Code; CurCode)
            { }
            column(Comp_Fax; CompInfoRec."Fax No.")
            { }
            column(Comp_Logo; CompInfoRec.Picture)
            { }
            column(Comp_Name; CompInfoRec.Name)
            { }
            column(Comp_Add1; CompInfoRec.Address)
            { }
            column(Comp_Add2; CompInfoRec."Address 2")
            { }
            column(Comp_City; CompInfoRec.City)
            { }
            column(Comp_Country1; CompInfoRec.County)
            { }
            column(Postcode; CompInfoRec."Post Code")
            { }
            column(Comp_Country; CompInfoRec."Country/Region Code")
            { }
            column(Comp_Phone; CompInfoRec."Phone No.")
            { }
            column(Comp_Phone2; CompInfoRec."Phone No. 2")
            { }
            column(Comp_mail; CompInfoRec."E-Mail")
            { }
            column(CompTRN; CompInfoRec."VAT Registration No.")
            { }
            column(Vend_Add; VendRec.address)
            { }
            column(Vend_Name; vendrec.Name)
            { }
            column(Vend_Add2; vendrec."Address 2")
            { }
            column(Vend_City; VendRec.City)
            { }
            column(Vend_PostCode; VendRec."Post Code")
            { }
            column(Vend_Country_Region_Code; VendRec."Country/Region Code")
            { }
            column(Vend_Post_Code; "Ship-to Post Code")
            { }
            column(Vend_Tel; VendRec."Phone No.")
            { }
            column(Vend_Email; VendRec."E-Mail")
            { }
            column(Vend_Fax; VendRec."Fax No.")
            { }
            column(vend_Trn; vendrec."VAT Registration No.")
            { }
            column(ExtDocNo; "Vendor Cr. Memo No.")
            { }
            column(ROE; ROE)
            { }
            // Start 20-08-2019
            column(LocationRecGName; LocationRecG.Name)
            { }
            column(Vendor_Cr__Memo_No_; "Vendor Cr. Memo No.")
            { }
            column(Invoice_Discount_Amount; "Invoice Discount Amount")
            { }
            column(Narration; Narration)
            { }
            // Start 20-08-2019
            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLink = "No." = field ("No.");
                DataItemTableView = sorting ("No.") where ("Document Type" = const ("Posted Credit Memo"));

                column(Comment; Comment) { }
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                column(SL_No; SL_No)
                { }
                column(Description_Line; Description)
                { }
                column(VAT_Per; "VAT %")
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(Amount; Amount)
                { }
                column(Amount_Including_VAT; "Amount Including VAT")
                { }
                column(Quantity_Line; Quantity)
                { }
                column(Unit_of_Measure_Line; "Unit of Measure")
                { }
                column(Unit_Cost_Lne; "Unit Cost")
                { }
                column(No_line; "No.")
                { }
                column(TotalAmt; TotalAmt)
                { }
                column(AmtWord; AmtWord)
                { }
                column(UOM; UOM) { }
                // Start 20-08-2019
                column(VAT_Base_Amount; "VAT Base Amount")
                { }

                column(Line_Discount_Amount; "Line Discount Amount")
                { }

                // Stop 20-08-2019
                trigger OnPreDataItem();
                begin
                    Clear(AmtVat);
                    CLEAR(SL_No);
                    //clear(TotalAmt);
                    CheckRep.InitTextVariable;
                end;

                trigger OnAfterGetRecord();
                var
                    DecimalName: Code[80];
                begin
                    // ItemRec.RESET;
                    // IF ItemRec.GET("No.") THEN begin
                    // if "Purch. Cr. Memo Line"."No." <> '' then
                    if ("No." <> '') AND ((Type = Type::"Charge (Item)") OR (Type = Type::"Fixed Asset") OR
                                   (Type = Type::"G/L Account") OR (Type = Type::Item)) then begin
                        SL_No += 1;
                    end else begin
                        SL_No := 0;
                    end;

                    if "Purch. Cr. Memo Line"."No." <> '' then
                        UOM := "Purch. Cr. Memo Line"."Unit of Measure Code"

                    else
                        UOM := '';

                    AmtVat += "Amount Including VAT";
                    TotalAmt := Quantity * "Unit Cost";
                    Clear(DecimalName);
                    if CurrencyRecG.get(CurCode) then
                        DecimalName := CurrencyRecG."Decimal Place Name";
                    AmountInWordCUG.InitTextVariable;
                    AmountInWordCUG.FormatNoText(NoText, AmtVat, CurCode);
                    AmtWord := CurCode + ' ' + NoText[1];
                end;
            }

            trigger OnAfterGetRecord();
            var

            begin
                LocationRecG.Reset();
                if LocationRecG.Get("Location Code") then;

                VendRec.RESET;
                IF VendRec.GET("Buy-from Vendor No.") THEN;

                if "Currency Factor" <> 0 then
                    ROE := 1 / "Currency Factor"
                else
                    Roe := 1.000;
                If "Currency Code" = '' then
                    CurCode := 'AED'
                else
                    CurCode := "Currency Code";
            end;

        }
    }


    trigger OnPreReport();

    begin
        CompInfoRec.GET;
        CompInfoRec.CALCFIELDS(Picture);
    end;



    var
        CompInfoRec: Record "Company Information";
        ItemRec: Record Item;
        AmountInWordCUG: Codeunit "Amount In Word LT";
        VendRec: Record Vendor;
        SL_No: Integer;
        TotalAmt: Decimal;
        CheckRep: Report Check;
        NoText: array[1] of Text;
        AmtWord: Text[100];
        AmtVat: Decimal;
        Roe: Decimal;
        CurCode: Code[10];
        LocationRecG: Record Location;
        CurrencyRecG: Record Currency;
        UOM: Code[20];
}


