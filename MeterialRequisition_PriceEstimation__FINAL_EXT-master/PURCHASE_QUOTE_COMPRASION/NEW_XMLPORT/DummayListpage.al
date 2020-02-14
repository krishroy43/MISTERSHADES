page 50010 "XML Dummy Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Import/Export Xmlport";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Drawing number"; "Drawing number")
                {
                    ApplicationArea = All;

                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Item desc. and Specification"; "Item desc. and Specification")
                {
                    ApplicationArea = All;
                }
                field("Company Code"; "Company Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of measure"; "Unit of measure")
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