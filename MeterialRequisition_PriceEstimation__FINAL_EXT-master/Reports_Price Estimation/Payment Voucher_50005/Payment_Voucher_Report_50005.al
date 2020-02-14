report 50005 "Payment_Voucher"
{
    // version LT
    DefaultLayout = RDLC;
    //RDLCLayout = 'RDL_REPORT_FILE/Payment Voucher.rdl';
    Caption = 'Payment Voucher';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                WHERE("Debit Amount" = FILTER(<> 0));
            RequestFilterFields = "Document No.";
            column(Caption1; Caption1) { }
            column(PreparedBy; Users."Full Name") { }
            column(PageCaption; PageCaption) { }
            column(GLEntryNo; "G/L Entry"."Entry No.") { }
            column(Job; Job) { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(ProfitCenterCode; PCTCode) { }
            column(ChequeNo; ChequeNo) { }
            column(ChequeDate; ChequeDate) { }
            column(HeaderCaption; HeaderCaption) { }
            column(RecievedFrom; RecievedFrom) { }
            column(Remarks; Remarks) { }
            column(AmountText2; AmountText[2]) { }
            column(DrawnOn; DrawnOn) { }
            column(PostingDate; "G/L Entry"."Posting Date") { }
            column(UserName; "G/L Entry"."User ID") { }
            column(DocNo; "G/L Entry"."Document No.") { }
            column(DivisionCode; "G/L Entry"."Global Dimension 2 Code") { }
            column(Dim1; "G/L Entry"."Global Dimension 1 Code") { }
            column(AccountNo; SourceNo) { }
            column(Description; PaymentDesc) { }
            column(Amount; "G/L Entry"."Debit Amount") { }
            column(LCYCode; Currencycode1) { }
            column(AmountInWords1; AmountInWords1) { }

            column(Job_No_; "Job No.") { }
            column(Narration; Narration) { }
            column(AppliedEntriesExist; AppliedEntriesExist) { }
            trigger OnAfterGetRecord();
            var
                GLAccount: Record "G/L Account";
                Bank: Record "Bank Account";
            begin
                CLEAR(VendorRec);
                CLEAR(CustomerRec);
                CLEAR(GLAcctRec);
                CLEAR(FixedAssetRec);
                CLEAR(Employee);
                CLEAR(PaymentDesc);
                Clear(Caption1);

                if "G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::"Bank Account" then begin
                    Caption1 := 'BANK PAYMENT VOUCHER';

                end else begin
                    if "G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::"G/L Account" then
                        Caption1 := 'CASH PAYMENT VOUCHER';
                end;


                IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor THEN BEGIN
                    IF VendorRec.GET("G/L Entry"."Source No.") THEN
                        PaymentDesc := VendorRec.Name;
                    SourceNo := "G/L Entry"."Source No.";
                END
                ELSE
                    IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Customer THEN BEGIN
                        IF CustomerRec.GET("G/L Entry"."Source No.") THEN
                            PaymentDesc := CustomerRec.Name;
                        SourceNo := "G/L Entry"."Source No.";
                    END
                    ELSE
                        IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::" " THEN BEGIN
                            IF GLAcctRec.GET("G/L Entry"."G/L Account No.") THEN
                                PaymentDesc := GLAcctRec.Name;
                            SourceNo := "G/L Entry"."G/L Account No.";
                        END
                        ELSE
                            IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::"Fixed Asset" THEN BEGIN
                                IF FixedAssetRec.GET("G/L Entry"."Source No.") THEN
                                    PaymentDesc := FixedAssetRec.Description;
                                SourceNo := "G/L Entry"."Source No.";
                            END
                            ELSE
                                IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Employee THEN BEGIN
                                    IF Employee.GET("G/L Entry"."Source No.") THEN
                                        PaymentDesc := Employee."First Name" + ' ' + Employee."Last Name";
                                    SourceNo := "G/L Entry"."Source No.";
                                END;

                GLEntry2.RESET;
                GLEntry2.SETRANGE("Document No.", "G/L Entry"."Document No.");
                //GLEntry2.SETFILTER("Received From",'<>%1','');
                IF GLEntry2.FINDFIRST THEN BEGIN
                    //RecievedFrom := GLEntry2."Received From";
                    //Remarks := GLEntry2.Remark;
                END;

                GLEntry2.RESET;
                GLEntry2.SETRANGE("Document No.", "G/L Entry"."Document No.");
                //GLEntry2.SETRANGE("IBU Entry",FALSE);
                GLEntry2.SETFILTER("Credit Amount", '<>%1', 0);
                IF GLEntry2.FINDFIRST THEN BEGIN
                    PCTCode := GLEntry2."Global Dimension 1 Code";
                    IF GLEntry2."Source Type" = GLEntry2."Source Type"::"Bank Account" THEN BEGIN
                        HeaderCaption := 'CHEQUE';
                        //ChequeNo := GLEntry2."Cheque No.";
                        //ChequeDate := GLEntry2."Cheque Date";
                        DrawnOn := GLEntry2.Description;
                        //LT
                        IF Bank.GET(GLEntry2."Source No.") THEN BEGIN
                            DrawnOn := Bank.Name;
                        END;
                        //LT
                    END
                    ELSE BEGIN
                        HeaderCaption := 'CASH';
                        ChequeNo := '';
                        ChequeDate := 0D;
                        DrawnOn := GLEntry2.Description;
                        //LT
                        IF GLAccount.GET(GLEntry2."G/L Account No.") THEN BEGIN
                            DrawnOn := GLAccount.Name;
                        END;
                        //LT
                    END;
                END;


                if "G/L Entry"."Job No." <> '' then
                    Job := 'Job No.     :'
                else
                    Job := '';

                /*
                GLEntry2.RESET;
                GLEntry2.SETRANGE("Document No.","G/L Entry"."Document No.");
                GLEntry2.SETFILTER("Debit Amount",'>%1',0);
                GLEntry2.SETRANGE("IBU Entry",FALSE);
                IF GLEntry2.FINDFIRST THEN
                  BEGIN
                      TotalAmount += GLEntry2."Debit Amount";
                  END;
                */
                TotalAmount += "G/L Entry"."Debit Amount";
                GLSetup.Reset();
                GLSetup.Get();
                if Currencycode1 = '' then
                    Currencycode1 := GLSetup."LCY Code";


                AmtInWord.InitTextVariable();
                AmtInWord.FormatNoText(AmountText, TotalAmount, Currencycode1);


                /* Currencycode1 := 'AED';
                 InitTextVariable;
                 FormatNoText(AmountText, TotalAmount, 'AED');*/

                /*
                IF "G/L Entry"."Source No." <> '' THEN
                  SourceNo := "G/L Entry"."Source No."
                ELSE BEGIN
                 IF SourceNo = ''  THEN
                 SourceNo := "G/L Entry"."G/L Account No.";
                END;
                */

                DetailedVendLedgEntry.RESET;
                DetailedVendLedgEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                DetailedVendLedgEntry.SETRANGE("Entry Type", DetailedVendLedgEntry."Entry Type"::Application); // Saju 
                DetailedVendLedgEntry.SETRANGE("Initial Document Type", DetailedVendLedgEntry."Initial Document Type"::Invoice); // Saju
                IF DetailedVendLedgEntry.FINDFIRST THEN
                    AppliedEntriesExist := TRUE
                ELSE
                    AppliedEntriesExist := FALSE;

                //LT
                CLEAR(Users);
                Users.RESET;
                Users.SETRANGE(Users."User Name", "G/L Entry"."User ID");
                IF Users.FINDFIRST THEN;
                //LT

                // Start Print Check Date and Number
                ChqLedgerEntryRec.Reset();
                ChqLedgerEntryRec.SetRange("Document No.", "Document No.");
                ChqLedgerEntryRec.SetRange("Document Type", "Document Type");
                if ChqLedgerEntryRec.FindFirst() then begin
                    ChequeNo := ChqLedgerEntryRec."Check No.";
                    ChequeDate := ChqLedgerEntryRec."Check Date";
                end;
                // Stop Print Check Date and Number

            end;

            trigger OnPreDataItem();
            begin
                GLEntry.RESET;
                GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                IF GLEntry.FINDFIRST THEN
                    NoOfRecords := GLEntry.COUNT;
                ChequeNo := '';
                ChequeDate := 0D;
                RecievedFrom := '';
                Remarks := '';
                DrawnOn := '';
                AppliedDocNo := "G/L Entry"."Document No.";
                Clear(HeaderCaption);

                Clear(TotalAmount);
                GLSetup.GET;

                NoOfRecords := "G/L Entry".COUNT;
                IF NoOfRecords <= 10 THEN
                    NoOfRows := 10
                ELSE
                    IF (NoOfRecords > 10) AND (NoOfRecords <= 20) THEN
                        NoOfRows := 20
                    ELSE
                        IF (NoOfRecords > 20) AND (NoOfRecords <= 30) THEN
                            NoOfRows := 30
                        ELSE
                            IF (NoOfRecords > 30) AND (NoOfRecords <= 40) THEN
                                NoOfRows := 40
                            ELSE
                                NoOfRows := 50;
            end;
        }
        dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
        {
            DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type")
                                WHERE(Unapplied = CONST(false),
                                      "Entry Type" = CONST(Application),
                                     "Initial Document Type" = CONST(Invoice));
            column(AppliedVLENo_DtldVendLedgEntry; "Applied Vend. Ledger Entry No.")
            {
            }
            column(DetailAppliedAmount; Amount)
            {
            }
            column(AppliedPCTCode; VendorLedgerEntry."Global Dimension 1 Code")
            {
            }
            column(AppliedDocumentNo; VendorLedgerEntry."Document No.")
            {
            }
            column(AppliedExternalDocNo; VendorLedgerEntry."External Document No.")
            {
            }
            column(PCName; DimValue.Name)
            {
            }

            trigger OnAfterGetRecord();
            begin
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Entry No.", "Vendor Ledger Entry No.");
                IF VendorLedgerEntry.FINDFIRST THEN;

                DimValue.RESET;
                DimValue.SETRANGE(Code, VendorLedgerEntry."Global Dimension 1 Code");
                IF DimValue.FINDFIRST THEN;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Document No.", "G/L Entry"."Document No.");
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(TotalAmount; TotalAmount)
            {
            }
            column(AmountText1; AmountText[1])
            {
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin

        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        NoOfRows: Integer;
        NoOfRecords: Integer;
        GLEntry: Record "G/L Entry";
        GLEntry2: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        ChqLedgerEntryRec: Record "Check Ledger Entry";
        PCTCode: Code[20];
        ChequeNo: Text[20];
        ChequeDate: Date;
        RecievedFrom: Text[100];
        Remarks: Text;
        HeaderCaption: Text[100];
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label '" is already applied to %1 %2 for customer %3."';
        Text031: Label '" is already applied to %1 %2 for vendor %3."';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text1020: Label 'The total amount of check %1 is %2. The amount must be negative.';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        TotalAmount: Decimal;
        AmountText: array[2] of Text[250];
        DrawnOn: Text[250];
        AppliedDocNo: Code[20];
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DimValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        FixedAssetRec: Record "Fixed Asset";
        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
        GLAcctRec: Record "G/L Account";
        Employee: Record Employee;
        SourceNo: Code[20];
        AppliedEntriesExist: Boolean;
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        Currencycode1: Code[20];
        DecimalDesc: Text[20];
        PaymentDesc: Text[100];
        PageCaption: Label 'Page %1 of %2';
        Users: Record User;
        Caption1: Text[100];
        AmtInWord: Codeunit "Amount In Word LT";
        AmountInWords1: Text[100];
        Job: Text[250];




    local procedure AddToNoText(var NoText: array[2] of Text[250]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30]);
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable();
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    procedure FormatNoText(var NoText: array[2] of Text[250]; No: Decimal; CurrencyCode: Code[10]);
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
        DecimalPart: Integer;
        RecCurr: Record Currency;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := ' ';
        //GLSetup.GET;

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        //<LT> Standard code -
        /*
        AddToNoText(NoText,NoTextIndex,PrintExponent,Text028);
        DecimalPosition := GetAmtDecimalPosition;
        AddToNoText(NoText,NoTextIndex,PrintExponent,(FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));
        //<LT>
        
        //2008-12-04 START
        IF No <> 0 THEN BEGIN
          AddToNoText(NoText,NoTextIndex,PrintExponent,Text028);
          //AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + '/100');
          AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100));
        END;
        AddToNoText(NoText,NoTextIndex,PrintExponent,currency."Decimal Description"+ ' Only.');
        //2008-12-04 STOP
        
        IF CurrencyCode <> '' THEN
          //AddToNoText(NoText,NoTextIndex,PrintExponent,CurrencyCode);
          AddToNoText(NoText,NoTextIndex,PrintExponent,currency."Decimal Description");
        */

        //IF (DecimalPart <= 0)  THEN
        //AddToNoText(NoText,NoTextIndex,PrintExponent,'Only')
        //AddToNoText(NoText,NoTextIndex,PrintExponent,'')
        //ELSE
        AddToNoText(NoText, NoTextIndex, PrintExponent, '');//RecCurr.Description + "Sales Invoice Header"."Currency Code");
        //LCS - 090914
        //DecimalPosition := GetAmtDecimalPosition;
        IF No < 1 THEN BEGIN
            No := ROUND(No, 0.01, '>');
            DecimalPart := No * 100;
        END;

        //LCS - 090914
        IF DecimalPart > 0 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        //LCS - 090914

        IF (DecimalPart) < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, '' + 'ONLY')
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := DecimalPart DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                DecimalPart := DecimalPart - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);

                //<LT>
                RecCurr.RESET;
                IF RecCurr.GET(Currencycode1) THEN
                    DecimalDesc := '';
                IF (Exponent = 1) THEN
                    IF Currencycode1 <> 'AED' THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, DecimalDesc + ' Only')
                    ELSE
                        AddToNoText(NoText, NoTextIndex, PrintExponent, 'FILS' + ' ONLY');
                //<LT>
            END;

    end;

}

