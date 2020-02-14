tableextension 50004 "Ext. Purchase & Payable Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50004; "Material Requisition No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50003; "Purchase Enquiry No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50005; "Minimum No. of Quote."; Integer)
        {

        }
    }

}