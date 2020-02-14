codeunit 50011 "Sales Order Process"
{
    /*
        Start Purchase Header to direct in Vendor ledger entry
        due to standard code blocking flow Job No. and Job Task No. that y we write code like that
        
    */

    [EventSubscriber(ObjectType::Codeunit, 91, 'OnAfterPost', '', true, true)]
    local procedure OnAfterPost_LT(var PurchaseHeader: Record "Purchase Header");
    begin
        PurchaseInvHeaderRecL.RESET;
        PurchaseInvHeaderRecL.SETRANGE("Order No.", PurchaseHeader."No.");
        IF PurchaseInvHeaderRecL.FINDFIRST THEN begin
            VendorLedgerEntryG.Reset();
            VendorLedgerEntryG.SetRange("Document No.", PurchaseInvHeaderRecL."No.");
            if VendorLedgerEntryG.FindFirst() then begin
                VendorLedgerEntryG."Job No." := PurchaseInvHeaderRecL."Job No.";
                VendorLedgerEntryG."Job Task No." := PurchaseInvHeaderRecL."Job Task No.";
                VendorLedgerEntryG.Modify();
            end;
            // Start Job No. in General Ledger Entry
            GLEntryRecG.Reset();
            GLEntryRecG.SetRange("Document No.", PurchaseInvHeaderRecL."No.");
            if GLEntryRecG.FindSet() then begin
                GLEntryRecG.ModifyAll("Job No.", PurchaseInvHeaderRecL."Job No.");
            end;
            // Stop Job No. in General Ledger Entry
        end;
    end;


    /*
    Start 
    While posting Gen. Journal Line Job No. and Job Task No. update in Vendor Ledger Entry and 
    Customer LEdger Entry with A/C type Cusotmer/ Vendor. 
    */
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitCustLedgEntry', '', true, true)]
    local procedure OnAfterInitCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        CustLedgerEntry."Job No." := GenJournalLine.JobNo;
        CustLedgerEntry."Job Task No." := GenJournalLine.JobTaskNo;
        // Srtart 23-07-2019
        if (GenJournalLine."Posting Type" = GenJournalLine."Posting Type"::Advance) and (GenJournalLine.JobNo <> '') then
            UpdateJobsAdvanceRec_LT(GenJournalLine.JobNo);
        // Stop 23-07-2019
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitVendLedgEntry', '', true, true)]
    local procedure OnAfterInitVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        //  Message('JB NO %1  JB TASK  %2', GenJournalLine.JobNo, GenJournalLine.JobTaskNo);

        VendorLedgerEntry."Job No." := GenJournalLine.JobNo;
        VendorLedgerEntry."Job Task No." := GenJournalLine.JobTaskNo;
    end;

    [EventSubscriber(ObjectType::Table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line");
    begin
        //IF (GenJournalLine."Account Type" =GenJournalLine."Account Type"::Customer) OR  (GenJournalLine."Account Type" =GenJournalLine."Account Type"::Vendor) THEN BEGIN
        IF (GenJournalLine.JobNo <> '') THEN ///OR (GenJournalLine.JobTaskNo <> '')
            GLEntry."Job No." := GenJournalLine.JobNo;

        // Start 09-07-2019
        GLEntry.Narration := GenJournalLine.Narration;
        // Stop 09-07-2019
    end;
    /*
    Stop
    While posting Gen. Journal Line Job No. and Job Task No. update in Vendor Ledger Entry and 
    Customer LEdger Entry with A/C type Cusotmer/ Vendor. 
    */


    var

        PurchHeaderRecL: Record "Purchase Header";
        PurchaseInvHeaderRecL: Record "Purch. Inv. Header";
        VendorLedgerEntryG: Record "Vendor Ledger Entry";
        GLEntryRecG: Record "G/L Entry";

        // Start 23-07-2019
    procedure UpdateJobsAdvanceRec_LT(JobNo: Code[20])
    var
        JobRecL: Record Job;
    begin
        JobRecL.Reset();
        JobRecL.Get(JobNo);
        JobRecL."Advance Received" := true;
        //JobRecL."Advance Amount" := 0;
        JobRecL.Modify();
    end;
    // Stop 23-07-2019
}




