report 50025 "Job Report WIP"
{
    UsageCategory = Administration;
    ApplicationArea = All;


    dataset
    {
        dataitem(Job_DT; Job)
        {
            RequestFilterFields = "No.", "Creation Date", "Posting Date Filter";
            DataItemTableView = sorting ("No.");

            column(No_; "No.") { }
            column(Creation_Date; Format("Creation Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(AmountGLEntryDecG; AmountGLEntryDecG) { }
            column(PaymentAmountCLEDecG; PaymentAmountCLEDecG) { }
            //column(RefundAmountCLEDecG; RefundAmountCLEDecG) { }
            column(RefundAmountCLE; RefundAmountCLEDecG) { }

            dataitem(JobTask_DT; "Job Task")
            {
                DataItemLinkReference = Job_DT;
                DataItemLink = "Job No." = FIELD ("No.");
                DataItemTableView = sorting ("Job No.");

                column(BillableTotalPrice; "Contract (Total Price)") { }
                column(BillableInvoicePrice; "Contract (Invoiced Price)") { }

                dataitem(CustLedgerEntry_DT_Payment; "Cust. Ledger Entry")
                {
                    DataItemLinkReference = JobTask_DT;
                    DataItemLink = "Job No." = field ("Job No."), "Job Task No." = field ("Job Task No.");
                    DataItemTableView = SORTING ("Entry No.") ORDER(Ascending) WHERE ("Document Type" = CONST (Payment));
                    column(PaymentAmountCLE; Amount) { }
                }
                /*  dataitem(CustLedgerEntry_DT_Refund; "Cust. Ledger Entry")
                  {
                      DataItemLinkReference = JobTask_DT;
                      DataItemLink = "Job No." = field ("Job No.");//, "Job Task No." = field ("Job Task No.");
                      DataItemTableView = SORTING ("Entry No.") ORDER(Ascending) WHERE ("Document Type" = CONST (Refund));
                      column(RefundAmountCLE; Amount) { }
                  }*/
                trigger
                OnPreDataItem()
                begin
                    CalcFields("Contract (Total Price)", "Contract (Invoiced Price)");
                end;

            }
            trigger
            OnAfterGetRecord()
            begin
                Clear(AmountGLEntryDecG);
                Clear(PaymentAmountCLEDecG);
                Clear(RefundAmountCLEDecG);

                GeneralLedgerSetupRecG.Reset();
                GeneralLedgerSetupRecG.Get();

                GLEntrtRecG.Reset();
                GLEntrtRecG.SetRange("Job No.", "No.");
                GLEntrtRecG.SetFilter("G/L Account No.", GeneralLedgerSetupRecG."WIP Account");
                if GLEntrtRecG.FindSet() then begin
                    repeat
                        AmountGLEntryDecG += GLEntrtRecG.Amount;
                    until GLEntrtRecG.Next() = 0;
                end;

                /*
                CustLedgerEntryRecG.Reset();
                CustLedgerEntryRecG.SetRange("Job No.", "No.");
                CustLedgerEntryRecG.SetRange("Document Type", CustLedgerEntryRecG."Document Type"::Payment);
                if CustLedgerEntryRecG.FindSet() then
                    repeat
                        PaymentAmountCLEDecG += CustLedgerEntryRecG.Amount;
                    until CustLedgerEntryRecG.Next() = 0;

 */
                CustLedgerEntryRecG.Reset();
                CustLedgerEntryRecG.SetRange("Job No.", "No.");
                CustLedgerEntryRecG.SetRange("Document Type", CustLedgerEntryRecG."Document Type"::Refund);
                if CustLedgerEntryRecG.FindSet() then
                    repeat
                        RefundAmountCLEDecG += CustLedgerEntryRecG.Amount;
                    until CustLedgerEntryRecG.Next() = 0;
                //  Message('PAy %1   Ref %2', PaymentAmountCLEDecG, RefundAmountCLEDecG);

            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    labels
    {
        RepprtHeader_LBL = 'Job Report Work In Prpgress';
        Job_LBL = 'Job';
        Date_LBL = 'Date';
        ContractValue_LBL = 'Contract Value';
        Variation_LBL = 'Variation';
        RevisedContractValue_LBL = 'Revised Contract Value';
        ProformaInvoice_LBL = 'Proforma Invoice';
        TaxInvoice_LBL = 'Tax Invoice';
        PaymentReceived_LBL = 'Payment Received';

        WorkInProgress_LBL = 'Work-In Progress';
        PerofPaymentReceived_LBL = '% of Payment Received';
        PerofInvoice_LBL = '% of Invoice';
        PerofWorkInProgress_LBL = '% of Work In Progress';

    }
    var
        GeneralLedgerSetupRecG: Record "General Ledger Setup";
        GLEntrtRecG: Record "G/L Entry";
        CustLedgerEntryRecG: Record "Cust. Ledger Entry";
        AmountGLEntryDecG: Decimal;
        PaymentAmountCLEDecG: Decimal;
        RefundAmountCLEDecG: Decimal;

    trigger
    OnPostReport()
    begin

    end;
}