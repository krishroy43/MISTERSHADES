tableextension 50027 "User Setup Depart." extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50001; Departments; Option)
        {
            OptionMembers = " ","FrontDesk","Back Office Sales",Sales,Design,Project,Production,Store,Management,Contract,Finance,"Quantity surveyor",Purchase;
        }
        field(50000; "Enquiry Restriction"; Boolean)
        {

        }
        // Start 04-07-2019
        field(50002; "Job Planning Lines Fields"; Boolean)
        {

        }
        // Stop 04-07-2019

    }

    var
        myInt: Integer;
}