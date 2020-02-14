page 50017 "BOQ List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BOQ Tbl";

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
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;

                }
                field("Company Item Code"; "Company Item Code")
                {
                    ApplicationArea = All;

                }
                field("Company Item Description"; "Company Item Description")
                {
                    ApplicationArea = All;

                }
                field("Unit Of Measure"; "Unit Of Measure")
                {
                    ApplicationArea = All;

                }
                field("Length Type"; "Length Type")
                {
                    ApplicationArea = All;

                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;

                }
                field("Drawing Number"; "Drawing Number")
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