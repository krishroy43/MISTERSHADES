pageextension 50081 "Payment Milestone Extend SI" extends "Sales Invoice"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Progressive Invoice"; "Progressive Invoice")
            {
                ApplicationArea = All;
            }
            field("Customer Posting Group"; "Customer Posting Group")
            {
                ApplicationArea = All;

            }

        }
        addbefore("External Document No.")
        {
            field("Work Done"; "Work Done")
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addafter(DraftInvoice)
        {
            action(SalesProformaInvoice)
            {
                Caption = 'Pro Forma Invoice';
                ApplicationArea = All;
                Image = Report;
                trigger
                OnAction()
                var
                    SalesLineRecG: Record "Sales Line";
                    SalesHeaderRecG: Record "Sales Header";
                begin
                    CurrPage.SetSelectionFilter(SalesHeaderRecG);
                    if SalesHeaderRecG.FindFirst() then begin
                        SalesLineRecG.Reset();
                        SalesLineRecG.SetRange("Document No.", SalesHeaderRecG."No.");
                        SalesLineRecG.SetRange("Document Type", SalesHeaderRecG."Document Type");
                        SalesLineRecG.SetFilter("Job No.", '<>%1', '');
                        if SalesLineRecG.FindFirst() then
                            Report.RunModal(50133, true, true, SalesHeaderRecG)
                        else begin
                            SalesHeaderRecG.Reset();
                            CurrPage.SetSelectionFilter(SalesHeaderRecG);
                            if SalesHeaderRecG.FindFirst() then
                                Report.RunModal(50233, true, true, SalesHeaderRecG);
                        end;
                    end;
                end;
            }
        }
        addlast("P&osting")
        {
            action("Retention Due Details")
            {
                ApplicationArea = All;
                RunObject = Page "Retention Due Details";

            }
            action("Payment Milestone")
            {
                Image = Payment;
                //Caption = 'Payment Milestone';
                //Promoted = true;
                //PromotedCategory = Process;
                // ApplicationArea = "#Basic", "#Suite";
                //PromotedIsBig = true;
                ApplicationArea = All;
                //PromotedOnly = true;
                TRIGGER OnAction()
                var
                    PaymentMilestone: Record "Payment Milestone";
                    LineNo: Integer;
                BEGIN
                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetFilter("Job No.", '<>%1', '');
                    IF SalesLine.FindFirst() THEN BEGIN
                        PaymentMilestone2.Reset();
                        PaymentMilestone2.SetRange("Document Type", Rec."Document Type");
                        PaymentMilestone2.SetRange("Document No.", Rec."No.");
                        IF NOT PaymentMilestone2.FindFirst() THEN BEGIN
                            PaymentMilestone.Reset();
                            PaymentMilestone.SetRange("Document Type", PaymentMilestone."Document Type"::Job);
                            PaymentMilestone.SetRange("Document No.", SalesLine."Job No.");
                            IF PaymentMilestone.FindFirst() THEN BEGIN
                                REPEAT
                                    //SalesHeader.Reset();
                                    //SalesHeader.SetRange("Document Type", Rec."Document Type");
                                    //SalesHeader.SetRange("No.", SalesLine."Document No.");
                                    //IF SalesHeader.FindFirst THEN BEGIN
                                    //SalesHeader.CalcFields(Amount);
                                    PaymentMilestone3.Init();
                                    PaymentMilestone3.Copy(PaymentMilestone);
                                    PaymentMilestone3."Document Type" := Rec."Document Type";
                                    PaymentMilestone3."Document No." := Rec."No.";
                                    PaymentMilestone3."Currency Factor" := Rec."Currency Factor";
                                    PaymentMilestone3.Insert(true);
                                //END;
                                UNTIL PaymentMilestone.NEXT = 0;
                            END;
                        END;
                        Commit();
                    END;
                    PaymentMS.SetValues(Rec."Currency Factor");
                    Clear(PaymentMilestone);
                    PaymentMilestone.Reset();
                    PaymentMilestone.SetRange("Document Type", Rec."Document Type");
                    PaymentMilestone.SetRange("Document No.", Rec."No.");
                    PAGE.RUNMODAL(50033, PaymentMilestone);
                END;
            }

        }
        modify(ProformaInvoice)
        {
            Visible = false;
        }

    }

    var
        Job: Record Job;
        PaymentMilestone2: Record "Payment Milestone";
        SalesLine: Record "Sales Line";
        PaymentMilestone3: Record "Payment Milestone";
        SalesHeader: Record "Sales Header";
        PaymentMS: Page "Payment Milestone List";
}