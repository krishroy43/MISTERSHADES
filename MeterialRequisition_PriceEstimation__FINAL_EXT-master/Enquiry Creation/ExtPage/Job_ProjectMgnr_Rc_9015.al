pageextension 50050 "Ext Job Project Manager Rcs" extends "Job Project Manager RC"
{
    actions
    {
        addafter("Purchase Credit Memos")
        {
            action("Requsition Order")
            {
                Image = Purchasing;
                ApplicationArea = All;
                RunObject = page "Material Requisition List Page";
            }

        }
        addafter(Reports)
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
        // // addafter("Purchase Credit Memos")
        // // {
        // //     group("Purch. Enquiry")
        // //     {
        // //         action("Purchase Enquiry")
        // //         {
        // //             Image = Purchasing;
        // //             ApplicationArea = All;
        // //             RunObject = page "Opportunity List";
        // //             Promoted = true;
        // //             PromotedCategory = Report;
        // //         }
        // //     }

        // // }
        // // addafter("Purchase Credit Memos")
        // // {
        // //     group("Purch. Enquiry")
        // //     {
        // //         action("Purchase Enquiry")
        // //         {
        // //             Image = Purchasing;
        // //             ApplicationArea = All;
        // //             RunObject = page "Opportunity List";
        // //             Promoted = true;
        // //             PromotedCategory = Report;
        // //         }
        // //     }
        // // }
        addafter("Purchase Credit Memos")
        {
            group("Purch. Enquiry")
            {

                action("Purchase Enquiry")
                {
                    Image = Purchasing;
                    ApplicationArea = All;
                    RunObject = page "Opportunity List";
                    Promoted = true;
                    PromotedCategory = Report;
                }
            }

        }
        addafter(Reports)
        {
            group("Jobs Report")
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

}