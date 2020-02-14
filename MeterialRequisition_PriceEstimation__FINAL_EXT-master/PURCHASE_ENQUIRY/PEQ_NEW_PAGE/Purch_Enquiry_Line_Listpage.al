page 50004 "Purch. Enquiry List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purch. Enquiry Header";
    Caption = 'Purchase Enquiry List';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Purch. Enquiry Card";

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                /*
                field("Lead Type"; "Lead Type")
                {
                    ApplicationArea = All;

                }
                */

                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;

                }
                field(Contact; Contact)
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                /*
                field(Address; Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;
                }
                */
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Purchase Code"; "Purchase Code")
                {
                    ApplicationArea = All;
                }
                field("Requisition No."; "Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("Creation date"; "Creation dateTime")
                {
                    ApplicationArea = All;
                }
                field("Expected delivery date"; "Expected delivery date")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    trigger
    OnOpenPage()
    begin

    end;

    trigger
    OnAfterGetCurrRecord()
    begin
        // FILTERGROUP(2);
        //SETRANGE("Requisition No.", GetFilter("Requisition No."));
        //FILTERGROUP(0);
    end;
}