page 50025 "Purch. Enquiry Line List "
{
    PageType = List;
    //ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = "Purch. Enquiry Line";
    //AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = false;
    Caption = 'Purch. Enquiry Line List';


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
}