pageextension 50030 SalesListEXT extends "Sales Quotes"
{
    Caption = 'Proposal';
    layout
    {
        // Add changes to page layout here
        modify("No.")
        {
            StyleExpr = StyleTextL;
        }

    }

    actions
    {
        modify("Co&mments")
        {
            Caption = 'Terms & Condition';
        }

    }
    procedure StyleExpChange(): Text
    begin
        if "Job No." <> '' then
            exit('')
        else
            exit('Unfavorable');
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTextL := StyleExpChange();
    end;

    var
        StyleTextL: Text;
}
