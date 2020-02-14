pageextension 50000 "Production BOM Ext." extends "Production BOM"
{
    layout
    {
        addafter(Description)
        {
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
            }
            field("Drawing No."; "Drawing No.")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        addafter("Copy &BOM")
        {
            action("Copy Planning Lines")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    JobPlanningLine: record "Job Planning Line";
                    ProdBomLine: record "Production BOM Line";
                    LineNo: Integer;
                    Item: Record Item;
                begin
                    TestField("Job No.");
                    TestField("Drawing No.");
                    ProdBomLine.reset;
                    ProdBomLine.SetRange("Production BOM No.", rec."No.");
                    if ProdBomLine.findfirst then
                        ProdBomLine.DeleteAll();

                    LineNo := 0;

                    JobPlanningLine.reset;
                    JobPlanningLine.setrange("Job No.", rec."Job No.");
                    JobPlanningLine.SetRange("Drawing No.", rec."Drawing No.");
                    if JobPlanningLine.findset then
                        repeat
                            Item.reset;
                            Item.SetRange("No.", JobPlanningLine."No.");
                            if Item.findfirst then;

                            if Item.Type = Item.type::Inventory then Begin
                                LineNo += 10000;
                                ProdBomLine.init;
                                ProdBomLine."Production BOM No." := rec."No.";
                                ProdBomLine."Line No." := LineNo;
                                ProdBomLine.Type := ProdBomLine.Type::Item;
                                ProdBomLine.Validate("No.", JobPlanningLine."No.");
                                ProdBomLine.Description := JobPlanningLine.Description;
                                ProdBomLine.Validate("Quantity per", JobPlanningLine.Quantity);
                                ProdBomLine.Validate("Unit of Measure Code", JobPlanningLine."Unit of Measure Code");
                                ProdBomLine.insert;
                            end;
                        until JobPlanningLine.next = 0;
                end;
            }
        }
    }

    var
        myInt: Integer;
}