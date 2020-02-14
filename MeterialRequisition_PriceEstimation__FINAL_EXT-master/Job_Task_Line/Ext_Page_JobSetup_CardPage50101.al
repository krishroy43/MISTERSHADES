pageextension 50115 "Ext Job Setup Card Page" extends "Jobs Setup"
{
    layout
    {
        addafter("Default Job Posting Group")
        {
            field("Completion Date Calc."; "Completion Date Calc.")
            {
                ApplicationArea = All;
            }
            // Start 01-07-2019
            field("Project Dimension"; "Project Dimension")
            {
                ApplicationArea = All;
            }
            // Stop 01-07-2019
        }
    }
}