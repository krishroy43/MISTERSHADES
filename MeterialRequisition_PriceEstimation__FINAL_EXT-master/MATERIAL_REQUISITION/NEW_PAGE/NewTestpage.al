page 50013 WorkFLowEvents
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Workflow Event";

    layout
    {
        area(Content)
        {
            repeater("General")
            {

                field("Function Name"; "Function Name")
                {
                    ApplicationArea = All;

                }
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
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