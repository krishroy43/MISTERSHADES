pageextension 50021 "Ext. Opportunity Entries" extends "Opportunity Entries"
{
    Caption = 'Sales Enquiry Entries';


    trigger
   OnOpenPage()
    begin
        CurrPage.Caption('Sales Enquiry Entries');
    end;

    var

}