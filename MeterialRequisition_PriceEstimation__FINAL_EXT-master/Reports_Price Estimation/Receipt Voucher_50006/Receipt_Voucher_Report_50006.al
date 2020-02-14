report 50006 "Receipt_Voucher"
{
    // version LT

    DefaultLayout = RDLC;
    //RDLCLayout = 'RDL_REPORT_FILE/Receipt Voucher.rdl';
    Caption = 'Receipt Voucher';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING ("Entry No.")
                                WHERE ("Credit Amount" = FILTER (<> 0));
            RequestFilterFields = "Document No.";
            column(PreparedBy; Users."Full Name") { }
            column(PageCaption; PageCaption) { }
            column(LCYCode; GLSetup."LCY Code") { }
            column(GLEntryNo; "G/L Entry"."Entry No.") { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyInfo_Postcode; CompanyInfo."Post Code") { }
            column(CompanyInfo_country; CompanyInfo."Country/Region Code") { }
            column(CompanyCountry; CompanyInfo."Country/Region Code") { }
            column(CompanyInfo_Tel; CompanyInfo."Phone No.") { }
            column(CompanyInfo_email; CompanyInfo."E-Mail") { }
            column(ProfitCenterCode; PCTCode) { }
            column(ChequeNo; ChequeNo) { }
            column(ChequeDate; ChequeDate) { }
            column(Job; Job) { }
            column(HeaderCaption; Caption1) { }
            column(RecievedFrom; RecievedFrom) { }
            column(Remarks; Remarks) { }
            column(AmountText2; AmountText[2]) { }
            column(DrawnOn; DrawnOn) { }
            column(PostingDate; "G/L Entry"."Posting Date") { }
            column(UserName; "G/L Entry"."User ID") { }
            column(DocNo; "G/L Entry"."Document No.") { }
            column(DivisionCode; "G/L Entry"."Global Dimension 2 Code") { }
            column(Dim1; "G/L Entry"."Global Dimension 1 Code") { }
            column(AccountNo; "G/L Entry"."G/L Account No.") { }
            column(Description; "G/L Entry".Description) { }
            column(Amount; "G/L Entry"."Debit Amount") { }
            column(TotalAmount; TotalAmount) { }
            column(AmountText1; AmountText[1]) { }
            column(CustName; CustName) { }
            column(PCTName; DimValue.Name) { }
            column(Narration; Narration) { }
            column(JobNo; "Job No.") { }
            column(AmountInWords1; AmountInWords1) { }
            column(Currencycode1; Currencycode1) { }
            column(BankName; BankName) { }



            trigger OnAfterGetRecord();
            var
                CustomerRec: Record Customer;
                VendorRec: Record Vendor;
                Employee: Record Employee;
                FixedAsset: Record "Fixed Asset";
                GLAccount: Record "G/L Account";
                Bank: Record "Bank Account";
            begin
                GLSetup.GET;
                GLEntry2.RESET;
                GLEntry2.SETRANGE("Document No.", "G/L Entry"."Document No.");
                //GLEntry2.SETFILTER("Received From",'<>%1','');
                IF GLEntry2.FINDFIRST THEN BEGIN
                    //    RecievedFrom := GLEntry2."Received From";
                    //  Remarks := GLEntry2.Remark;
                END;

                GLEntry2.RESET;
                GLEntry2.SETRANGE("Document No.", "G/L Entry"."Document No.");
                //GLEntry2.SETRANGE("IBU Entry",FALSE);
                //GLEntry2.SETFILTER("Cheque No.",'<>%1','');
                IF GLEntry2.FINDFIRST THEN BEGIN
                    //PCTCode := GLEntry2."Global Dimension 1 Code";
                    IF GLEntry2."Bal. Account Type" = GLEntry2."Bal. Account Type"::"Bank Account" THEN BEGIN
                        // HeaderCaption := 'BANK RECEIPT VOUCHER';
                        //   ChequeNo := GLEntry2."Cheque No.";
                        // ChequeDate := GLEntry2."Cheque Date";
                        DrawnOn := GLEntry2.Description;
                        //LT
                        IF Bank.GET(GLEntry2."Source No.") THEN BEGIN
                            DrawnOn := Bank.Name;
                        END;
                        //LT
                    END
                    ELSE BEGIN
                        if GLEntry2."Bal. Account Type" = GLEntry2."Bal. Account Type"::"G/L Account" then
                            // HeaderCaption := 'CASH RECEIPT VOUCHER';
                            //ChequeNo := GLEntry2."Cheque No.";
                            //ChequeDate := GLEntry2."Cheque Date";
                            DrawnOn := GLEntry2.Description;
                        //LT
                        IF GLAccount.GET(GLEntry2."G/L Account No.") THEN BEGIN
                            DrawnOn := GLAccount.Name;
                        END;
                        //LT
                    END;
                END;

                if "G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::"Bank Account" then begin
                    Caption1 := 'BANK RECEIPT VOUCHER'

                end else
                    if "G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::"G/L Account" then begin
                        Caption1 := 'CASH RECEIPT VOUCHER';
                    end;

                if "G/L Entry"."Job No." <> '' then
                    Job := 'Job No.   :'
                else
                    Job := '';




                GLEntry2.RESET;
                GLEntry2.SETRANGE("Document No.", "G/L Entry"."Document No.");
                //GLEntry2.SETRANGE("IBU Entry",FALSE);
                GLEntry2.SETFILTER("Credit Amount", '<>%1', 0);
                IF GLEntry2.FINDFIRST THEN BEGIN
                    PCTCode := GLEntry2."Global Dimension 1 Code";
                END;





                GLEntry2.RESET;
                GLEntry2.SETRANGE("Document No.", "G/L Entry"."Document No.");
                //GLEntry2.SETRANGE("IBU Entry",FALSE);
                //GLEntry2.SETRANGE("Source Type",GLEntry2."Source Type"::"Bank Account");
                //GLEntry2.SETFILTER("Bank /Cash",'<>%1','');
                IF GLEntry2.FINDFIRST THEN BEGIN
                    //BankName := GLEntry2."Bank /Cash";
                END;
                ;
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
                TotalAmount += ABS("G/L Entry"."Credit Amount");

                // if Currencycode1 ='' then
                //    Currencycode1 :=GLSetup.
                GLSetup.Reset();
                GLSetup.Get();
                if Currencycode1 = '' then
                    Currencycode1 := GLSetup."LCY Code";


                AmtInWord.InitTextVariable();
                AmtInWord.FormatNoText(AmountText, TotalAmount, Currencycode1);
                AmountInWords1 := AmountText[1];



                IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Customer THEN BEGIN
                    CustomerRec.SETRANGE("No.", "G/L Entry"."Source No.");
                    IF CustomerRec.FINDFIRST THEN
                        CustName := CustomerRec."No." + ' - ' + CustomerRec.Name;
                END
                ELSE
                    IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor THEN BEGIN
                        VendorRec.SETRANGE("No.", "G/L Entry"."Source No.");
                        IF VendorRec.FINDFIRST THEN
                            CustName := VendorRec."No." + ' - ' + VendorRec.Name;
                    END
                    ELSE
                        IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Employee THEN BEGIN
                            Employee.RESET;
                            Employee.SETRANGE("No.", "G/L Entry"."Source No.");
                            IF Employee.FINDFIRST THEN
                                CustName := Employee."No." + ' - ' + Employee."First Name" + ' ' + Employee."Middle Name";
                        END
                        ELSE
                            IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::"Fixed Asset" THEN BEGIN
                                FixedAsset.RESET;
                                FixedAsset.SETRANGE("No.", "G/L Entry"."Source No.");
                                IF FixedAsset.FINDFIRST THEN
                                    CustName := FixedAsset."No." + ' - ' + FixedAsset.Description;
                            END
                            ELSE BEGIN
                                IF GLAccount.GET("G/L Entry"."G/L Account No.") THEN
                                    CustName := GLAccount."No." + ' - ' + GLAccount.Name
                                ELSE
                                    CustName := "G/L Entry".Description;
                            END;



                CLEAR(DimValue);
                IF PCTCode <> '' THEN BEGIN
                    DimValue.RESET;
                    DimValue.SETRANGE(Code, PCTCode);
                    IF DimValue.FINDFIRST THEN;
                END;

                //LT
                CLEAR(Users);
                Users.RESET;
                Users.SETRANGE(Users."User Name", "G/L Entry"."User ID");
                IF Users.FINDFIRST THEN;
                //LT

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
                CustName := '';
                Clear(HeaderCaption);
                Clear(JobNo);
            end;
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
        NoOfRows := 10;
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
        PCTCode: Code[20];
        ChequeNo: Text[20];
        ChequeDate: Date;
        RecievedFrom: Text[100];
        Remarks: Text;

        AmountInWords1: Text[100];
        HeaderCaption: Text[100];
        Caption1: Text[20];
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
        CustName: Text[100];
        BankName: Text[100];
        GLSetup: Record "General Ledger Setup";
        Currencycode1: Text[20];
        DecimalDesc: Text[20];
        PageCaption: Label 'Page %1 of %2';
        JobNo: Code[20];
        Users: Record User;
        Job: Text[250];

        AmtInWord: Codeunit "Amount In Word LT";













}

