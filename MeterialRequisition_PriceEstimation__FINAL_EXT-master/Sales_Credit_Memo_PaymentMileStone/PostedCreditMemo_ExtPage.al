pageextension 50686 "Ext Posted Sales Credit Memo" extends "Posted Sales Credit Memo"
{
    actions
    {
        addafter(Dimensions)
        {
            action("Payment Milestone")
            {
                Image = Payment;
                Caption = 'Payment Milestone';
                Promoted = true;
                ApplicationArea = All;
                RunObject = page "Payment Milestone List";
                RunPageLink = "Document No." = field ("No."), "Document Type" = const ("Posted Credit Memo");

            }
        }
    }
}