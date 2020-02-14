pageextension 50071 "Ext Purchase Invoice CardPage" extends "Purchase Invoice"
{
    layout
    {
        addafter(Status)
        {
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
            }
            field("Job Task No."; "Job Task No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    actions
    {
        modify(Post)
        {
            trigger
            OnAfterAction()
            begin
                PurchaseInvHeaderRecL.Reset();
                PurchaseInvHeaderRecL.SetRange("Pre-Assigned No.", "No.");
                if PurchaseInvHeaderRecL.FindFirst() then begin
                    VendorLedgerEntryG.Reset();
                    VendorLedgerEntryG.SetRange("Document No.", PurchaseInvHeaderRecL."No.");
                    if VendorLedgerEntryG.FindFirst() then begin
                        VendorLedgerEntryG."Job No." := "Job No.";
                        VendorLedgerEntryG."Job Task No." := "Job Task No.";
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
        }
        modify(PostAndPrint)
        {
            trigger
            OnAfterAction()
            begin
                PurchaseInvHeaderRecL.Reset();
                PurchaseInvHeaderRecL.SetRange("Pre-Assigned No.", "No.");
                if PurchaseInvHeaderRecL.FindFirst() then begin
                    VendorLedgerEntryG.Reset();
                    VendorLedgerEntryG.SetRange("Document No.", PurchaseInvHeaderRecL."No.");
                    if VendorLedgerEntryG.FindFirst() then begin
                        VendorLedgerEntryG."Job No." := "Job No.";
                        VendorLedgerEntryG."Job Task No." := "Job Task No.";
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
        }
        modify("P&osting")
        {
            Visible = false;
        }
    }

    var

        VendorLedgerEntryG: Record "Vendor Ledger Entry";
        PurchaseInvHeaderRecL: Record "Purch. Inv. Header";
        GLEntryRecG: Record "G/L Entry";
}

