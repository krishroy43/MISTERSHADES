page 50020 "Estimation Archieve Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Estimation Archieve Line";
    //PromotedActionCategories = 'New,Process,Report,Prices,WIP,Navigate,Estimation Line,Print/Send';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;

                }
                field("Drawing Number"; "Drawing Number")
                {
                    ApplicationArea = All;

                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;

                }
                field("Version No."; "Version No.")
                {
                    ApplicationArea = All;

                }
                field("Row Type"; "Row Type")
                {
                    ApplicationArea = All;

                }
                field("Item Type"; "Item Type")
                {
                    ApplicationArea = All;

                }
                field("Item Code"; "Item Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Description 2"; "Description 2")
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

                field("Company Item Code"; "Company Item Code")
                {
                    ApplicationArea = All;

                }
                field("Company Item Description"; "Company Item Description")
                {
                    ApplicationArea = All;

                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;

                }
                field("Total Price"; "Total Price")
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

    var
        BOQImport: XmlPort "BOQ-Import";
        BOQPage: Page "BOQ List";
        EstimationProcess: Codeunit Process;
}