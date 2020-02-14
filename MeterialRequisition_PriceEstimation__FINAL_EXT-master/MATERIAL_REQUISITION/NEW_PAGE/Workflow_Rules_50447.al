page 50447 "Workflow Rules"
{
    SourceTable = "Workflow Rule";
    PageType = List;
    // ApplicationArea = All;
    //UsageCategory = Administration;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                }
                field("Table ID"; "Table ID") { ApplicationArea = All; }
                field("Field No."; "Field No.") { ApplicationArea = All; }
                field(Operator; Operator) { ApplicationArea = All; }
                field("Workflow Code"; "Workflow Code") { ApplicationArea = All; }
                field("Workflow Step ID"; "Workflow Step ID") { ApplicationArea = All; }
                field("Field Caption"; "Field Caption") { ApplicationArea = All; }
                field("Workflow Step Instance ID"; "Workflow Step Instance ID") { ApplicationArea = All; }
            }
        }
    }

}