pageextension 50056 "Ext General Leger Entry" extends "General Ledger Entries"
{

    actions
    {
        addbefore("Ent&ry")
        {
            action("Update G/L Acc. No.")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    UpdateGLReport: Report 50115;
                begin
                    UpdateGLReport.Run();
                end;
            }
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
                        GLEntryRecL: Record "G/L Entry";
                    begin
                        Clear(GLEntryRecL);
                        CurrPage.SetSelectionFilter(GLEntryRecL);
                        GLEntryRecL.SetRange("Document No.", "Document No.");
                        if GLEntryRecL.FindFirst() then
                            Report.RunModal(50005, true, true, GLEntryRecL);
                    end;
                }
                action("Receipt Voucher")
                {
                    Image = Report;
                    ApplicationArea = All;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Report;
                    trigger
                    OnAction()
                    var
                        GLEntryRecL: Record "G/L Entry";
                    begin
                        Clear(GLEntryRecL);
                        CurrPage.SetSelectionFilter(GLEntryRecL);
                        GLEntryRecL.SetRange("Document No.", "Document No.");
                        if GLEntryRecL.FindFirst() then
                            Report.RunModal(50006, true, true, GLEntryRecL);
                    end;
                }

                // NEW
                /*
                                group(Print)
                                {
                                    action("Payment Voucher_")
                                    {
                                        ApplicationArea = All;
                                        Caption = 'Payment Voucher';
                                        Image = PrintVoucher;
                                        trigger OnAction()
                                        var
                                            PayVoucher: Report 50109;
                                            GLEntry: Record "G/L Entry";
                                        begin
                                            Clear(GLEntry);
                                            // GLEntry.SetCurrentKey("Entry No.");
                                            // GLEntry.SetRange("Entry No.", Rec."Entry No.");
                                            GLEntry.SetRange("Document No.", Rec."Document No.");
                                            GLEntry.SetRange("Source Type", "Source Type"::Vendor);
                                            if GLEntry.FindSet() then begin
                                                PayVoucher.SetTableView(GLEntry);
                                                PayVoucher.Run();
                                            end;
                                        end;
                                    }
                                    action("Journal Voucher")
                                    {
                                        ApplicationArea = All;
                                        // Caption = 'Print';
                                        Image = PaymentJournal;
                                        trigger OnAction()
                                        var
                                            PayVoucher: Report 50103;
                                            GLEntry: Record "G/L Entry";
                                        begin
                                            Clear(GLEntry);
                                            //GLEntry.SetCurrentKey("Entry No.");
                                            // GLEntry.SetRange("Entry No.", Rec."Entry No.");
                                            GLEntry.SetRange("Document No.", Rec."Document No.");
                                            if GLEntry.FindFirst() then begin
                                                PayVoucher.SetTableView(GLEntry);
                                                PayVoucher.Run();
                                            end;
                                        end;
                                    }
                                    action("Receipt Voucher_")
                                    {
                                        ApplicationArea = All;
                                        Image = PaymentJournal;
                                        Caption = 'Receipt Voucher';
                                        trigger OnAction()
                                        var
                                            PayVoucher: Report 50108;
                                            GLEntry: Record "G/L Entry";
                                        begin
                                            Clear(GLEntry);
                                            GLEntry.SetRange("Document No.", Rec."Document No.");
                                            GLEntry.SetRange("Source Type", "Source Type"::Customer);
                                            if GLEntry.FindSet() then begin
                                                PayVoucher.SetTableView(GLEntry);
                                                PayVoucher.Run();
                                            end;
                                        end;
                                    }
                     }
                                    
                */


                //NEW
            }


        }

    }

}

report 50115 "Update G/L"
{
    // UsageCategory = Administration;
    //ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData 17 = RIMD;
    dataset
    {
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(FilterText;
                    FilterText)
                    {
                        ApplicationArea = All;
                        Caption = 'Filter Text';
                    }
                    field(GLAccNo; GLAccNo)
                    {
                        ApplicationArea = All;
                        Caption = 'G/L Account No.';
                        TableRelation = "G/L Account";
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            RecGLEntry: Record "G/L Entry";
        begin
            If CloseAction IN [ACTION::OK, ACTION::LookupOK] then begin
                if (FilterText <> '') AND (GLAccNo <> '') then begin
                    Clear(RecGLEntry);
                    RecGLEntry.SetFilter("Entry No.", FilterText);
                    if RecGLEntry.FindSet() then begin
                        if not Confirm('Are you sure you want to update the G/L Entry Table?', false) then
                            exit;
                        repeat
                            RecGLEntry.Validate("G/L Account No.", GLAccNo);
                            RecGLEntry.Modify();
                        until RecGLEntry.Next() = 0;
                    end;
                end;
            end;
        end;
    }
    trigger OnPostReport()
    var

    begin

    end;

    var
        FilterText: Text;
        GLAccNo: Code[20];
}