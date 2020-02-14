report 50124 "Sales Invoice"
{
    // version MSBM

    DefaultLayout = RDLC;
    // RDLCLayout = 'SalesInv_ProformaRDL_New.rdl';
    Caption = 'Sales Invoice';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING ("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";

            column(Doc_No; "No.")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(CustName; CustRec.Name)
            { }
            Column(CustPhone; CustRec."Phone No.")
            { }
            column(CustFax; CustRec."Fax No.")
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
            column(BankName; BankAccRec.name)
            { }
            column(AccNo; CompInfoRec."Bank Account No.")
            { }
            column(BankSwift; CompInfoRec."SWIFT Code")
            { }
            column(BankIBAN; CompInfoRec.IBAN)
            { }
            column(BankBranchNo; BankAccRec."Bank Branch No.")
            { }
            column(CommentDescriptionBigTextG; CommentDescriptionBigTextG) { }
            //column()
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                column(SL_No; SL_No)
                { }
                column(No_Sline; "No.")
                { }
                column(Description_SLine; Description)
                { }
                column(VAT_SLine; "Amount Including VAT" - Amount)
                { }
                column(Unit_Price; Amount)
                { }
                column(Amount_Including_VAT; "Amount Including VAT")
                { }
                column(AmtWord; AmtWord)
                { }
                column(Job_No_; "Job No.")
                { }
                column(Description; Description)
                { }
                column(CleInvAmt; CleInvAmt)
                { }
                column(CleInvoiceNo; CleInvoiceNo)
                { }
                dataitem(Job; Job)
                {
                    DataItemLink = "No." = field ("Job No.");
                    column(JobRecNo; "No.")
                    { }
                    column(BillTotPrice; BillTotPrice)
                    { }
                    column(BillInvPrice; BillInvPrice)
                    { }

                    dataitem("Payment Milestone"; "Payment Milestone")
                    {
                        DataItemLinkReference = Job;
                        DataItemTableView = WHERE ("Document Type" = FILTER (Job));
                        DataItemLink = "Document No." = field ("No.");

                        column(Payment_Terms; "Payment Terms")
                        { }
                        column(MilestonePer; "Milestone %")
                        { }
                        column(Amount; Amount)
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
                        if JobTaskRec.Get(job."No.") then;
                        BillTotPrice := JobTaskRec."Contract (Total Price)";
                        BillInvPrice := JobTaskRec."Contract (Invoiced Price)";
                        //JobTaskRec.
                    end;

                }

                //Sales Inv Line    
                trigger OnPreDataItem();
                begin
                    Clear(AmtVat);
                    CLEAR(SL_No);
                    CheckRep.InitTextVariable;

                end;

                trigger OnAfterGetRecord();
                begin
                    clear(CleInvAmt);
                    Clear(CleInvoiceNo);
                    /*ItemRec.RESET;
                    IF ItemRec.GET("No.") THEN;*/
                    SL_No += 1;
                    AmtVat += "Amount Including VAT";

                    CheckRep.FormatNoText(NoText, AmtVat, '');
                    AmtWord := CurrCode + ' ' + NoText[1];


                    CustLedEnt.Reset();
                    CustLedEnt.SetRange("Customer No.", "Sell-to Customer No.");
                    if CustLedEnt.FindFirst() then begin
                        CustLedEnt.SetRange("Job No.", "Job No.");
                        CustLedEnt.SetRange("Document Type", CustLedEnt."Document Type"::Invoice);
                        if CustLedEnt.FindSet then begin
                            CleInvAmt := CustLedEnt.Amount;
                            CleInvoiceNo := CustLedEnt."Document No.";
                        end;

                    end;
                end;

            }
            //Sales Inv Header
            trigger OnPreDataItem();
            begin
                // Clear(ROE);
                ReadCommentFromSalesCommentLine("No.");
            end;

            trigger OnAfterGetRecord();
            begin
                CustRec.Reset;
                if CustRec.Get("Sell-to Customer No.") then;

                BankAccRec.Reset;
                BankAccRec.SetRange("Bank Account No.", CompInfoRec."Bank Account No.");
                if BankAccRec.FindFirst then;

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
        AmtWord: Text[100];
        AmtVat: Decimal;
        CustRec: Record Customer;
        ROE: Decimal;
        BankAccRec: Record "Bank Account";
        CurrCode: Code[10];
        BillTotPrice: Decimal;
        JobTaskRec: Record "Job Task";
        BillInvPrice: Decimal;
        CustLedEnt: Record "Cust. Ledger Entry";
        CleInvAmt: Decimal;
        CleInvoiceNo: Code[20];
        CommentDescriptionBigTextG: Text;
        SalesCommentLineRecG: Record "Sales Comment Line";
        Ostream: OutStream;


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
}