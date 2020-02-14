page 50034 "Retention Due Details"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cust. Ledger Entry";
    Editable = false;
    SourceTableView = WHERE ("Posting Type" = const (Retention), "Retention Reversal" = const (false));

    layout
    {
        area(Content)
        {
            repeater("Retention Details")
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;

                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Customer Name"; CustNameCodeG)
                {
                    ApplicationArea = All;

                }
                field("Posting Type"; "Posting Type")
                {
                    ApplicationArea = All;

                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Retention Reversal"; "Retention Reversal")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //  Setfilter("Due Date", '<%1', Today);
    end;

    trigger
    OnAfterGetRecord()
    var
        CustRecG: Record Customer;
    begin
        CustRecG.Reset();
        if CustRecG.get(Rec."Customer No.") then
            CustNameCodeG := CustRecG.Name;
    end;

    var
        myInt: Integer;
        CustNameCodeG: Code[90];
}