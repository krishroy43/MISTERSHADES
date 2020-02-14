page 50003 "Purch. Enquiry Subform"
{
    PageType = ListPart;
    //ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = "Purch. Enquiry Line";
    AutoSplitKey = true;
    DeleteAllowed = true;
    Caption = 'Purch. Enquiry Line';


    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;


                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                // Start 04-07-2019
                field("Item Description"; "Item Description")
                {
                    ApplicationArea = All;
                }
                field("Item Description 2"; "Item Description 2")
                {
                    ApplicationArea = All;
                }
                // Stop 04-07-2019
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Location; Location)
                {
                    ApplicationArea = All;
                }
                field("Expected receipt date"; "Expected receipt date")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job task No."; "Job task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Planning Line No."; "Job Planning Line No.")
                {
                    ApplicationArea = All;
                }
                field("Material Req. No."; "Material Req. No.")
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
            action("Get Enquiry line")
            {
                ApplicationArea = All;

                trigger OnAction()
                var

                begin

                end;
            }

        }
    }

    var
        myInt: Integer;
}