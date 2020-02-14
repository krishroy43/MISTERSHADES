pageextension 50023 "Ext. Sales Order" extends "Sales Order"
{
    //Caption = 'Dispatch notes';
    layout
    {
        addafter(Status)
        {
            field("Dispatch Type"; "Dispatch Type")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
            }
            field("Job description"; "Job description")
            {
                ApplicationArea = All;
            }
            field("Job Task No"; "Job Task No")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Job Task Description"; "Job Task Description")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        addafter("P&osting")
        {
            action("Payment Milestone")
            {
                Image = Payment;
                //Caption = 'Payment Milestone';
                //Promoted = true;
                //PromotedCategory = Process;
                // ApplicationArea = "#Basic", "#Suite";
                //PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = page "Payment Milestone List";
                RunPageLink = "Document No." = field ("No."), "Document Type" = field ("Document Type");
                //PromotedOnly = true;
                TRIGGER OnAction()
                var
                    PaymentMilestone: Record "Payment Milestone";
                BEGIN
                    //  PaymentMilestone.Reset();
                    // PaymentMilestone.SetRange("Document Type", Rec."Document Type");
                    // PaymentMilestone.SetRange("Document No.", Rec."No.");
                    // if PaymentMilestone.Find() then
                    // PAGE.RUNMODAL(50033, PaymentMilestone);
                END;
            }

        }
        addafter(PostAndNew)
        {
            action("Post Order")
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Post;
                Visible = false;
                trigger
                OnAction()
                var
                    SalesOrderPgL: page "Sales Order";
                    SalesHeaderRecL: Record "Sales Header";
                begin
                    // if "Dispatch Type" = "Dispatch Type"::" " then
                    //     Error('Please Select Dispatch Type, It should not be Blank.');
                    if "Dispatch Type" = "Dispatch Type"::Partial then begin
                        Status := Status::Released;
                        Modify();
                        //50005
                        // Codeunit.Run(81, Rec);
                        Codeunit.Run(50005, Rec);

                    end
                    else begin
                        if NOT IsApprovedForPostingCusto then
                            exit;
                        //Codeunit.Run(81, Rec);
                        Codeunit.Run(50005, Rec);

                    end;
                end;
            }
        }



        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndNew)
        {
            Visible = false;
        }

        modify(PostAndSend)
        {
            Visible = false;
        }
        modify(PreviewPosting)
        {
            Visible = false;
        }

    }



    procedure IsApprovedForPostingCusto(): Boolean
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
    begin
        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN BEGIN
            IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
                ERROR('You cannot post the document of type %1 with the number %2 before all related prepayment invoices are posted.', "Document Type", "No.");
            IF "Document Type" = "Document Type"::Order THEN
                IF PrepaymentMgt.TestSalesPayment(Rec) THEN
                    ERROR('There are unpaid prepayment invoices related to the document of type %1 with the number %2.', "Document Type", "No.");
            EXIT(TRUE);
        END;
    end;
}