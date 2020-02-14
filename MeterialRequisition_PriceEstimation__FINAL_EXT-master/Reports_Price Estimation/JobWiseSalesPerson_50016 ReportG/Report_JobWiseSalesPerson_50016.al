
report 50216 "Jobwise Sales Persons"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    Caption = 'Job wise sales person commission';

    dataset
    {
        dataitem(SalespersonPurchaser_; "Salesperson/Purchaser")
        {
            RequestFilterFields = "Code";
            column(Code; Code) { }
            column(Name; Name) { }
            column(Commission__; "Commission %") { }
            column(SalesPersonAmountDimDecG; SalesPersonAmountDimDecG) { }
            column(SalesAmountDecG; SalesAmountDecG) { }

            dataitem(Job_; Job)
            {
                DataItemLink = "Salesperson Code" = FIELD (code);
                RequestFilterFields = "No.";
                // column(PaymentreceivedDecG; PaymentreceivedDecG) { }
                column(PaymentreceivedDecG; CustLedEntryAmountDecG) { }
                column(No_; "No.") { }

                dataitem(JobTask_; "Job Task")
                {
                    DataItemLink = "Job No." = FIELD ("No.");
                    DataItemTableView = where ("Job Task Type" = const (Posting));
                    column(Contract__Total_Price_; "Contract (Total Price)") { }
                    column(Contract__Invoiced_Price_; "Contract (Invoiced Price)") { }
                    column(Job_Task_No_; "Job Task No.") { }
                    column(Amount; CustLedEntryAmountDecG) { }

                    trigger
                    OnAfterGetRecord()
                    begin

                        // Clear(CustLedEntryAmountDecG);
                        CustLedgerEntryRecG.Reset();
                        CustLedgerEntryRecG.SetRange("Job No.", "Job No.");
                        CustLedgerEntryRecG.SetRange("Job Task No.", "Job Task No.");
                        if CustLedgerEntryRecG.FindSet() then begin
                            repeat
                                CustLedgerEntryRecG.CalcFields(Amount);
                                CustLedEntryAmountDecG += CustLedgerEntryRecG.Amount;
                                //Message('Amount %1', CustLedEntryAmountDecG);
                            until CustLedgerEntryRecG.Next() = 0;
                            //Message('%1', CustLedEntryAmountDecG);
                        end;


                    end;

                }

            }
            trigger
            OnAfterGetRecord()
            var
                SalesRecSetupRecL: Record "Sales & Receivables Setup";
                DimensionRecL: Record Dimension;
            begin

                SalesPersonAmountDimDecG := GetSalesPersonDimAmont(Code);
                SalesRecSetupRecL.Reset();
                SalesRecSetupRecL.Get();
                DimensionRecL.Reset();
                DimensionRecL.SetRange("Sales Person Dimension", true);
                if DimensionRecL.FindFirst() then begin
                    DefaulDimensionRecG.Reset();
                    DefaulDimensionRecG.SetRange("Dimension Code", DimensionRecL.Code);
                    if DefaulDimensionRecG.FindFirst() then begin
                        SalesAmountDecG := GetSalesAmountFromItemBudgetEntry(DimensionRecL.Code, DefaulDimensionRecG."Dimension Value Code", SalesRecSetupRecL."Sales Target Budget");
                    end;
                end;
            end;
        }


    }

    /*
    Start Labrl Area
    */

    labels
    {
        ReportHeaderLBL = 'Sales Person Report';
        SalesTargetLBL = 'Sales Target';
        TotalJobvalueLBL = 'Total Job value';
        CompletedvalueLBL = 'Completed value';
        PaymentreceivedLBL = 'Payment received';
        FullyCollectionAgainstcompletedJobLBL = 'Fully Collection Against completed Job';
        PerofCollectiontoTotalvalueLBL = '% of Collection to Total value';
        EligibleAmountLBL = 'Eligible Amount';
        AmountEligibleforcommissionLBL = 'Amount  Eligible for commission';
        TotalCollectionofCompletedFullyCollectedJobLBL = 'Total Collection of Completed & Fully Collected Job';
        CommissionDueagainstCollectedAmountLBL = 'Commission Due against Collected Amount';
        PaymentmadeLBL = 'Payment Made';
        CommissiontobePaid = 'Commission to be Paid';
        SalesPersonCodeLBL = 'Sales Person Code';
        SalesPersonnAMELBL = 'Name';

    }

    /*
    Stop Labrl Area
    */

    trigger
    OnInitReport()
    begin
        ItemBudgetEntryRecG.Reset();
        JobRecG.Reset();
        JobTaskRecG.Reset();
        CustomerLdgerEntrtRecG.Reset();
    end;

    var
        //Records Varialbe
        ItemBudgetEntryRecG: Record "Item Budget Entry";
        JobRecG: Record Job;
        JobTaskRecG: Record "Job Task";

        CustomerLdgerEntrtRecG: Record "Cust. Ledger Entry";
        PaymentreceivedDecG: Decimal;
        SalesAmountDecG: Decimal;
        // Start For Sales Person Dimension 
        SalesRecSetupRecG: Record "Sales & Receivables Setup";
        DimensionRecG: Record Dimension;
        DefaulDimensionRecG: Record "Default Dimension";
        DimensionSetEntryRecG: Record "Dimension Set Entry";
        GLEntryRecG: Record "G/L Entry";
        SalesPersonAmountDimDecG: Decimal;
        // Start For Sales Person Dimension 
        CustLedgerEntryRecG: Record "Cust. Ledger Entry";
        CustLedEntryAmountDecG: Decimal;

    procedure GetSalesPersonDimAmont(SalesPersonCode: Code[20]): Decimal
    var
        AmoutDecL: Decimal;
    begin
        Clear(AmoutDecL);
        SalesRecSetupRecG.Reset();
        SalesRecSetupRecG.Get();

        DimensionRecG.Reset();
        DimensionRecG.SetRange("Sales Person Dimension", true);
        if DimensionRecG.FindFirst() then begin
            // Message('D %1    SP %2', DimensionRecG.Code, SalesPersonCode);
            DefaulDimensionRecG.Reset();
            DefaulDimensionRecG.SetRange("Dimension Code", DimensionRecG.Code);
            //DefaulDimensionRecG.SetRange("Dimension Value Code", SalesPersonCode);
            DefaulDimensionRecG.SetRange("No.", SalesPersonCode);
            if DefaulDimensionRecG.FindFirst() then begin
                // Message('Sales PErson Code %1', SalesPersonCode);
                DimensionSetEntryRecG.Reset();
                DimensionSetEntryRecG.SetRange("Dimension Code", DefaulDimensionRecG."Dimension Code");
                DimensionSetEntryRecG.SetRange("Dimension Value Code", DefaulDimensionRecG."Dimension Value Code");
                if DimensionSetEntryRecG.FindSet() then begin
                    repeat
                        GLEntryRecG.Reset();
                        GLEntryRecG.SetRange("Dimension Set ID", DimensionSetEntryRecG."Dimension Set ID");
                        GLEntryRecG.SetFilter("G/L Account No.", SalesRecSetupRecG."Sales Commission A/c No.");
                        if GLEntryRecG.FindSet() then begin
                            repeat
                                AmoutDecL += GLEntryRecG.Amount;
                            until GLEntryRecG.Next() = 0;
                        end;
                    until DimensionSetEntryRecG.Next() = 0;
                end;

            end;
        end;
        exit(AmoutDecL);
    end;

    procedure GetSalesAmountFromItemBudgetEntry(DimCode: Code[20]; SalespersonCode: code[20]; BudgetName: code[20]): Decimal
    var
        ItemBudgetEntryRec1: Record "Item Budget Entry";
        AmountDecL: Decimal;
    begin
        ItemBudgetEntryRec1.Reset();
        ItemBudgetEntryRec1.SetRange("Budget Name", BudgetName);
        if ItemBudgetEntryRec1.FindFirst() then begin
            //repeat
            if ItemBudgetEntryRec1."Budget Dimension 1 Code" <> '' then
                AmountDecL := ItemBudgetEntryDimension(SalespersonCode, BudgetName, 1)
            else
                if ItemBudgetEntryRec1."Budget Dimension 2 Code" <> '' then
                    AmountDecL := ItemBudgetEntryDimension(SalespersonCode, BudgetName, 2)
                else
                    if ItemBudgetEntryRec1."Budget Dimension 2 Code" <> '' then
                        AmountDecL := ItemBudgetEntryDimension(SalespersonCode, BudgetName, 3);
            //until ItemBudgetEntryRec1.Next() = 0;
        end;

        exit(AmountDecL);

    end;

    procedure ItemBudgetEntryDimension(SalespersonCode: code[20]; BudgetName: code[20]; DinID: Integer): Decimal
    var
        SalesAmountDecL: Decimal;
    begin
        Clear(SalesAmountDecL);
        ItemBudgetEntryRecG.Reset();
        if DinID = 1 then
            ItemBudgetEntryRecG.SetRange("Budget Dimension 1 Code", SalespersonCode)
        else
            if DinID = 2 then
                ItemBudgetEntryRecG.SetRange("Budget Dimension 2 Code", SalespersonCode)
            else
                ItemBudgetEntryRecG.SetRange("Budget Dimension 3 Code", SalespersonCode);

        ItemBudgetEntryRecG.SetRange("Budget Name", BudgetName);
        if ItemBudgetEntryRecG.FindSet() then begin
            repeat
                SalesAmountDecL += ItemBudgetEntryRecG."Sales Amount";
            until ItemBudgetEntryRecG.Next() = 0;
        end;
        exit(SalesAmountDecL);
    end;
}
