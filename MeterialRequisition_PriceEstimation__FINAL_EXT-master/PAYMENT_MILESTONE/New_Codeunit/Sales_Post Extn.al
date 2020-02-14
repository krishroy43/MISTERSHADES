codeunit 50014 "Sales-Post Extn."
{
    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]

    // procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header";
    //                                     var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    //                                     SalesShptHdrNo: Code[20];
    //                                     RetRcpHdrNo: Code[20];
    //                                     SalesInvHdrNo: Code[20];
    //                                     SalesCrMemoHdrNo: Code[20])
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeFinalizePosting', '', true, true)]
    procedure OnRunOnBeforeFinalizePosting(
        VAR SalesHeader: Record "Sales Header";
        VAR SalesShipmentHeader: Record "Sales Shipment Header";
        VAR SalesInvoiceHeader: Record "Sales Invoice Header";
        VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var ReturnReceiptHeader: Record "Return Receipt Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CommitIsSuppressed: Boolean)
    var
        SalesHeader2: Record "Sales Header";
        PaymentMilestone2: Record "Payment Milestone";
        PaymentMilestone3: Record "Payment Milestone";
        PaymentMilestone4: Record "Payment Milestone";

        PaymentAmountAdv: Decimal;
        PaymentAmountRet: Decimal;
        PaymentAmountAdvLcy: Decimal;
        PaymentAmountRetLcy: Decimal;
        SalesJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine1: Codeunit "Gen. Jnl.-Post Line";
    begin
        //Message('call');
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN

            PaymentMilestone2.Reset();
            PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::Invoice);
            PaymentMilestone2.SetRange("Document No.", SalesHeader."No.");
            IF PaymentMilestone2.FindSet() THEN BEGIN
                REPEAT
                    //Message('inside sales header code invoice PM');
                    PaymentMilestone3.Init();
                    PaymentMilestone3."Document Type" := PaymentMilestone3."Document Type"::"Posted Invoice";
                    PaymentMilestone3.Validate("Currency Factor", PaymentMilestone2."Currency Factor");
                    // // // PaymentMilestone3."Document No." := SalesInvHdrNo;
                    PaymentMilestone3."Document No." := SalesInvoiceHeader."No.";
                    PaymentMilestone3."Document Date" := PaymentMilestone2."Document Date";
                    // Start Avinash Code Modification
                    PaymentMilestone3.Amount := PaymentMilestone2.Amount;
                    PaymentMilestone3."Amount(LCY)" := PaymentMilestone2."Amount(LCY)";
                    PaymentMilestone3."Total Value" := PaymentMilestone2."Total Value";
                    PaymentMilestone3."Total Value(LCY)" := PaymentMilestone2."Total Value(LCY)";
                    // Stop Avinash Code Modification
                    PaymentMilestone3."Milestone %" := PaymentMilestone2."Milestone %";
                    PaymentMilestone3."Milestone Description" := PaymentMilestone2."Milestone Description";
                    PaymentMilestone3."Payment Terms" := PaymentMilestone2."Payment Terms";
                    PaymentMilestone3."Due Date" := PaymentMilestone2."Due Date";
                    PaymentMilestone3."Line No." := PaymentMilestone2."Line No.";
                    PaymentMilestone3.Validate("Posting Type", PaymentMilestone2."Posting Type");
                    // Start 02-09-2019
                    // Modify Code As discussed with Ankur and Jagadeesh
                    PaymentMilestone3.Insert(true);
                // // // // if Not PaymentMilestone3.Insert(true) then
                // // // //     Error('While posting Payment Milestone there is some issue Try Again !!');
                // Stop 0209-2019
                UNTIL PaymentMilestone2.NEXT = 0;
            END;

            //Advance Posting
            Clear(PaymentAmountAdv);
            PaymentMilestone2.Reset();
            PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::Invoice);
            PaymentMilestone2.SetRange("Document No.", SalesHeader."No.");
            PaymentMilestone2.SetRange("Posting Type", PaymentMilestone2."Posting Type"::Advance);
            IF PaymentMilestone2.FindFirst() THEN BEGIN
                //Message('Invoice Advance');
                repeat
                    CreateSalesJournalAdvReten(PaymentMilestone2, PaymentMilestone2.Amount, SalesHeader, 1, PaymentMilestone2.Amount, PaymentMilestone2."Amount(LCY)", 'Advance', SalesInvoiceHeader."No.");//SalesInvHdrNo);
                    CreateSalesJournalAdvReten(PaymentMilestone2, PaymentMilestone2.Amount, SalesHeader, 0, PaymentMilestone2.Amount, PaymentMilestone2."Amount(LCY)", 'Advance', SalesInvoiceHeader."No.");//SalesInvHdrNo);
                until PaymentMilestone2.Next = 0;
            END;
            //Retention Posting
            Clear(PaymentAmountRet);
            PaymentMilestone2.Reset();
            PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::Invoice);
            PaymentMilestone2.SetRange("Document No.", SalesHeader."No.");
            PaymentMilestone2.SetRange("Posting Type", PaymentMilestone2."Posting Type"::Retention);
            IF PaymentMilestone2.FindFirst() THEN BEGIN
                //Message('Invoice Retention');
                repeat
                    CreateSalesJournalAdvReten(PaymentMilestone2, PaymentMilestone2.Amount, SalesHeader, 1, PaymentMilestone2.Amount, PaymentMilestone2."Amount(LCY)", 'Retention', SalesInvoiceHeader."No.");//SalesInvHdrNo);
                    CreateSalesJournalAdvReten(PaymentMilestone2, PaymentMilestone2.Amount, SalesHeader, 0, PaymentMilestone2.Amount, PaymentMilestone2."Amount(LCY)", 'Retention', SalesInvoiceHeader."No.");//SalesInvHdrNo);
                until PaymentMilestone2.Next = 0;
            END;
            SalesJournalLine.Reset();
            SalesJournalLine.SetRange("Journal Template Name", 'SALES');
            SalesJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
            IF SalesJournalLine.FindSet() THEN begin
                //Message('here');
                repeat
                    GenJnlPostLine1.RunWithCheck(SalesJournalLine);
                until SalesJournalLine.Next = 0;
                ///////Commit();
                SalesJournalLine.DeleteAll();
            End;
        END;
    end;

    procedure CreateSalesJournal(var PaymentMilestone: Record "Payment Milestone";
                                     PaymentMilestoneAmount: Decimal;
                                     PaymentMilestoneAmountLCY: Decimal;
                                     SalesHeader: Record "Sales Header");
    var
        SalesJournalLine: Record "Gen. Journal Line";
        SalesJournalLine2: Record "Gen. Journal Line";
        Cust: Record Customer;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        JobRec: Record Job;
        CustPostGrpRec: Record "Customer Posting Group";

    //
    begin
        SalesJournalLine2.Reset();
        SalesJournalLine2.SetRange("Journal Template Name", 'SALES');
        SalesJournalLine2.SetRange("Journal Batch Name", 'DEFAULT');
        SalesJournalLine2.SetRange("Document No.", PaymentMilestone."Document No.");
        SalesJournalLine2.DeleteAll();

        Cust.Get(SalesHeader."Sell-to Customer No.");

        SalesJournalLine2.Reset();
        SalesJournalLine2.SetRange("Journal Template Name", 'SALES');
        SalesJournalLine2.SetRange("Journal Batch Name", 'DEFAULT');
        IF SalesJournalLine2.FindLast() THEN;
        SalesJournalLine.Init;
        SalesJournalLine.Validate("Journal Template Name", 'SALES');
        SalesJournalLine.Validate("Journal Batch Name", 'DEFAULT');
        SalesJournalLine.Validate("Line No.", SalesJournalLine2."Line No." + 10000);
        // Start Currency Code
        SalesJournalLine.Validate("Currency Code", SalesHeader."Currency Code");
        SalesJournalLine.Validate("Currency Factor", SalesHeader."Currency Factor");
        // Stop Currecny Code
        SalesJournalLine.Insert(TRUE);
        SalesJournalLine.validate("Posting Date", SalesHeader."Posting Date");
        SalesJournalLine.Validate("Document No.", SalesHeader."No.");
        SalesJournalLine.Validate("Posting Type", SalesJournalLine."Posting Type"::Advance);
        SalesJournalLine.Validate("Account Type", SalesJournalLine."Account Type"::"G/L Account");

        CustPostGrpRec.Reset();
        CustPostGrpRec.SetRange(Code, SalesHeader."Customer Posting Group");
        if CustPostGrpRec.FindFirst then begin
            CustPostGrpRec.TestField("Advance A/C");
            SalesJournalLine.Validate("Account No.", Cust."Advance A/c");
        End;
        SalesJournalLine.Validate("Currency Code", SalesHeader."Currency Code");
        SalesJournalLine.Description := 'Advance';
        SalesJournalLine.Validate(Amount, PaymentMilestoneAmount);
        SalesJournalLine.Validate(Amount, Round(PaymentMilestoneAmountLCY, 0.01, '='));
        SalesJournalLine.Validate("Bal. Account Type", SalesJournalLine."Bal. Account Type"::Customer);
        SalesJournalLine.Validate("Bal. Account No.", Cust."No.");
        JobRec.Reset();
        If JobRec.Get(SalesHeader."No.") then
            SalesJournalLine.Validate("Job No.", SalesHeader."No.")
        Else
            Error('Record with No. %1 not found in Job Table', SalesHeader."No.");

        SalesJournalLine.Modify();
        ///////Commit();
    end;

    procedure CreateSalesJournalAdvReten(var PaymentMilestone: Record "Payment Milestone";
                                     PaymentMilestoneAmount: Decimal;
                                     SalesHeader: Record "Sales Header";
                                     PostingAccount: Integer;
                                     PaymentAmount: Decimal;
                                     PaymentAmountLcy: Decimal;
                                     TypeCode: Code[10];
                                     SalesInvHdrNo: code[20]);
    var
        SalesJournalLine: Record "Gen. Journal Line";
        SalesJournalLine2: Record "Gen. Journal Line";
        Cust: Record Customer;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CustPostGrpRec: Record "Customer Posting Group";
        SalesLineRecL: Record "Sales Line";
        JobRec: Record Job;
    begin
        /// Message('inside fun CC %1 CF %2', SalesHeader."Currency Code", SalesHeader."Currency Factor");
        Cust.Get(SalesHeader."Sell-to Customer No.");
        SalesJournalLine2.Reset();
        SalesJournalLine2.SetRange("Journal Template Name", 'SALES');
        SalesJournalLine2.SetRange("Journal Batch Name", 'DEFAULT');
        IF SalesJournalLine2.FindLast() THEN;

        SalesJournalLine.Init;
        SalesJournalLine.Validate("Journal Template Name", 'SALES');
        SalesJournalLine.Validate("Journal Batch Name", 'DEFAULT');
        SalesJournalLine.Validate("Line No.", SalesJournalLine2."Line No." + 10000);
        SalesJournalLine.Validate("Document No.", SalesInvHdrNo);

        SalesJournalLine.Validate("Document Type", SalesJournalLine."Document Type"::" ");
        SalesJournalLine.validate("Posting Date", SalesHeader."Posting Date");
        SalesJournalLine.Insert(TRUE);


        if PostingAccount = 1 then begin
            SalesJournalLine.Validate("Account Type", SalesJournalLine."Account Type"::"G/L Account");
            CustPostGrpRec.Reset();
            CustPostGrpRec.SetRange(Code, SalesHeader."Customer Posting Group");
            if CustPostGrpRec.FindFirst then begin
                if TypeCode = 'ADVANCE' then begin
                    SalesJournalLine."Posting Type" := SalesJournalLine."Posting Type"::Advance;
                    SalesJournalLine.validate("Account No.", CustPostGrpRec."Advance A/C");
                    SalesJournalLine.Description := 'Advance';
                end else
                    if TypeCode = 'RETENTION' then begin
                        SalesJournalLine."Posting Type" := SalesJournalLine."Posting Type"::Retention;
                        SalesJournalLine.validate("Account No.", CustPostGrpRec."Retention A/C");
                        SalesJournalLine.Description := 'Retention';
                    End;
            end;
            SalesJournalLine.validate("Currency Code", SalesHeader."Currency Code");
            SalesJournalLine.validate("Currency Factor", SalesHeader."Currency Factor");

            SalesJournalLine."Debit Amount" := PaymentAmount + (PaymentAmount * 0.05);
            SalesJournalLine.validate(Amount, Round(PaymentAmount, 0.01, '='));
            SalesJournalLine.validate("Amount (LCY)", Round(PaymentAmountLcy + (PaymentAmountLcy * 0.05), 0.01, '='));

        end else begin
            if TypeCode = 'ADVANCE' then
                SalesJournalLine."Posting Type" := SalesJournalLine."Posting Type"::Advance;
            if TypeCode = 'RETENTION' then
                SalesJournalLine."Posting Type" := SalesJournalLine."Posting Type"::Retention;

            SalesJournalLine.validate("Currency Code", SalesHeader."Currency Code");
            SalesJournalLine.validate("Currency Factor", SalesHeader."Currency Factor");

            SalesJournalLine."Account Type" := SalesJournalLine."Account Type"::Customer;
            SalesJournalLine.validate("Account No.", Cust."No.");
            SalesJournalLine.Description := Cust.Name;
            SalesJournalLine.validate("Credit Amount", (PaymentAmount + (PaymentAmount * 0.05)));
            SalesJournalLine.validate(Amount, Round(-PaymentAmount, 0.01, '='));
            SalesJournalLine.validate("Amount (LCY)", Round(-(PaymentAmountLcy + (PaymentAmountLcy * 0.05)), 0.01, '='));

            // Start 24-05-2019
            SalesJournalLine."Document Date" := PaymentMilestone."Document Date";
            SalesJournalLine.Validate("Payment Terms Code", PaymentMilestone."Payment Terms");
            SalesJournalLine."Due Date" := PaymentMilestone."Due Date";
            // Stop 24-05-2019
        end;
        SalesJournalLine.validate("Dimension Set ID", SalesHeader."Dimension Set ID");
        SalesJournalLine.Modify();
        ///////Commit();
    end;
    // Start Avinash
    [EventSubscriber(ObjectType::Codeunit, 81, 'OnAfterPost', '', true, true)]
    local procedure OnAfterPost_LT(var SalesHeader: Record "Sales Header");
    begin
        SalesInvHeaderRecG.RESET;
        SalesInvHeaderRecG.SETRANGE("Pre-Assigned No.", SalesHeader."No.");
        IF SalesInvHeaderRecG.FINDFIRST THEN begin

            CustLedgerEntryRecG.Reset();
            CustLedgerEntryRecG.SetRange("Document No.", SalesInvHeaderRecG."No.");
            if CustLedgerEntryRecG.FindFirst() then begin

                SalesInvLineRecG.Reset();
                SalesInvLineRecG.SetRange("Document No.", SalesInvHeaderRecG."No.");
                if SalesInvLineRecG.FindFirst() then begin
                    CustLedgerEntryRecG.ModifyAll("Job No.", SalesInvLineRecG."Job No.");
                    CustLedgerEntryRecG.ModifyAll("Job Task No.", SalesInvLineRecG."Job Task No.");
                    //CustLedgerEntryRecG.Modify();
                    Commit();
                end;
            end;

        end;
    end;

    var
        SalesInvHeaderRecG: Record "Sales Invoice Header";
        CustLedgerEntryRecG: Record "Cust. Ledger Entry";
        CustLedgerEntryRec2G: Record "Cust. Ledger Entry";
        SalesInvLineRecG: Record "Sales Invoice Line";
    // Stop Avinash

}