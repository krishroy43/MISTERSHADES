pageextension 50069 "Purchase Order Card " extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Job Task No."; "Job Task No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addlast(General)
        {
            field("Enquiry No."; "Enquiry No.")
            {
                ApplicationArea = All;
            }
            field("Requisition No."; "Requisition No.")
            {
                ApplicationArea = All;
            }
        }
    }
}