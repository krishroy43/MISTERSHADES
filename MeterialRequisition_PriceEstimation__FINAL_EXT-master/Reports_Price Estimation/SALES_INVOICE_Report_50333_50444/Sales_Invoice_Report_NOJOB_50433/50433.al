report 50433 "Sales Invoice Report NOJOB"
{
    DefaultLayout = RDLC;
    Caption = 'Sales Invoice Report NOJOB';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";

            column(Doc_No; "No.")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(CustName; CustRec.Name)
            { }
            column(CustRec_No; CustRec."No.")
            { }
            Column(CustPhone; CustRec."Phone No.")
            { }
            column(CustFax; CustRec."Fax No.")
            { }
            column(Cust_Address; CustRec.Address)
            { }
            column(Cust_Add2; CustRec."Address 2")
            { }
            column(CustRec_City; CustRec.City)
            { }
            column(CustRec_PostCode; CustRec."Post Code")
            { }
            column(CustRec_Country; CustRec."Country/Region Code")
            { }
            column(CustMail; CustRec."E-Mail")
            { }
            column(ContactPerson; CustRec.Contact)
            { }
            column(CustTRN; CustRec."VAT Registration No.")
            { }
            column(Comp_Logo; CompInfoRec.Picture)
            { }
            column(Comp_Name; CompInfoRec.Name)
            { }
            column(Comp_TNR; CompInfoRec."VAT Registration No.")
            { }
            column(ExtDocNo; "External Document No.")
            { }
            column(CommentDescriptionBigTextG; CommentDescriptionBigTextG)
            { }
            column(PaymentTerms; PaymentTerms.Description)
            { }
            // Start Bank Account Details
            column(BankName; BankAccRec.name)
            { }
            column(Account_Name; CompInfoRec.Name)
            { }
            column(AccNo; BankAccRec."Bank Account No.")
            { }
            column(BankSwift; BankAccRec."SWIFT Code")
            { }
            column(BankIBAN; BankAccRec.IBAN)
            { }
            column(BankBranchNo; BankAccRec."Bank Branch No.")
            { }
            // Stop Bank Account Details
            // Start 28-08-2019
            column(CurrCode; CurrCode)
            { }
            column(Salesperson_Code; "Salesperson Code")
            { }
            column(Work_Done; "Work Done")
            { }
            column(External_Document_No_; "External Document No.")
            { }
            column(Final_AmountIncludingVAT; FindFinalAmount("No."))
            { }
            column(SalesLineAmountIncVATDecG; SalesLineAmountIncVATDecG)
            { }
            column(AmountInWordForWithoutJob; AmountInWordForWithoutJob[1])
            { }

            column(AmountInWordForJob; AmountInWordForJob[1])
            { }
            // Stop 28-08-2019
            column(SUM_VAT_Base_Amount_99; SUM_VAT_Base_Amount_99)
            { }
            column(TotalLineAmount; TotalLineAmount)
            { }
            column(SUM_Amount_Inc_VAT_30; SUM_Amount_Inc_VAT_30)
            { }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(SL_No; SL_No)
                { }
                column(No_Sline; "No.")
                { }
                column(Description_SLine; Description)
                { }
                column(Description_2; "Description 2")
                { }
                column(Narration; Narration)
                { }
                column(VAT_SLine; "Amount Including VAT" - Amount)
                { }
                column(VAT__; "VAT %")
                { }
                column(Unit_Price; Amount)
                { }
                column(Price; "Unit Price")
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                { }
                column(Line_No_; "Line No.")
                { }
                // Start Modification for No Job
                column(VAT_Base_Amount_99; "VAT Base Amount")
                { }
                column(Amount_Including_VAT_30; "Amount Including VAT")
                { }
                column(AmtVat_30; AmtVat)
                { }
                // Stop Modification for No Job 
                column(Amount_Including_VAT; "Amount Including VAT")
                { }
                column(AmtWord; AmtWord)
                { }
                column(Job_No_; "Job No.")
                { }
                column(Description; Description)
                { }
                column(CLE__OriginalAmount; CleInvAmt)
                { }
                column(CLE_Invoice_No; CleInvoiceNo)
                { }
                column(MileStoneDesc; MileStoneDesc) { }
                column(TotalPaymentMileStoneAmount; TotalPaymentMileStoneAmount)
                { }
                column(TotalInvoiceAmountWithoutTax; TotalInvoiceAmountWithoutTax)
                { }

                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    column(CLE_Document_No_; "Document No.")
                    { }
                    column(CLE_Amount; Amount)
                    { }
                    trigger
                    OnPreDataItem()
                    begin
                        Clear(TotalInvoiceAmountWithoutTax);
                        "Cust. Ledger Entry".Reset();
                        "Cust. Ledger Entry".SetRange("Customer No.", "Sales Invoice Header"."Bill-to Customer No.");
                        "Cust. Ledger Entry".SetRange("Document Type", "Document Type"::Invoice);
                        "Cust. Ledger Entry".SetRange("Job No.", "Sales Invoice Line"."Job No.");
                        if "Cust. Ledger Entry".FindSet() then;
                    end;

                    trigger
                    OnAfterGetRecord()
                    begin
                        if "Document No." <> ' ' then
                            TotalInvoiceAmountWithoutTax += (Amount - (Amount * "Sales Invoice Line"."VAT %") / 100);
                    end;

                    trigger
                    OnPostDataItem()
                    begin

                    end;
                }
                dataitem(BodyLoop_PaymentMilestone; "Payment Milestone")
                {
                    DataItemLinkReference = "Sales Invoice Line";
                    DataItemTableView = WHERE("Document Type" = FILTER(Job), "Posting Type" = filter(Advance | Retention));
                    DataItemLink = "Document No." = field("Job No.");
                    column(Body_MilestonePer; "Milestone %")
                    { }
                    column(Body_Amount; Amount)
                    { }
                    column(Body_Milestone_Description; "Milestone Description")
                    { }
                    column(Body_Posting_Type; "Posting Type")
                    { }
                    trigger
                    OnPreDataItem()
                    begin
                        Clear(TotalPaymentMileStoneAmount);
                    end;

                    trigger
                    OnAfterGetRecord()
                    begin
                        if Amount <> 0 then
                            TotalPaymentMileStoneAmount += Amount;
                    end;

                    trigger
                    OnPostDataItem()
                    begin

                    end;

                }
                /* dataitem("Sales Inv. Payment Milestone"; "Payment Milestone")
                 {

                     DataItemLinkReference = "Sales Invoice Header";
                     DataItemTableView = WHERE ("Document Type" = FILTER ('Posted Invoice'));
                     DataItemLink = "Document No." = field ("No.");

                     column(SalesInv_MilestonePer; "Milestone %")
                     { }
                     // column(SalesInv_Milestone_Description; "Milestone Description")
                     // { }
                     column(SalesInv_Milestone_Description; "Payment Terms")
                     { }
                     column(Posting1Type; "Posting Type") { }
                     trigger
                     OnAfterGetRecord()
                     var
                         // SalesLineRec: Record "Sales Line";
                         SalesInvoiceLine_Rec: Record "Sales Invoice Line";
                     begin
                         // Message('%1', "Milestone Description");

                         SalesInvoiceLine_Rec.Reset();
                         SalesInvoiceLine_Rec.SetRange("Document No.", "Document No.");
                         //  SalesInvoiceLine_Rec.SetRange("Document Type", "Document Type");
                         SalesInvoiceLine_Rec.SetFilter("Job No.", '<>%1', '');
                         if SalesInvoiceLine_Rec.FindFirst() then
                             CurrReport.Skip();


                     end;


                 }*/

                dataitem(Job; Job)
                {
                    DataItemLink = "No." = field("Job No.");
                    column(JobRecNo; "No.")
                    { }
                    column(BillTotPrice; BillTotPrice)
                    { }
                    column(BillInvPrice; BillInvPrice)
                    { }
                    column(Project_Amount__Planned_; "Project Amount (Planned)")
                    { }
                    column(Customer_PO_No_; "Customer PO No.")
                    { }
                    column(Customer_Po__Date_; "Customer Po. Date.")
                    { }
                    column(Project__Description; Description)
                    { }

                    dataitem("Payment Milestone"; "Payment Milestone")
                    {
                        DataItemLinkReference = Job;
                        DataItemTableView = WHERE("Document Type" = FILTER(Job));
                        DataItemLink = "Document No." = field("No.");

                        column(Payment_Terms; "Payment Terms")
                        { }
                        column(MilestonePer; "Milestone %")
                        { }
                        column(Amount; Amount)
                        { }
                        column(Milestone_Description; "Milestone Description")
                        { }
                        column(Posting_Type; "Posting Type")
                        { }




                    }
                    //Job.
                    trigger OnPreDataItem();
                    begin
                        Clear(BillInvPrice);
                        Clear(BillInvPrice);
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        if JobTaskRec.Get(job."No.") then begin
                            BillTotPrice := JobTaskRec."Contract (Total Price)";
                            BillInvPrice := JobTaskRec."Contract (Invoiced Price)";

                        end;

                    end;

                }
                //Sales Line
                trigger OnPreDataItem();
                begin
                    Clear(AmtVat);
                    CLEAR(SL_No);
                    CheckRep.InitTextVariable;
                    Clear(SalesLineAmountIncVATDecG);
                    Clear(SUM_VAT_Base_Amount_99);
                    Clear(SUM_Amount_Inc_VAT_30);
                    clear(TotalLineAmount);
                end;

                trigger OnAfterGetRecord();
                begin
                    clear(CleInvAmt);
                    Clear(CleInvoiceNo);
                    /*ItemRec.RESET;
                    IF ItemRec.GET("No.") THEN;*/
                    if ("No." <> '') AND ((Type = Type::"Charge (Item)") OR (Type = Type::"Fixed Asset") OR
                                  (Type = Type::"G/L Account") OR (Type = Type::Item) OR (Type = Type::Resource)) then
                        SL_No += 1;


                    AmtVat += "Amount Including VAT";

                    // CheckRep.FormatNoText(NoText, AmtVat, '');

                    AmountInWordCodeunitCU.InitTextVariable();
                    AmountInWordCodeunitCU.FormatNoText(AmountInWordForWithoutJob, ((("Sales Invoice Header"."Work Done" * "VAT %") / 100) + "Sales Invoice Header"."Work Done"), CurrCode);

                    AmtWord := CurrCode + ' ' + NoText[1];
                    if "No." <> '' then begin
                        TotalLineAmount += "Line Amount" + "Line Discount Amount" + "Inv. Discount Amount";
                        SalesLineAmountIncVATDecG += "Amount Including VAT";
                        SUM_VAT_Base_Amount_99 += "VAT Base Amount";
                        SUM_Amount_Inc_VAT_30 += "Amount Including VAT";
                    end;
                end;

                trigger
                OnPostDataItem()
                begin

                end;

            }


            dataitem("Sales Inv. Payment Milestone"; "Payment Milestone")
            {

                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = WHERE("Document Type" = FILTER("Posted Invoice"));
                DataItemLink = "Document No." = field("No.");

                column(SalesInv_MilestonePer; "Milestone %")
                { }
                // column(SalesInv_Milestone_Description; "Milestone Description")
                // { }
                column(SalesInv_Milestone_Description; "Payment Terms")
                { }
                column(Posting1Type; "Posting Type") { }
                trigger
                OnAfterGetRecord()
                var
                    // SalesLineRec: Record "Sales Line";
                    SalesInvoiceLine_Rec: Record "Sales Invoice Line";
                begin
                    // Message('%1', "Milestone Description");

                    SalesInvoiceLine_Rec.Reset();
                    SalesInvoiceLine_Rec.SetRange("Document No.", "Document No.");
                    //  SalesInvoiceLine_Rec.SetRange("Document Type", "Document Type");
                    SalesInvoiceLine_Rec.SetFilter("Job No.", '<>%1', '');
                    if SalesInvoiceLine_Rec.FindFirst() then
                        CurrReport.Skip();


                end;


            }
            //Sales Header
            trigger OnPreDataItem();
            begin
                BankAccRec.Reset;
                BankAccRec.SetRange("No.", BankAccNoCodeG);
                if BankAccRec.FindFirst then;
                Clear(FinalAmountIncludingVAT);

                // Message('Sales header PRe');

            end;

            trigger OnAfterGetRecord();
            var
                //SalesLineRec: Record "Sales Line";
                AincVatDec: Decimal;
                // SalesHEader: Integer;
                SalesInvoiceLine_Rec: Record "Sales Invoice Line";
                SalesInvoiceHeader: Integer;
                VATAmountDec: Decimal;
                AfterMinusFromWorkDone: Decimal;
            begin
                Clear(MileStoneDesc);
                CustRec.Reset;
                if CustRec.Get("Sell-to Customer No.") then;

                // Message('report %1   Cust %2', "No.", CustRec."No.");

                if "Currency Code" = '' then
                    CurrCode := 'AED'
                else
                    CurrCode := "Currency Code";

                if "Sales Invoice Header"."Payment Terms Code" <> '' then begin
                    PaymentTerms.reset;
                    PaymentTerms.SetRange(Code, "Sales Invoice Header"."Payment Terms Code");
                    if PaymentTerms.findfirst then;
                end;
                ReadCommentFromSalesCommentLine("No.");

                SalesInvoiceLine_Rec.Reset();
                SalesInvoiceLine_Rec.SetRange("Document No.", "No.");
                // SaleaInvoiceLine_Rec.SetRange("Document Type", "Document Type");
                SalesInvoiceLine_Rec.SetFilter("Job No.", '<>%1', '');
                if (SalesInvoiceLine_Rec.FindFirst()) and (SalesInvoiceHeader = 0) then begin
                    if SalesInvoiceLine_Rec."Job No." <> '' then begin
                        FinalAmountIncludingVAT := FindFinalAmount__RDLC(SalesInvoiceLine_Rec."Document No.");
                        AmountInWordCodeunitCU.InitTextVariable();
                        AmountInWordCodeunitCU.FormatNoText(AmountInWordForJob, FinalAmountIncludingVAT, CurrCode);
                    end;
                end else begin
                    AincVatDec := AmountIncVATTotal("No.");
                    FinalAmountIncludingVAT := FindFinalAmount__RDLC("Sales Invoice Header"."No.");
                    AmountInWordCodeunitCU.InitTextVariable();
                    AmountInWordCodeunitCU.FormatNoText(AmountInWordForJob, FinalAmountIncludingVAT, CurrCode);

                    // // AmountInWordCodeunitCU.InitTextVariable();
                    // // AmountInWordCodeunitCU.FormatNoText(AmountInWordForWithoutJob, AmtVat, CurrCode);
                end;

                // Message('report %1   Cust %2', "No.", CustRec."No.");


                /*  PaymentMileStoneRecG.Reset();
                  PaymentMileStoneRecG.SetRange("Document Type", PaymentMileStoneRecG."Document Type"::"Posted Invoice");
                  PaymentMileStoneRecG.SetRange("Document No.", "Sales Invoice Header"."No.");
                  if PaymentMileStoneRecG.FindSet() then begin
                      repeat
                          MileStoneDesc := PaymentMileStoneRecG."Milestone Description";
                          Message('%1', MileStoneDesc);
                      until PaymentMileStoneRecG.Next() = 0;
                  end;*/

            end;

        }

    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group("General")
                {
                    field(BankAccNoCodeG; BankAccNoCodeG)
                    {
                        ApplicationArea = All;
                        Caption = 'Bank Accoutnt No.';
                        TableRelation = "Bank Account";
                    }
                }
            }
        }
    }
    trigger OnPreReport();
    begin
        CompInfoRec.GET;
        CompInfoRec.CALCFIELDS(Picture);
        //Message('Pre Report');
    end;

    trigger
    OnInitReport()
    begin
        //Message('on init report');
    end;

    trigger
    OnPostReport()
    begin

        //Message('Post ');
    end;

    var
        CompInfoRec: Record "Company Information";
        ItemRec: Record Item;
        VendRec: Record Vendor;
        SL_No: Integer;
        TotalAmt: Decimal;
        CheckRep: Report Check;
        NoText: array[1] of Text;
        AmtWord: Text[100];
        AmtVat: Decimal;
        CustRec: Record Customer;
        ROE: Decimal;
        BankAccRec: Record "Bank Account";
        CurrCode: Code[10];
        PaymentTerms: Record "Payment Terms";
        BillTotPrice: Decimal;
        JobTaskRec: Record "Job Task";
        BillInvPrice: Decimal;
        CustLedEnt: Record "Cust. Ledger Entry";
        CustLedEnt2: Record "Cust. Ledger Entry";
        CleInvAmt: Decimal;
        CleInvoiceNo: Code[20];
        CommentDescriptionBigTextG: Text;
        SalesCommentLineRecG: Record "Sales Comment Line";
        JobRecG: Record Job;
        BankAccNoCodeG: Code[30];
        TotalPaymentMileStoneAmount: Decimal;
        TotalInvoiceAmountWithoutTax: Decimal;
        FinalAmountIncludingVAT: Decimal;
        PaymentMileStoneRecG: Record "Payment Milestone";
        SalesLineAmountIncVATDecG: Decimal;
        AmountInWordForJob: array[2] of Text[250];
        AmountInWordForWithoutJob: array[2] of Text[250];
        AmountInWordCodeunitCU: Codeunit "Amount In Word LT";
        SetTotalPaymentMileStoneAmountG: Decimal;
        SetTotalInvoiceAmountWithoutTaxG: Decimal;
        SUM_VAT_Base_Amount_99: Decimal;
        SUM_Amount_Inc_VAT_30: Decimal;
        MileStoneDesc: Text[250];
        TotalLineAmount: Decimal;

    procedure ReadCommentFromSalesCommentLine(DocNo: Code[20])
    begin
        Clear(CommentDescriptionBigTextG);
        SalesCommentLineRecG.Reset();
        SalesCommentLineRecG.SetRange("No.", DocNo);
        SalesCommentLineRecG.SetRange("Document Type", SalesCommentLineRecG."Document Type"::Invoice);
        SalesCommentLineRecG.SetFilter("Term/Condition", '%1', 'PMNT');
        if SalesCommentLineRecG.FindSet() then begin
            repeat
                CommentDescriptionBigTextG += SalesCommentLineRecG.Comment;
            until SalesCommentLineRecG.Next() = 0;
        END;
    end;

    procedure FindFinalAmount(DocNo: code[30]): Decimal
    var
        AfterMinusFromWorkDone: Decimal;
        VATAmountDec: Decimal;
        // salesHeaderRec: Record "Sales Header";
        //  SalesLineRec: Record "Sales Line";
        SalesInvoiceHeader_Rec: Record "Sales Invoice Header";
        SalesInvoiceLine_Rec: Record "Sales Invoice Line";
        InvoiceAmountWithoutTax: Decimal;
    begin
        //Message('J %1', JobNo);
        SalesInvoiceHeader_Rec.Reset();
        Clear(FinalAmountIncludingVAT);
        Clear(AfterMinusFromWorkDone);
        Clear(VATAmountDec);
        //  if SalesInvoiceHeader_Rec.Get(salesHeaderRec."Document Type"::Invoice, DocNo) then begin
        SalesInvoiceLine_Rec.Reset();
        SalesInvoiceLine_Rec.SetRange("Document No.", SalesInvoiceHeader_Rec."No.");
        //   SalesLineRec.SetRange("Document Type", salesHeaderRec."Document Type");
        if SalesInvoiceLine_Rec.FindFirst() then begin
            AfterMinusFromWorkDone := (SalesInvoiceHeader_Rec."Work Done" - (TotalPaymentMileStoneAmount + TotalInvoiceAmountWithoutTax));////(Fun_TotalInvoiceAmountWithoutTax(salesHeaderRec."No.", SalesLineRec."Job No.") + Fun_TotalPaymentMileStoneAmount(SalesLineRec."Job No.")));////(TotalPaymentMileStoneAmount + TotalInvoiceAmountWithoutTax));
            VATAmountDec := ((AfterMinusFromWorkDone * SalesInvoiceLine_Rec."VAT %") / 100);
            exit(VATAmountDec + AfterMinusFromWorkDone);
        end;
    end;
    // end;

    procedure AmountIncVATTotal(DocNo: code[30]): Decimal
    var
        VATAmountDec: Decimal;
        // salesHeaderRec: Record "Sales Header";
        //SalesLineRec: Record "Sales Line";
        SalesInvoiceHeader_Rec: Record "Sales Invoice Header";
        SalesInvoiceLine_Rec: Record "Sales Invoice Line";
    begin
        SalesInvoiceHeader_Rec.Reset();
        Clear(VATAmountDec);
        //   if SalesInvoiceHeader_Rec.Get(salesHeaderRec."Document Type"::Invoice, DocNo) then begin
        SalesInvoiceLine_Rec.Reset();
        SalesInvoiceLine_Rec.SetRange("Document No.", SalesInvoiceHeader_Rec."No.");
        // SalesInvoiceLine_Rec.SetRange("Document Type", salesHeaderRec."Document Type");
        if SalesInvoiceLine_Rec.FindSet() then begin
            repeat
                VATAmountDec += SalesInvoiceLine_Rec."Amount Including VAT";
            until SalesInvoiceLine_Rec.Next() = 0;
        end;
        exit(VATAmountDec);
    end;
    //  end;

    // Amount in word for RDLC Report
    procedure FindFinalAmount__RDLC(DocNo: code[30]): Decimal
    var
        AfterMinusFromWorkDone: Decimal;
        VATAmountDec: Decimal;
        // salesHeaderRec: Record "Sales Header";
        //  SalesLineRec: Record "Sales Line";
        SalesInvoiceHeader_Rec: Record "Sales Invoice Header";
        SalesInvoiceLine_Rec: Record "Sales Invoice Line";
        InvoiceAmountWithoutTax: Decimal;
        PaymentMilestoneRecL: Record "Payment Milestone";
        TotalPaymentMileStoneAmount_Val: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TotalInvoiceAmountWithoutTax_Val: Decimal;
    begin


        Clear(TotalInvoiceAmountWithoutTax_Val);
        Clear(TotalPaymentMileStoneAmount_Val);
        Clear(FinalAmountIncludingVAT);
        Clear(AfterMinusFromWorkDone);
        Clear(VATAmountDec);
        // Start Sales Header
        SalesInvoiceHeader_Rec.Reset();
        //  if SalesInvoiceHeader_Rec.Get(salesHeaderRec."Document Type"::Invoice, DocNo) then begin
        SalesInvoiceLine_Rec.Reset();
        SalesInvoiceLine_Rec.SetRange("Document No.", DocNo);
        // SalesLineRec.SetRange("Document Type", salesHeaderRec."Document Type");
        if SalesInvoiceLine_Rec.FindFirst() then
            repeat
                FinalAmountIncludingVAT += SalesInvoiceLine_Rec."Amount Including VAT";
            // Stop Sales Header               
            // CustLedgerEntry.Reset();
            // CustLedgerEntry.SetRange("Customer No.", SalesInvoiceHeader_Rec."Sell-to Customer No.");
            // CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
            // CustLedgerEntry.SetRange("Job No.", SalesInvoiceLine_Rec."Job No.");
            // if CustLedgerEntry.FindSet() then
            //     repeat
            //         if CustLedgerEntry."Document No." <> '' then begin
            //             CustLedgerEntry.CalcFields(Amount, "Original Amount");
            //             TotalInvoiceAmountWithoutTax_Val += (CustLedgerEntry.Amount - (CustLedgerEntry.Amount * SalesInvoiceLine_Rec."VAT %") / 100);
            //         end;
            //     until CustLedgerEntry.Next() = 0;


            // PaymentMilestoneRecL.Reset();
            // PaymentMilestoneRecL.SetRange("Document No.", SalesInvoiceLine_Rec."Job No.");
            // PaymentMilestoneRecL.SetRange("Document Type", PaymentMilestoneRecL."Document Type"::Job);
            // PaymentMilestoneRecL.SetFilter("Posting Type", '%1|%2', PaymentMilestoneRecL."Posting Type"::Advance, PaymentMilestoneRecL."Posting Type"::Retention);
            // if PaymentMilestoneRecL.FindSet() then
            //     repeat
            //         TotalPaymentMileStoneAmount_Val += PaymentMilestoneRecL.Amount;
            //     until PaymentMilestoneRecL.Next() = 0;

            // // Message('TotalInvoiceAmountWithoutTax_Val %1 ', TotalInvoiceAmountWithoutTax_Val);
            // // Message('TotalPaymentMileStoneAmount_Val %1', TotalPaymentMileStoneAmount_Val);
            // // Message('salesHeaderRec."Work Done" %1 VAT %2', salesHeaderRec."Work Done", "Sales Line"."VAT %");

            // AfterMinusFromWorkDone := (SalesInvoiceHeader_Rec."Work Done" - (TotalPaymentMileStoneAmount_Val + TotalInvoiceAmountWithoutTax_Val));
            // VATAmountDec := ((AfterMinusFromWorkDone * SalesInvoiceLine_Rec."VAT %") / 100);
            // exit(VATAmountDec + AfterMinusFromWorkDone);
            until SalesInvoiceLine_Rec.next = 0;
        exit(FinalAmountIncludingVAT);
    end;
    //  end;



}

