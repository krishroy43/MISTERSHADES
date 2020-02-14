pageextension 50074 "Ext. Payment Journal" extends "Payment Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Job No."; "Job No.")
            {
                Visible = OldJobTaskNoBoolG;
                ApplicationArea = All;
            }
            field("Job Task No."; "Job Task No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Posting Type"; "Posting Type")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field(JobNo; JobNo)
            {
                Caption = 'Job No._';
                Visible = NewJobTaskNoBoolG;
                ApplicationArea = All;
            }
            field(JobTaskNo; JobTaskNo)
            {
                Caption = 'Job Task No._';
                Visible = false;
                ApplicationArea = All;
            }
            // Start 09-07-2019
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
            // Start 09-07-2019
        }

        modify("Account Type")
        {
            ApplicationArea = All;
            trigger
            OnAfterValidate()
            begin
                // Start 
                IF ("Account Type" = "Account Type"::Customer) OR ("Account Type" = "Account Type"::Vendor) THEN BEGIN
                    OldJobTaskNoBoolG := FALSE;
                    NewJobTaskNoBoolG := TRUE;
                    CurrPage.UPDATE;
                END ELSE BEGIN
                    OldJobTaskNoBoolG := TRUE;
                    NewJobTaskNoBoolG := FALSE;
                    CurrPage.UPDATE;
                END;
                // Stop 
            end;
        }


    }
    actions
    {
        //modify(Pri)
        //modify(PrintCheck)
        //{
        //    Visible = false;
        //}
        addbefore("Electronic Payments")
        {
            action("MSME Print Check")
            {
                ApplicationArea = All;
                Image = Report;
                trigger
                OnAction()
                begin
                    PrintCheckReportFromBankAccount();
                end;
            }
        }
        addlast("P&osting")
        {
            action("Emirates NBD")
            {
                ApplicationArea = All;
                Image = Report;
                Visible = false;
                //RunObject = report "Check_Report";
                Caption = 'Emirates NBD Cheque';
                trigger
                OnAction()
                var
                    PaymentJournalRecL: Record "Gen. Journal Line";
                begin
                    CurrPage.SetSelectionFilter(PaymentJournalRecL);
                    if PaymentJournalRecL.FindFirst() then
                        report.RunModal(50104, true, true, PaymentJournalRecL);
                end;

            }
            action("ADCB Report")
            {
                ApplicationArea = All;
                Image = Report;
                Visible = false;
                // RunObject = report "CheckPrint_Report";
                Caption = 'ADCB Cheque';
                trigger
                OnAction()
                var
                    PaymentJournalRecL: Record "Gen. Journal Line";
                begin
                    CurrPage.SetSelectionFilter(PaymentJournalRecL);
                    if PaymentJournalRecL.FindFirst() then
                        report.RunModal(50105, true, true, PaymentJournalRecL);
                end;
            }
        }


    }
    var
        OldJobTaskNoBoolG: Boolean;
        NewJobTaskNoBoolG: Boolean;

    trigger
    OnAfterGetRecord()
    begin
        // Start 
        IF ("Account Type" = "Account Type"::Customer) OR ("Account Type" = "Account Type"::Vendor) THEN BEGIN
            OldJobTaskNoBoolG := FALSE;
            NewJobTaskNoBoolG := TRUE;
            //CurrPage.UPDATE;
        END
        ELSE BEGIN
            OldJobTaskNoBoolG := TRUE;
            NewJobTaskNoBoolG := FALSE;
            //CurrPage.UPDATE;
        END;

        // Stop 
    end;

    procedure PrintCheckReportFromBankAccount()
    var
        BankAccountRecL: Record "Bank Account";
        GenJrnlLineRecL: Record "Gen. Journal Line";
        GenJrnlLineRec2L: Record "Gen. Journal Line";
    begin
        if ("Account Type" = "Account Type"::"Bank Account") OR ("Bal. Account Type" = "Bal. Account Type"::"Bank Account") then begin
            if not BankAccountRecL.GET("Account No.") then
                BankAccountRecL.GET("Bal. Account No.");
            CurrPage.SetSelectionFilter(GenJrnlLineRecL);
            if GenJrnlLineRecL.FindFirst() then begin
                GenJrnlLineRec2L.Reset();
                GenJrnlLineRec2L.SetRange("Journal Template Name", GenJrnlLineRecL."Journal Template Name");
                GenJrnlLineRec2L.SetRange("Journal Batch Name", GenJrnlLineRecL."Journal Batch Name");
                //GenJrnlLineRec2L.SetRange("Posting Date", GenJrnlLineRecL."Posting Date");
                if GenJrnlLineRec2L.FindFirst() then
                    Report.RunModal(BankAccountRecL."Check Report ID", true, true, GenJrnlLineRec2L);
            end;
            // "Check Printed" := false;
            ///Modify();
        end
    end;

}


/*
============================================================================================================
========================================== GENERAL JOURNAL PAGE=============================================
============================================================================================================
*/

pageextension 50209 "Ext. General Journal" extends "General Journal"
{
    layout
    {
        addafter(Description)
        {
            field(JobNo; JobNo)
            {
                Caption = 'Job No._';
                Visible = false;
                ApplicationArea = All;
            }
            field(JobTaskNo; JobTaskNo)
            {
                Caption = 'Job Task No._';
                Visible = false;
                ApplicationArea = All;
            }
            // Start 09-07-2019
            field(Narration; Narration)
            {
                ApplicationArea = All;
            }
            // Start 09-07-2019
        }
    }
}

