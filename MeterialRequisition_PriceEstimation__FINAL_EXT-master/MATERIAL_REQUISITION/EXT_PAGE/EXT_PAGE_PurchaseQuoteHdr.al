pageextension 50034 PurchaseQHdrPage extends "Purchase Quote"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Enquiry No."; "Enquiry No.")
            {
                ApplicationArea = all;
                //Editable = false;
            }
            field("Requisition No."; "Requisition No.")
            {
                ApplicationArea = all;
                // Editable = false;
            }
            field("Purchaser Type"; "Purchaser Type")
            {
                ApplicationArea = all;
                Caption = 'Purchase Type';
            }
            field("Job No."; "Job No.")
            {
                ApplicationArea = all;
            }
            field("Job Task No."; "Job Task No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Ref. No."; "Ref. No.")
            {
                ApplicationArea = all;
            }
            field(Remarks; Remarks)
            {
                ApplicationArea = all;
            }
            field("Location Code_LT"; "Location Code")
            {
                ApplicationArea = All;
            }
            field("Posting Date"; "Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        modify("Co&mments")
        {
            Caption = 'Tems & Condition';
        }
        // Add changes to page actions here
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                PurchPayRec: Record "Purchases & Payables Setup";
                PurchHdrRec: Record "Purchase Header";
                I: Integer;
            begin
                i := 0;
                if "Purchaser Type" = Rec."Purchaser Type"::"Raw Material" then begin
                    PurchPayRec.Reset();
                    PurchPayRec.Get();
                    PurchHdrRec.Reset();
                    PurchHdrRec.SetRange("Requisition No.", Rec."Requisition No.");
                    if PurchHdrRec.FindSet then begin
                        repeat
                            I += 1;
                        until PurchHdrRec.Next = 0;
                    end;
                    if PurchPayRec."Minimum No. of Quote." <> 0 then begin
                        If I < PurchPayRec."Minimum No. of Quote." then
                            Error('There should be atleast %1 quotes for the requisiton No. %2 for sending approval', PurchPayRec."Minimum No. of Quote.", Rec."Requisition No.");
                    end;
                end;
            end;
        }
        modify(MakeOrder)
        {
            trigger
            OnBeforeAction()
            var
                PurchaseHeaderRecL: Record "Purchase Header";
            begin
                if "Purchaser Type" = "Purchaser Type"::"Raw Material" then begin
                    TestField("Requisition No.");
                    TestField("Enquiry No.");

                    PurchaseHeaderRecL.Reset();
                    PurchaseHeaderRecL.SetRange("Document Type", "Document Type"::Quote);
                    PurchaseHeaderRecL.SetRange(Status, Status::Released);
                    PurchaseHeaderRecL.SetRange("Requisition No.", "Requisition No.");
                    if PurchaseHeaderRecL.Count < 3 then
                        Error('There should be atleast 3 Purchase Quote For requisition No. %1', "Requisition No.");

                end;
            end;
        }


    }
    trigger
    OnQueryClosePage(CloseAction: Action): Boolean
    begin
        ///TestField("Purchaser Type");
    end;


    var
        myInt: Integer;


}

pageextension 50085 "Ext Purchase List" extends "Purchase Quotes"
{
    actions
    {
        addafter("&Quote")
        {
            action("Purchase Quote Comparison")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = Report2;
                RunObject = Report "Quote Comparison Report";

            }



        }
        modify("Co&mments")
        {
            Caption = 'Tems & Condition';
        }
    }
}