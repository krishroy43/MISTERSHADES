page 50022 "Estimation Archieve List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Estimation Archieve Header";
    CardPageId = "Estimation Archieve Header";
    RefreshOnActivate = true;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    //Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Version No."; "Version No.")
                {
                    ApplicationArea = All;

                }
                field("Version No. Disp"; "Version No. Disp")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;

                }
                field("Estimation No."; "Estimation No.")
                {
                    ApplicationArea = All;

                }
                field(Status; Status)
                {
                    ApplicationArea = All;

                }
                field("Estimation Date"; "Estimated Qty.")
                {
                    ApplicationArea = All;

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