
codeunit 50015 GenJnlPost
{
    [EventSubscriber(ObjectType::Table, 21, 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    procedure OnAfterCopyCustLedgerEntryFromGenJnlLine_LT(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        JobRec: Record Job;
    begin

        If GenJournalLine."Posting Type" = GenJournalLine."Posting Type"::Advance then begin
            CustLedgerEntry."Posting Type" := CustLedgerEntry."Posting Type"::Advance;
            JobRec.Reset();
            JobRec.SetRange("No.", GenJournalLine."Job No.");
            if JobRec.FindFirst then begin
                JobRec."Advance Received" := true;
                JobRec.Modify();
                Commit();
            end;

        end;
        If GenJournalLine."Posting Type" = GenJournalLine."Posting Type"::Retention then
            CustLedgerEntry."Posting Type" := CustLedgerEntry."Posting Type"::Retention;

        CustLedgerEntry."Job No." := GenJournalLine.JobNo;
        CustLedgerEntry."Job Task No." := GenJournalLine.JobTaskNo;
        CustLedgerEntry."Retention Reversal" := GenJournalLine."Retention Reversal";
        //CustLedgerEntry.Validate("Due Date", GenJournalLine."Due Date");

    end;

}
