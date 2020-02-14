pageextension 50094 "Ext Posted Sales Invoice" extends "Posted Sales Invoice"
{
    actions
    {
        addlast(Invoice)
        {
            action("Payment Milestone")
            {
                Image = Payment;
                ApplicationArea = All;
                RunObject = page "Payment Milestone List";
                RunPageLink = "Document No." = field ("No."), "Document Type" = const ("Posted Invoice");
            }
        }
        addafter(Print)
        {
            action("Print Report")
            {
                ApplicationArea = All;
                Image = Invoice;
                Caption = 'Print';
                trigger
                OnAction()
                var

                    SalesInvoiceHeaderRec: Record "Sales Invoice Header";
                    SalesInvoiceLineRec: Record "Sales Invoice Line";
                begin
                    CurrPage.SetSelectionFilter(SalesInvoiceHeaderRec);
                    if SalesInvoiceHeaderRec.FindFirst() then begin
                        SalesInvoiceLineRec.Reset();
                        SalesInvoiceLineRec.SetRange("Document No.", SalesInvoiceHeaderRec."No.");
                        //SalesLineRecG.SetRange("Document Type", SalesHeaderRecG."Document Type");
                        SalesInvoiceLineRec.SetFilter("Job No.", '<>%1', '');
                        if SalesInvoiceLineRec.FindFirst() then
                            Report.RunModal(50333, true, true, SalesInvoiceHeaderRec)
                        else begin
                            SalesInvoiceHeaderRec.Reset();
                            CurrPage.SetSelectionFilter(SalesInvoiceHeaderRec);
                            if SalesInvoiceHeaderRec.FindFirst() then
                                Report.RunModal(50433, true, true, SalesInvoiceHeaderRec);
                        end;
                    end;
                end;
            }
        }
        modify(Print)
        {
            Visible = false;
        }
    }
}