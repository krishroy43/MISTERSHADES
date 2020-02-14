pageextension 50077 "Customer Page Extn." extends "Customer Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Retention A/c"; "Retention A/c")
            {
                ApplicationArea = All;
                // Start 27-06-2019
                Visible = false;
                // Stop 27-06-2019
            }
            field("Advance A/c"; "Advance A/c")
            {
                ApplicationArea = All;
                // Start 27-06-2019
                Visible = false;
                // Stop 27-06-2019
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}