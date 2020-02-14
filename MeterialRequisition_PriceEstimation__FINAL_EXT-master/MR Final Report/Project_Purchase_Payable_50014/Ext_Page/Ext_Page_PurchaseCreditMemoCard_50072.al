pageextension 50072 "Ext Purchase Credit Memo" extends "Purchase Credit Memo"
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
        addafter("Expected Receipt Date")
        {
            field(Narration; Narration)
            {
                ApplicationArea = All;
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
                PurchaseCreditHeaderRecL.Reset();
                PurchaseCreditHeaderRecL.SetRange("Pre-Assigned No.", "No.");
                if PurchaseCreditHeaderRecL.FindFirst() then begin
                    // Start Job No. / Job Task No. in VLE
                    VendorLedgerEntryG.Reset();
                    VendorLedgerEntryG.SetRange("Document No.", PurchaseCreditHeaderRecL."No.");
                    if VendorLedgerEntryG.FindFirst() then begin
                        VendorLedgerEntryG."Job No." := PurchaseCreditHeaderRecL."Job No.";
                        VendorLedgerEntryG."Job Task No." := PurchaseCreditHeaderRecL."Job Task No.";
                        VendorLedgerEntryG.Modify();
                    end;
                    // Stop Job No. / Job Task No. in VLE
                    // Start Job No. in General Ledger Entry
                    GLEntryRecG.Reset();
                    GLEntryRecG.SetRange("Document No.", PurchaseCreditHeaderRecL."No.");
                    if GLEntryRecG.FindSet() then begin
                        GLEntryRecG.ModifyAll("Job No.", PurchaseCreditHeaderRecL."Job No.");
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
                PurchaseCreditHeaderRecL.Reset();
                PurchaseCreditHeaderRecL.SetRange("Pre-Assigned No.", "No.");
                if PurchaseCreditHeaderRecL.FindFirst() then begin
                    VendorLedgerEntryG.Reset();
                    VendorLedgerEntryG.SetRange("Document No.", PurchaseCreditHeaderRecL."No.");
                    if VendorLedgerEntryG.FindFirst() then begin
                        VendorLedgerEntryG."Job No." := PurchaseCreditHeaderRecL."Job No.";
                        VendorLedgerEntryG."Job Task No." := PurchaseCreditHeaderRecL."Job Task No.";
                        VendorLedgerEntryG.Modify();
                    end;
                    // Start Job No. in General Ledger Entry
                    GLEntryRecG.Reset();
                    GLEntryRecG.SetRange("Document No.", PurchaseCreditHeaderRecL."No.");
                    if GLEntryRecG.FindSet() then begin
                        GLEntryRecG.ModifyAll("Job No.", PurchaseCreditHeaderRecL."Job No.");
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
        PurchaseCreditHeaderRecL: Record "Purch. Cr. Memo Hdr.";
        GLEntryRecG: Record "G/L Entry";




}