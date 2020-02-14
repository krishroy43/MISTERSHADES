page 50190 "Purchase Enq. Comment Sheet"
{
    PageType = List;
    //  ApplicationArea = All;
    //  UsageCategory = Administration;
    SourceTable = "Purchase Enq. Comment Line";
    DataCaptionFields = "Document Type", "No.";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("Term/Condition"; "Term/Condition")
                {
                    ApplicationArea = All;
                    trigger
                    OnValidate()
                    begin
                        Date := Today;
                    end;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
                field(code; code)
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
            /*  action(ActionName)
              {
                  ApplicationArea = All;

                  trigger OnAction()
                  begin

                  end;
              }*/
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        SetUpNewLine;
    end;

    var
        myInt: Integer;



}