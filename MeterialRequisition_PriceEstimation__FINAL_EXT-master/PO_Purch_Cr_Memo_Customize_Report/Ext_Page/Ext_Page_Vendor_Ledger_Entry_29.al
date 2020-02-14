pageextension 50057 "Ext Vendor Leger Entry" extends "Vendor Ledger Entries"
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
                    Visible = false;
                    PromotedCategory = Report;
                    trigger
                    OnAction()
                    var
                        VenLedEntryRecL: Record "Vendor Ledger Entry";
                        GLEntryRecL: Record "G/L Entry";
                    begin
                        CurrPage.SetSelectionFilter(VenLedEntryRecL);
                        if VenLedEntryRecL.FindFirst() then begin
                            GLEntryRecL.Reset();
                            GLEntryRecL.SetRange("Document Type", VenLedEntryRecL."Document Type"::Payment);
                            GLEntryRecL.SetRange("Document No.", VenLedEntryRecL."Document No.");
                            if GLEntryRecL.FindFirst() then
                                Report.RunModal(50005, true, true, GLEntryRecL)
                            else
                                Error('You cannot print Payment Voucher for Document Type %1 in case of Vendor .', VenLedEntryRecL."Document Type");
                        end;

                    end;
                }



                action("Receipt Voucher")
                {
                    Image = Report;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Report;
                    trigger
                    OnAction()
                    var
                        VenLedEntryRecL: Record "Vendor Ledger Entry";
                        GLEntryRecL: Record "G/L Entry";
                    begin
                        CurrPage.SetSelectionFilter(VenLedEntryRecL);
                        if VenLedEntryRecL.FindFirst() then begin
                            GLEntryRecL.Reset();
                            GLEntryRecL.SetRange("Document Type", VenLedEntryRecL."Document Type"::Refund);
                            GLEntryRecL.SetRange("Document No.", VenLedEntryRecL."Document No.");
                            if GLEntryRecL.FindFirst() then
                                Report.RunModal(50006, true, true, GLEntryRecL)
                            else
                                Error('You cannot print Receipt Voucher for Document Type %1 in case of Vendor .', VenLedEntryRecL."Document Type");
                        end;
                    end;
                }
            }
        }

    }

}