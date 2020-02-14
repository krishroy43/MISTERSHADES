// // pageextension 50758 "Ext Sales Credit Memo" extends "Sales Credit Memo"
// // {
// //     layout
// //     {
// //         addafter(Status)
// //         {
// //             field("Job No."; "Job No.")
// //             {
// //                 ApplicationArea = All;
// //             }
// //         }
// //     }
// // }


pageextension 50758 "Ext Sales Credit Memo" extends "Sales Credit Memo"
{
    layout
    {
        addafter(Status)
        {
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(CopyDocument)
        {
            action("Payment Milestone")
            {
                Image = Payment;
                Caption = 'Payment Milestone';
                Promoted = true;
                ApplicationArea = All;
                RunObject = page "Payment Milestone List";
                RunPageLink = "Document No." = field ("No."), "Document Type" = const ("Credit Memo");

            }
            action("Copy Documents")
            {
                Image = Copy;
                Caption = 'Copy Documents';
                Promoted = true;
                ApplicationArea = All;
                Enabled = "No." <> '';
                trigger
                OnAction()
                var
                    CopySalesDoc: Report "Copy Sales Document-Cust";
                begin
                    Clear(CopySalesDoc);
                    CopySalesDoc.SetSalesHeader(Rec);
                    CopySalesDoc.RUNMODAL;
                    CLEAR(CopySalesDoc);
                    IF GET("Document Type", "No.") THEN;

                end;
            }
        }
        modify(CopyDocument)
        {
             Visible = false;
        }
    }
}