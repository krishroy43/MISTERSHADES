pageextension 50335 UserSetupEXT extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("User ID")
        {
            field(Departments; Departments)
            {
                ApplicationArea = all;
            }
        }
        addafter(Email)
        {
            field("Enquiry Restriction"; "Enquiry Restriction")
            {
                ApplicationArea = All;
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

