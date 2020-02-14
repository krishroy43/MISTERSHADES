pageextension 50076 "Ext Customer Ledger Entry" extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Job Task No."; "Job Task No.")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("Posting Type"; "Posting Type")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Retention Reversal"; "Retention Reversal")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Do Not Invoice"; "Do Not Invoice")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
    actions
    {
        addbefore("Ent&ry")
        {
            group("Voucher Report")
            {
                action("Payment Voucher")
                {
                    Image = Report;
                    ApplicationArea = All;
                    Promoted = true;
                    //Visible = false;
                    PromotedCategory = Report;
                    trigger
                    OnAction()
                    var
                        CustomerLedEntryRecL: Record "Cust. Ledger Entry";
                        GLEntryRecL: Record "G/L Entry";
                    begin
                        CurrPage.SetSelectionFilter(CustomerLedEntryRecL);
                        if CustomerLedEntryRecL.FindFirst() then begin
                            GLEntryRecL.Reset();
                            GLEntryRecL.SetRange("Document Type", CustomerLedEntryRecL."Document Type"::Refund);
                            GLEntryRecL.SetRange("Document No.", CustomerLedEntryRecL."Document No.");
                            if GLEntryRecL.FindFirst() then
                                Report.RunModal(50005, true, true, GLEntryRecL)
                            else
                                Error('You cannot print Payment Voucher for Document Type %1 in case of Customer .', CustomerLedEntryRecL."Document Type");
                        end;

                    end;
                }
                action("Receipt Voucher")
                {
                    Image = Report;
                    ApplicationArea = All;
                    Promoted = true;
                    //  Visible = false;
                    PromotedCategory = Report;
                    trigger
                    OnAction()
                    var
                        CustomerLedEntryRecL: Record "Cust. Ledger Entry";
                        GLEntryRecL: Record "G/L Entry";
                    begin
                        CurrPage.SetSelectionFilter(CustomerLedEntryRecL);
                        if CustomerLedEntryRecL.FindFirst() then begin
                            GLEntryRecL.Reset();
                            GLEntryRecL.SetRange("Document Type", CustomerLedEntryRecL."Document Type"::Payment);
                            GLEntryRecL.SetRange("Document No.", CustomerLedEntryRecL."Document No.");
                            if GLEntryRecL.FindFirst() then
                                Report.RunModal(50006, true, true, GLEntryRecL)
                            else
                                Error('You cannot print Receipt Voucher for Document Type %1 in case of Customer .', CustomerLedEntryRecL."Document Type");

                        end;
                    end;
                }



            }
        }
    }
}
