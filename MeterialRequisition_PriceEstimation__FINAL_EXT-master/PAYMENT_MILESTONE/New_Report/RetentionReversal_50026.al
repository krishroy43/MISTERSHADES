report 50026 "Retention Reversal"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;


    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = where ("Posting Type" = const (Retention));
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                // Message('%1   C %2', JobNum, CustNum);
                SetRange("Job No.", JobNum);
                SetRange("Customer No.", CustNum);
                SetRange("Due Date", DueDate);
                // SetRange("Posting Type", "Cust. Ledger Entry"."Posting Type"::Retention);
                SetRange("Retention Reversal", false);

                // Start Avinash
                SalesRecSetupRecG.Reset();
                SalesRecSetupRecG.Get();
                RetentionReversalNoG := NoSeriesMngmntCUG.GetNextNo(SalesRecSetupRecG."Retention Reversal No.", Today(), true);
                Int1 := 0
                // Stop Avinash

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin
                "Cust. Ledger Entry".CalcFields(Amount, "Amount (LCY)");
                Int1 += 1;
                //Message('hh');
                // Start 02-09-2019 
                // Code commented due to some changes in amount LCY 
                CreateSalesJournal("Cust. Ledger Entry".Amount, 'Debit');
                CreateSalesJournal("Cust. Ledger Entry".Amount, 'Credit');
                // // // CreateSalesJournal("Cust. Ledger Entry".Amount, "Cust. Ledger Entry"."Amount (LCY)", 'Debit');
                // // // CreateSalesJournal("Cust. Ledger Entry".Amount, "Cust. Ledger Entry"."Amount (LCY)", 'Credit');
                // Stop 02-09-2019
                "Cust. Ledger Entry"."Retention Reversal" := true;
                "Cust. Ledger Entry".Modify();


                // Debit Line

                //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Line", SalesJournalLine);

            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                SalesJournalLine2.Reset();
                SalesJournalLine2.SetRange("Journal Template Name", 'SALES');
                SalesJournalLine2.SetRange("Journal Batch Name", 'DEFAULT');
                if SalesJournalLine2.FindFirst() then
                    repeat
                        GenJnlPostLine.RunWithCheck(SalesJournalLine2);
                    until SalesJournalLine2.next = 0;
                //Message('%1', Int1);
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
                    field("Due Date"; DueDate)
                    {
                        ApplicationArea = All;

                    }
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

    procedure SetValues(JobNo: Code[20]; CustNo: Code[20])
    var
        myInt: Integer;
    begin
        JobNum := JobNo;
        CustNum := CustNo;

    end;

    procedure CreateSalesJournal(Amount: Decimal; AccType: Code[10])
    var

    Begin
        // Parameter AmountLCY: Decimal;
        //  Message('%1', Amount);
        SalesJournalLine.Init;
        SalesJournalLine3.Reset();
        SalesJournalLine3.SetRange("Journal Template Name", 'SALES');
        SalesJournalLine3.SetRange("Journal Batch Name", 'DEFAULT');
        IF SalesJournalLine3.FindLast() THEN
            SalesJournalLine.Validate("Line No.", SalesJournalLine3."Line No." + 10000)
        else
            SalesJournalLine.Validate("Line No.", 10000);

        SalesJournalLine.Validate("Journal Template Name", 'SALES');
        SalesJournalLine.Validate("Journal Batch Name", 'DEFAULT');

        SalesJournalLine.Insert(TRUE);

        //SalesJournalLine.validate("Posting Date", "Cust. Ledger Entry"."Posting Date");
        SalesJournalLine.validate("Posting Date", WorkDate());
        // Start Avinash
        //SalesJournalLine.Validate("Document No.", "Cust. Ledger Entry"."Document No.");
        SalesJournalLine.Validate("Document No.", RetentionReversalNoG);
        // Stop Avinash
        SalesJournalLine.Validate("Posting Type", SalesJournalLine."Posting Type"::Retention);

        If AccType = 'CREDIT' then begin
            SalesJournalLine.Validate("Account Type", SalesJournalLine."Account Type"::"G/L Account");
            //Cust.TestField("Advance A/c");
            CustPostGrpRec.Reset();
            CustPostGrpRec.SetRange(Code, "Cust. Ledger Entry"."Customer Posting Group");
            if CustPostGrpRec.FindFirst() then
                SalesJournalLine.Validate("Account No.", CustPostGrpRec."Retention A/C");
            SalesJournalLine.Description := 'Retention';
            SalesJournalLine.Validate("Credit Amount", abs(Amount));
            // Start 02-09-2019 Amount LCY
            ////-------SalesJournalLine.Validate("Amount (LCY)", abs(AmountLCY));
            // Stop 02-09-2019 Amount LCY
        end else
            if AccType = 'DEBIT' then begin
                SalesJournalLine.Validate("Account Type", SalesJournalLine."Account Type"::Customer);
                //Cust.TestField("Advance A/c");
                SalesJournalLine.Validate("Account No.", "Cust. Ledger Entry"."Customer No.");
                SalesJournalLine.Description := "Cust. Ledger Entry"."Customer Name";
                //SalesJournalLine.Validate("Debit Amount", "Cust. Ledger Entry".Amount);
                SalesJournalLine.Validate("Debit Amount", ABS(Amount));
                // Start 02-09-2019 Amount LCY
                ///////------SalesJournalLine.Validate("Amount (LCY)", abs(AmountLCY));
                // Stop 02-09-2019 Amount LCY
            End;
        //SalesJournalLine.Validate("Job No.", "Cust. Ledger Entry"."Job No.");
        SalesJournalLine.Validate("Currency Code", "Cust. Ledger Entry"."Currency Code");
        SalesJournalLine.Validate(jobno, "Cust. Ledger Entry"."Job No.");
        SalesJournalLine.Validate("Retention Reversal", true);
        SalesJournalLine.Modify();
    End;

    trigger
    OnPostReport()
    begin
        Message('Retention Reversal %1 Posted successfully', RetentionReversalNoG);
    end;

    var
        DueDate: Date;
        PostindDate: Date;
        JobNum: Code[20];
        CustNum: code[20];
        SalesJournalLine2: Record "Gen. Journal Line";
        SalesJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CustPostGrpRec: Record "Customer Posting Group";
        SalesJournalLine3: Record "Gen. Journal Line";
        SalesJournalLine4: Record "Gen. Journal Line";
        SalesRecSetupRecG: Record "Sales & Receivables Setup";
        NoSeriesMngmntCUG: Codeunit NoSeriesManagement;
        RetentionReversalNoG: Code[20];
        Int1: Integer;

}