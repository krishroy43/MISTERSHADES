report 50014 "Project purchase Payable"
{
    DefaultLayout = RDLC;
    //RDLCLayout = 'VLE_Rep.rdl';
    Caption = 'Project purchase Payable';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    // version LT


    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date", "Job No.", "Vendor No.";
            column(Document_No_; "Document No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Job_No_; "Job No.") { }
            column(VendName; VendRec.Name) { }
            column(Amount_vle; Amount) { }
            column(Amount_LCY; "Amount (LCY)") { }
            column(LCYAmtReq; LCYAmtReq) { }
            column(Due_Date; "Due Date") { }
            column(JobNo; "Job No.") { }
            column(jobDec; JobRec.Description) { }
            column(B_TotPrice; B_TotPrice) { }
            column(Amt_CLE; Amt_CLE) { }
            column(Bill_Per; Bill_Per) { }
            column(PrintAll; PrintAll) { }
            trigger OnPreDataItem();
            begin
                Clear(B_TotPrice);
                Clear(Amt_CLE);
                Clear(Bill_Per);
            end;

            trigger OnAfterGetRecord();
            begin
                if VendRec.Get("Vendor No.") then;

                if JobRec.Get("Job No.") then;

                jobTaskRec.Reset;
                jobTaskRec.SetRange("Job No.", "Job No.");
                jobTaskRec.SetRange("Job Task Type", jobTaskRec."Job Task Type"::Posting);
                if jobTaskRec.FindSet then begin
                    repeat
                        jobTaskRec.CalcFields("Contract (Total Price)");
                        B_TotPrice += jobTaskRec."Contract (Total Price)";
                    until jobTaskRec.Next = 0;
                end;

                CustLedgEnt.Reset;
                CustLedgEnt.SetRange("Job No.", "Job No.");
                if CustLedgEnt.FindSet then begin
                    repeat
                        CustLedgEnt.CalcFields(Amount);
                        Amt_CLE += CustLedgEnt.Amount;
                    until CustLedgEnt.Next = 0;
                end;
                if B_TotPrice <> 0 then
                    Bill_Per := (Amt_CLE / B_TotPrice) * 100
                else
                    Bill_Per := 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    //field("Amount   "; AmtReq)
                    //{ }
                    field("Amoun LCY"; LCYAmtReq)
                    {
                        ApplicationArea = All;
                    }
                    field("Print All"; PrintAll)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    trigger OnPreReport();
    begin
    end;

    var
        myInt: Integer;
        VendRec: Record Vendor;
        LCYAmtReq: Boolean;
        AmtReq: Boolean;
        JobRec: Record Job;
        Bill_Per: Decimal;
        CustLedgEnt: Record "Cust. Ledger Entry";
        jobTaskRec: Record "Job Task";
        B_TotPrice: Decimal;
        Amt_CLE: Decimal;
        PrintAll: Boolean;

}