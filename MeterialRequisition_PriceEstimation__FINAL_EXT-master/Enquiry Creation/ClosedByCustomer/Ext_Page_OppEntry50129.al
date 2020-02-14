pageextension 50129 "Ext Opp Entry Line" extends "Opportunity Subform"
{
    layout
    {
        addafter("Sales Cycle Stage Description")
        {
            field(LeadType; LeadType)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(CustomerNo; CustomerNo)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Contact No."; "Contact No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Assign to"; "Assign to")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Assign to Name"; "Assign to Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Updated By"; "Updated By")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}