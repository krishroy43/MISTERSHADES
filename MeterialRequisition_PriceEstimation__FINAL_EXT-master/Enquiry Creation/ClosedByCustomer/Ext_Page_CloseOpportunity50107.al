pageextension 50070 CloseOpportunityExtends extends "Close Opportunity"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here


    }


    var
        myInt: Integer;

        // trigger OnQueryClosePage(CloseAction: Action): Boolean;
        // begin

        //     IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
        //         CheckStatus_Cust;
        //         FinishWizard_CUS;
        //     END;
        // end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // IF (CurrPage.RUNMODAL = ACTION::OK) THEN BEGIN
        //     Validate("Updated By", UserId);
        //     Modify();
        // end;
    end;
}