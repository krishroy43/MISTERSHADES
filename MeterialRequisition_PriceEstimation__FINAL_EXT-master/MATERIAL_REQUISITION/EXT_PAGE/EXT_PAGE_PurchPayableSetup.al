pageextension 50007 "Ext. Purchase & Payable Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted Credit Memo Nos.")
        {
            field("Material Requisition No."; "Material Requisition No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posted Credit Memo Nos.")
        {
            field("Purchase Enquiry No."; "Purchase Enquiry No.")
            {
                ApplicationArea = All;
            }
            field("Minimum No. of Quote."; "Minimum No. of Quote.")
            {
                ApplicationArea = All;
            }
        }
    }


}