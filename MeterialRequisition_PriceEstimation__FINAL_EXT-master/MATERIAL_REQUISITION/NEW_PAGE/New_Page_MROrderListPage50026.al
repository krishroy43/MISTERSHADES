page 50026 "Material Requisition Line List"
{
    PageType = List;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = "Material Requisition Line";
    //AutoSplitKey = true;
    //DelayedInsert = true;
    //MultipleNewLines = true;
    //LinksAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    //Caption = 'Material Req. Lines';
    Caption = 'Requisition Order Lines List';


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
                field("Enquiry Item"; "Enquiry Item")
                {
                    ApplicationArea = All;
                    // Editable = EditableFalseTrueAllControl;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;

                    trigger
                   OnValidate()
                    var
                    begin
                        if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                            Error('Job No. / Job Task No. Must be blank.');
                    end;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger
                   OnValidate()
                    var
                    begin
                        if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                            Error('Job No. / Job Task No. Must be blank.');
                    end;
                }
                field("Quantity needed"; "Quantity needed")
                {
                    ApplicationArea = All;

                }
                field("Qty. to Enquiry"; "Qty. to Enquiry")
                {
                    ApplicationArea = All;
                    // Editable = EditableFalseTrueAllControl;
                }
                field("Available Inventory"; "Available Inventory")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;

                    trigger
                   OnValidate()
                    var
                    begin
                        if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                            Error('Job No. / Job Task No. Must be blank.');
                    end;
                }
                field(Location; Location)
                {
                    ApplicationArea = All;

                    trigger
                    OnValidate()
                    var
                    begin
                        if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                            Error('Job No. / Job Task No. Must be blank.');
                    end;
                    //Editable = false;
                }
                field("Expected receipt date"; "Expected receipt date")
                {
                    ApplicationArea = All;

                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job task No."; "Job task No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Planning Line No."; "Job Planning Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Req. To Quote"; "Req. To Enqry")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }

            }
        }
    }
}