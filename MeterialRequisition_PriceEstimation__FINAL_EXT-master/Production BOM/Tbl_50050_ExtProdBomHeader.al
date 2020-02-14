tableextension 50001 "Ext. Production BOM Header" extends "Production BOM Header"
{
    fields
    {
        field(50000; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = job;
            //Editable = false;
            trigger
            OnValidate()
            var
                ProdBOMLine: Record "Production BOM Line";
            begin

                if "Job No." <> xRec."Job No." then begin
                    ProdBOMLine.reset;
                    ProdBOMLine.SetRange("Production BOM No.", Rec."No.");
                    if ProdBOMLine.FindFirst then
                        Error('Can not update Job No. as BOM Line exists');

                    Clear("Drawing No.");
                end;


            end;

        }
        field(50001; "Drawing No."; text[250])
        {
            DataClassification = ToBeClassified;
            //Lookup = True;
            //Editable = false;
            //TableRelation = "Job Planning Line"."Drawing No." where("Job No." = field("Job No."));
            trigger OnLookup()
            Var
                JobPlanningLines: Record "Job Planning Line";
            begin
                JobPlanningLines.reset;
                JobPlanningLines.SetRange("Job No.", rec."Job No.");
                if JobPlanningLines.findfirst then;

                if page.RunModal(Page::"Job Planning Lines", JobPlanningLines) = Action::LookupOK then begin
                    validate("Drawing No.", JobPlanningLines."Drawing No.");
                end;
            end;

            trigger OnValidate()
            Var
                ProdBOMLine: Record "Production BOM Line";
            begin
                ProdBOMLine.reset;
                ProdBOMLine.SetRange("Production BOM No.", Rec."No.");
                if ProdBOMLine.FindFirst then
                    Error('Can not update Job No. as BOM Line exists');
            end;

        }
    }
}