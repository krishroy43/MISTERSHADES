page 50556 "Product Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Product Type";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Fabric Type"; "Fabric Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Select; Select)
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
        CodeValG: Code[250];

    trigger
    OnOpenPage()
    var
        FbRecL: Record "Product Type";
    begin
        if CodeValG <> '' then begin
            FbRecL.Reset();
            FbRecL.SetFilter(Code, CodeValG);
            IF FbRecL.FindSet() then
                repeat
                    FbRecL.validate(Select, true);
                    FbRecL.Modify();
                until FbRecL.Next() = 0;
            FbRecL.Reset();
        end;
    end;

    procedure SetVal(Code: Code[250])
    begin
        CodeValG := Code;
    end;


}