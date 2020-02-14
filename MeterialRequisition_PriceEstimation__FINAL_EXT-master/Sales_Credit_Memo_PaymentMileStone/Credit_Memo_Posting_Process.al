
codeunit 50566 "CRME Payment MileStone Process"
{


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

        // Copy Sales Credit memo to Posted Sales Credit memo
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN BEGIN
            PaymentMilestone2.Reset();
            PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::"Credit Memo");
            PaymentMilestone2.SetRange("Document No.", SalesHeader."No.");
            IF PaymentMilestone2.FindSet() THEN BEGIN
                REPEAT
                    PaymentMilestone3.Init();
                    PaymentMilestone3."Document Type" := PaymentMilestone3."Document Type"::"Posted Credit Memo";
                    PaymentMilestone3.Validate("Currency Factor", PaymentMilestone2."Currency Factor");
                    PaymentMilestone3."Document No." := SalesCrMemoHeader."No.";
                    PaymentMilestone3."Document Date" := PaymentMilestone2."Document Date";
                    PaymentMilestone3.Amount := PaymentMilestone2.Amount;
                    PaymentMilestone3."Amount(LCY)" := PaymentMilestone2."Amount(LCY)";
                    PaymentMilestone3."Total Value" := PaymentMilestone2."Total Value";
                    PaymentMilestone3."Total Value(LCY)" := PaymentMilestone2."Total Value(LCY)";
                    PaymentMilestone3."Milestone %" := PaymentMilestone2."Milestone %";
                    PaymentMilestone3."Milestone Description" := PaymentMilestone2."Milestone Description";
                    PaymentMilestone3."Payment Terms" := PaymentMilestone2."Payment Terms";
                    PaymentMilestone3."Due Date" := PaymentMilestone2."Due Date";
                    PaymentMilestone3."Line No." := PaymentMilestone2."Line No.";
                    PaymentMilestone3.Validate("Posting Type", PaymentMilestone2."Posting Type");
                    PaymentMilestone3.Insert(true);
                UNTIL PaymentMilestone2.NEXT = 0;
            END;
        end;
        // Stop

        PaymentMilestone2.Reset();
        PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::"Credit Memo");
        PaymentMilestone2.SetRange("Document No.", SalesHeader."No.");
        PaymentMilestone2.SetRange("Posting Type", PaymentMilestone2."Posting Type"::Advance);
        IF PaymentMilestone2.FindSet() THEN BEGIN
            repeat
                CreateSalesJournalAdvReten(PaymentMilestone2, PaymentMilestone2.Amount, SalesHeader, 1, (1 * PaymentMilestone2.Amount), (1 * PaymentMilestone2."Amount(LCY)"), 'Advance', SalesCrMemoHeader."No.");//SalesInvHdrNo);
                CreateSalesJournalAdvReten(PaymentMilestone2, PaymentMilestone2.Amount, SalesHeader, 0, (1 * PaymentMilestone2.Amount), (1 * PaymentMilestone2."Amount(LCY)"), 'Advance', SalesCrMemoHeader."No.");//SalesInvHdrNo);
            until PaymentMilestone2.Next = 0;
        END;
        //Retention Posting
        Clear(PaymentAmountRet);
        PaymentMilestone2.Reset();
        PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::"Credit Memo");
        PaymentMilestone2.SetRange("Document No.", SalesHeader."No.");
        PaymentMilestone2.SetRange("Posting Type", PaymentMilestone2."Posting Type"::Retention);
        IF PaymentMilestone2.FindFirst() THEN BEGIN
            repeat
                CreateSalesJournalAdvReten(PaymentMilestone2, PaymentMilestone2.Amount, SalesHeader, 1, (1 * PaymentMilestone2.Amount), (1 * PaymentMilestone2."Amount(LCY)"), 'Retention', SalesCrMemoHeader."No.");//SalesInvHdrNo);
                CreateSalesJournalAdvReten(PaymentMilestone2, PaymentMilestone2.Amount, SalesHeader, 0, (1 * PaymentMilestone2.Amount), (1 * PaymentMilestone2."Amount(LCY)"), 'Retention', SalesCrMemoHeader."No.");//SalesInvHdrNo);
            until PaymentMilestone2.Next = 0;
        END;
        SalesJournalLine.Reset();
        SalesJournalLine.SetRange("Journal Template Name", 'SALES');
        SalesJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        IF SalesJournalLine.FindSet() THEN begin
            repeat
                GenJnlPostLine1.RunWithCheck(SalesJournalLine);
            until SalesJournalLine.Next = 0;
            SalesJournalLine.DeleteAll();
        End;
    END;

    //end;
    //end;

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
            SalesJournalLine.validate("Credit Amount", (PaymentAmount + (PaymentAmount * 0.05)));
            SalesJournalLine.validate(Amount, Round(-PaymentAmount, 0.01, '='));
            SalesJournalLine.validate("Amount (LCY)", Round(-(PaymentAmountLcy + (PaymentAmountLcy * 0.05)), 0.01, '='));
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
            SalesJournalLine.validate("Debit Amount", (PaymentAmount + (PaymentAmount * 0.05)));
            SalesJournalLine.validate(Amount, Round(PaymentAmount, 0.01, '='));
            SalesJournalLine.validate("Amount (LCY)", Round((PaymentAmountLcy + (PaymentAmountLcy * 0.05)), 0.01, '='));
            SalesJournalLine."Document Date" := PaymentMilestone."Document Date";
            SalesJournalLine.Validate("Payment Terms Code", PaymentMilestone."Payment Terms");
            SalesJournalLine."Due Date" := PaymentMilestone."Due Date";
        end;
        SalesJournalLine.validate("Dimension Set ID", SalesHeader."Dimension Set ID");
        SalesJournalLine.Modify();
    end;
    // Start Creating Credit memo from Job and Copy Payment MileStone Lines
    //
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnAfterCreateSalesInvoiceLines', '', true, true)]
    procedure OnAfterCreateSalesInvoiceLines_LT(SalesHeader: Record "Sales Header"; NewInvoice: Boolean)
    var
        SalesLineRec_L: Record "Sales Line";
        PaymentMilestone2: Record "Payment Milestone";
        PaymentMilestone3: Record "Payment Milestone";

    begin
        // Message('Tye %1  No %2', SalesHeader."Document Type", SalesHeader."No.");
        SalesLineRec_L.Reset();
        SalesLineRec_L.SetRange("Document Type", SalesHeader."Document Type");
        SalesLineRec_L.SetRange("Document No.", SalesHeader."No.");
        SalesLineRec_L.SetFilter("Job No.", '<>%1', '');
        if SalesLineRec_L.FindFirst() then
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN BEGIN
                //  Message('cf Tye %1  No %2', SalesHeader."Document Type", SalesHeader."No.");
                PaymentMilestone2.Reset();
                PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::Job);
                PaymentMilestone2.SetRange("Document No.", SalesLineRec_L."Job No.");
                IF PaymentMilestone2.FindSet() THEN BEGIN
                    // Message('jk Tye %1  No %2  Job %3', SalesHeader."Document Type", SalesHeader."No.", SalesLineRec_L."Job No.");
                    REPEAT
                        //  Message('Des %1', PaymentMilestone2."Milestone Description");
                        PaymentMilestone3.Init();
                        PaymentMilestone3."Document Type" := PaymentMilestone3."Document Type"::"Credit Memo";
                        PaymentMilestone3.Validate("Currency Factor", PaymentMilestone2."Currency Factor");
                        PaymentMilestone3."Document No." := SalesHeader."No.";
                        PaymentMilestone3."Document Date" := PaymentMilestone2."Document Date";
                        PaymentMilestone3.Amount := Abs(PaymentMilestone2.Amount);
                        PaymentMilestone3."Amount(LCY)" := PaymentMilestone2."Amount(LCY)";
                        PaymentMilestone3."Total Value" := PaymentMilestone2."Total Value";
                        PaymentMilestone3."Total Value(LCY)" := PaymentMilestone2."Total Value(LCY)";
                        PaymentMilestone3."Milestone %" := PaymentMilestone2."Milestone %";
                        PaymentMilestone3."Milestone Description" := PaymentMilestone2."Milestone Description";
                        PaymentMilestone3."Payment Terms" := PaymentMilestone2."Payment Terms";
                        PaymentMilestone3."Due Date" := PaymentMilestone2."Due Date";
                        PaymentMilestone3."Line No." := PaymentMilestone2."Line No.";
                        PaymentMilestone3.Validate("Posting Type", PaymentMilestone2."Posting Type");
                        PaymentMilestone3.Insert(true);
                    UNTIL PaymentMilestone2.NEXT = 0;
                END;
            end;
        // Stop

    end;
    // Stop Creating Credit memo from Job and Copy Payment MileStone Lines


}


