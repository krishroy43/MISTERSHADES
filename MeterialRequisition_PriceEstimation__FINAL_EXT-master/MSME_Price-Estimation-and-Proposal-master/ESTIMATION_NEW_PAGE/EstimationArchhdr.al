page 50021 "Estimation Archieve Header"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Estimation Archieve Header";
    Editable = false;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;

                }
                field("Estimation No."; "Estimation No.")
                {
                    ApplicationArea = All;

                }
                field("Estimation Date"; "Estimated Qty.")
                {
                    ApplicationArea = All;

                }
                field("Version No."; "Version No.")
                {
                    ApplicationArea = All;

                }
                field("Version No. Disp"; "Version No. Disp")
                {
                    ApplicationArea = All;

                }
                field("Total Qty."; "Total Qty.")
                {
                    ApplicationArea = All;

                }
                field("Rate per Sq.M"; "Rate per Sq.M")
                {
                    ApplicationArea = All;

                }
                field(Status; Status)
                {
                    ApplicationArea = All;

                }

            }

            group("Estimation Lines")
            {
                part("Est. Line"; "Estimation Archieve Subform")
                {
                    ApplicationArea = All;
                    SubPageLink = "Quote No." = field ("Quote No."), "Version No." = field ("Version No.");
                    UpdatePropagation = Both;
                    Editable = false;
                    //Enabled = "No." <> '';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }



}