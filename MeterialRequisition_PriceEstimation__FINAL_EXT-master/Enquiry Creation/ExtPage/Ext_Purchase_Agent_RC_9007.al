pageextension 50051 "Ext Purchase Agent RsC" extends "Purchasing Agent Role Center"
{
    actions
    {
        addafter("Posted Documents")
        {
            group("Requisition Order")
            {
                action("Requsition Order")
                {
                    Image = Purchasing;
                    ApplicationArea = All;
                    RunObject = page "Material Requisition List Page";
                }
            }
        }
        addafter("Vendor - T&op 10 List")
        {

            group("BC Report")
            {
                action("Job Material Consumption")
                {
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = report "Job Material Consumption";
                    Promoted = true;
                    PromotedCategory = Report;
                }
                action("Import Po MSBM1")
                {
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = report "Purchase Order";
                    Promoted = true;
                    PromotedCategory = Report;
                }
            }

        }
        addafter("Posted Documents")
        {
            group("Purch. Enquiry")
            {
                action("Purchase Enquiry")
                {
                    Image = Purchasing;
                    ApplicationArea = All;
                    RunObject = page "Purch. Enquiry List";
                    ;
                }
            }
        }
        addafter(Action28)
        {
            action("Enquiry Tracker")
            {
                // ApplicationArea = Basic, Suite;
                ApplicationArea = All;
                Caption = 'Enquiry Tracker';
                Image = "Report";
                RunObject = report "Enquiry Tracker";
                Promoted = true;
                PromotedCategory = Report;
            }

            action(JOBINHAND)
            {
                // ApplicationArea = Basic, Suite;
                ApplicationArea = All;
                Caption = 'JOB IN HAND';
                Image = "Report";
                RunObject = report JOBINHAND;
                Promoted = true;
                PromotedCategory = Report;
            }

            action(JOBReport)
            {
                // ApplicationArea = Basic, Suite;
                ApplicationArea = All;
                Caption = 'JOB Report';
                Image = "Report";
                RunObject = report JOBReport;
                Promoted = true;
                PromotedCategory = Report;
            }


        }
    }
}