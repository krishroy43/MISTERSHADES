pageextension 50068 "Ext. Sales List" extends "Sales List"
{
    var
        SelectionFilterManagement: Codeunit SelectionFilterManagement_1;
        SalesHeaderRecG: Record "Sales Header";

    procedure GetSelectionFilter(): Text
    begin
        CurrPage.SETSELECTIONFILTER(SalesHeaderRecG);
        EXIT(SelectionFilterManagement.GetSelectionFilterForSalesHeader(SalesHeaderRecG));
    end;
}