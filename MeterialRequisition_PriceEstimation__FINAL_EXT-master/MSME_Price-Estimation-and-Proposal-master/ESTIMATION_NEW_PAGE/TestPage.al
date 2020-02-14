page 50024 MyPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Estimation Header";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;

                }
                field("Version No."; "Version No.")
                {
                    ApplicationArea = All;

                }
                field("Version No. Disp"; "Version No. Disp")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}