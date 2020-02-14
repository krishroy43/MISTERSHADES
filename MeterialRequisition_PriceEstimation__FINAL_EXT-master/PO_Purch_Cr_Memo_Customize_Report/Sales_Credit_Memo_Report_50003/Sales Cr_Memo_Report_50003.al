report 50003 "Sales Cr_Memo"
{
    // version MSBM

    DefaultLayout = RDLC;
    //RDLCLayout = 'RDL_REPORT_FILE/SalCrMemo1.rdl';
    Caption = 'Sales Credit Memo Msme';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING ("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";

            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(External_Document_No_; "External Document No.") { }
            column(Sell_to_Address; "Sell-to Address")
            { }
            column(Sell_to_Address_2; "Sell-to Address 2")
            { }
            column(Sell_to_City; "Sell-to City")
            { }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            { }
            column(Sell_to_Contact; "Sell-to Contact")
            { }
            column(Vend_PostCode; CompInfoRec."Post Code")
            { }
            column(Cust_Phone; CustRec."Phone No.")
            { }
            column(Cust_Fax; CustRec."Fax No.")
            { }
            column(Cust_TRN; CustRec."VAT Registration No.")
            { }
            column(Doc_No; "No.")
            { }
            column(Posting_Date; FORMAT("Document Date", 10, '<Day,2>/<Month,2>/<year,2>'))
            { }
            column(Currency_Code; CurrCode)
            { }
            column(Location_Code; "Location Code")
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
            column(Comp_Country; CompInfoRec."Country/Region Code")
            { }
            column(Comp_Phone; CompInfoRec."Phone No.")
            { }
            column(Comp_Phone2; CompInfoRec."Phone No. 2")
            { }
            column(Comp_Fax; CompInfoRec."Fax No.")
            { }
            column(Comp_mail; CompInfoRec."E-Mail")
            { }
            column(Comp_TRN; compInfoRec."VAT Registration No.")
            { }
            column(Ref_No; "External Document No.")
            { }
            column(Loaction1; Loaction1) { }
            column(Invoice_Discount_Amount; "Invoice Discount Amount") { }
            column(ROE; ROE)
            { }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = field ("No.");
                column(Comment; Comment) { }
                column(StandardText_Rec; StandardText_Rec.Description) { }
                column(Standard_Code; StandardText_Rec.Code) { }
                column(Term_Condition; "Term/Condition") { }


                trigger OnAfterGetRecord()
                begin
                    StandardText_Rec.Reset();
                    if StandardText_Rec.Get("Term/Condition") then;

                end;


            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                column(SL_No; SL_No)
                { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                column(Quantity; Quantity) { }
                column(VAT_Base_Amount; "VAT Base Amount") { }
                column(Line_Discount_Amount; "Line Discount Amount") { }
                column(Unit_Cost; "Unit Cost") { }

                column(UnitPrice; "Unit Price") { }
                column(No_Sline; "No.")
                { }
                column(Description_SLine; Description)
                { }
                column(VAT_SLine; "VAT %")
                { }
                column(Unit_Price; Amount)
                { }
                column(Amount_Including_VAT; "Amount Including VAT")
                { }
                column(UOM; UOM) { }
                column(AmtWord; AmtWord)
                { }
                trigger OnPreDataItem();
                begin
                    Clear(AmtVat);
                    CLEAR(SL_No);
                    CheckRep.InitTextVariable;

                    Clear(UOM);
                    ;
                    Clear(Qty);
                    Clear(Unit);
                    Clear(Amount2);
                    Clear(Amount);
                    Clear(Vat);

                end;

                trigger OnAfterGetRecord();
                begin
                    ItemRec.RESET;
                    IF ItemRec.GET("No.") AND ((Type = Type::"Charge (Item)") OR (Type = Type::"Fixed Asset") OR
                                     (Type = Type::"G/L Account") OR (Type = Type::Item) OR (Type = Type::Resource)) then begin
                        // if (("No.") <> '') AND ((Type = Type::"Charge (Item)") OR (Type = Type::"Fixed Asset") OR
                        //             (Type = Type::"G/L Account") OR (Type = Type::Item) OR (Type = Type::Resource)) then begin
                        SL_No += 1;
                    end else begin
                        SL_No := 0;
                    end;

                    // Message('%1', SL_No);
                    // if ("No." <> '') AND ((Type = Type::"Charge (Item)") OR (Type = Type::"Fixed Asset") OR
                    //                  (Type = Type::"G/L Account") OR (Type = Type::Item) OR (Type = Type::Resource)) then begin
                    //     SL_No += 1;
                    // end else begin
                    //     SL_No := 0;
                    // end;


                    if "Sales Cr.Memo Line"."No." <> '' then begin
                        UOM := "Sales Cr.Memo Line"."Unit of Measure Code";

                    end else begin
                        UOM := '';


                    end;





                    AmtVat += "Amount Including VAT";
                    Intpart := (AmtVat DIV 1);
                    Decpart := (ROUND(AmtVat) MOD 1 * 100);

                    /*CheckRep.FormatNoText(NoText, AmtVat, '');
                     AmtWord := CurrCode + ' ' + NoText[1];*/
                    CheckRep.FormatNoText(NoText, Intpart, '');
                    CheckRep.FormatNoText(NoText1, Decpart, '');
                    AmtWord := CurrCode + ' ' + NoText[1] + 'AND ' + NoText1[1];
                end;
            }
            trigger OnPreDataItem();
            begin
                Clear(ROE);

                Clear(Loaction1);
            end;

            trigger OnAfterGetRecord();
            begin
                CustRec.Reset;
                if CustRec.Get("Sell-to Customer No.") then;

                Location_Rec.Reset();
                if Location_Rec.Get("Sales Cr.Memo Line"."Location Code") then
                    Loaction1 := Location_Rec.Name;

                if "Currency Factor" <> 0 then
                    ROE := 1 / "Currency Factor"
                else
                    ROE := 1.000;

                if "Currency Code" = '' then
                    CurrCode := 'AED'
                else
                    CurrCode := "Currency Code";
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
        VendRec: Record Vendor;
        SL_No: Integer;
        TotalAmt: Decimal;
        CheckRep: Report Check;
        NoText: array[1] of Text;
        NoText1: array[1] of Text;
        AmtWord: Text[100];
        AmtVat: Decimal;
        CustRec: Record Customer;
        ROE: Decimal;
        CurrCode: Code[10];
        Intpart: Decimal;
        Decpart: Decimal;
        Location_Rec: Record Location;
        Loaction1: Text[100];
        StandardText_Rec: Record "Standard Text";
        Qty: Decimal;
        Unit: Decimal;
        Amount: Decimal;
        Amount2: Decimal;
        Vat: Decimal;
        AmtInVat: Decimal;
        UOM: Code[20];
}