pageextension 50098 "Ext Admin RC" extends "Administrator Role Center"
{
    layout
    {

    }
    actions
    {
        addafter("P&urchase Analysis")
        {
            group("MSME Reports")
            {
                action("Job Report WIP")
                {
                    ApplicationArea = All;
                    RunObject = report "Job Report WIP";
                }
                action("Enquiry Tracker")
                {
                    ApplicationArea = All;
                    RunObject = report "Enquiry Tracker";
                }
                action("Job Report")
                {
                    ApplicationArea = All;
                    RunObject = report "JOBReport";
                }
                action("Job In Hand")
                {
                    ApplicationArea = All;
                    RunObject = report "JOBINHAND";
                }

                action("Job wise sales person commission")
                {
                    ApplicationArea = All;
                    RunObject = report "Jobwise Sales Persons";
                }
            }
        }
    }
}