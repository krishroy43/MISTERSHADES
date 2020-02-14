page 50128 "Close Opportunity For Customer"
{
    // version NAVW113.00

    Caption = 'Close Opportunity';
    DataCaptionExpression = Caption;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Opportunity Entry";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(OptionWon; "Action Taken")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Opportunity Status';
                    ToolTip = 'Specifies the action that was taken when the entry was last updated. There are six options:';
                    ValuesAllowed = Won, Lost;

                    trigger OnValidate();
                    var
                        CloseOpportunityCode: Record "Close Opportunity Code";
                    begin
                        IF "Action Taken" = "Action Taken"::Lost THEN
                            LostActionTakenOnValidate;
                        IF "Action Taken" = "Action Taken"::Won THEN
                            WonActionTakenOnValidate;

                        CASE "Action Taken" OF
                            "Action Taken"::Won:
                                BEGIN
                                    CalcdCurrentValueLCYEnable := TRUE;
                                    IF Opp.GET("Opportunity No.") THEN
                                        SalesQuoteEnable := Opp."Sales Document No." <> '';
                                END;
                            "Action Taken"::Lost:
                                BEGIN
                                    CalcdCurrentValueLCYEnable := FALSE;
                                    SalesQuoteEnable := FALSE;
                                END;
                        END;

                        UpdateEstimates;
                        CASE "Action Taken" OF
                            "Action Taken"::Won:
                                BEGIN
                                    CloseOpportunityCode.SETRANGE(Type, CloseOpportunityCode.Type::Won);
                                    IF CloseOpportunityCode.COUNT = 1 THEN BEGIN
                                        CloseOpportunityCode.FINDFIRST;
                                        "Close Opportunity Code" := CloseOpportunityCode.Code;
                                    END;
                                END;
                            "Action Taken"::Lost:
                                BEGIN
                                    CloseOpportunityCode.SETRANGE(Type, CloseOpportunityCode.Type::Lost);
                                    IF CloseOpportunityCode.COUNT = 1 THEN BEGIN
                                        CloseOpportunityCode.FINDFIRST;
                                        "Close Opportunity Code" := CloseOpportunityCode.Code;
                                    END;
                                END;
                        END;
                    end;
                }
                field("Close Opportunity Code"; "Close Opportunity Code")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Close Opportunity Code';
                    ToolTip = 'Specifies the code for closing the opportunity.';
                }
                field("Date of Change"; "Date of Change")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Closing Date';
                    ToolTip = 'Specifies the date this opportunity entry was last changed.';
                }
                field("Calcd. Current Value (LCY)"; "Calcd. Current Value (LCY)")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Sales (LCY)';
                    Enabled = CalcdCurrentValueLCYEnable;
                    ToolTip = 'Specifies the calculated current value of the opportunity entry.';
                }
                field("Cancel Old To Do"; "Cancel Old To Do")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Cancel Old Tasks';
                    ToolTip = 'Specifies a task is to be cancelled from the opportunity.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Finish)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = '&Finish';
                Image = Approve;
                InFooterBar = true;
                Promoted = true;
                ToolTip = 'Finish closing the opportunity.';
                Visible = IsOnMobile;

                trigger OnAction();
                begin
                    CheckStatus;
                    //FinishWizard;
                    FinishWizard_CUS();
                    CurrPage.CLOSE;
                end;
            }
            action(SalesQuote)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Sales Quote';
                Enabled = SalesQuoteEnable;
                Image = Quote;
                InFooterBar = true;
                Promoted = true;
                ToolTip = 'Create a sales quote based on the opportunity.';

                trigger OnAction();
                var
                    SalesHeader: Record "Sales Header";
                begin
                    IF Opp.GET("Opportunity No.") THEN BEGIN
                        Opp.ShowQuote;
                        IF SalesHeader.GET(SalesHeader."Document Type"::Quote, Opp."Sales Document No.") THEN BEGIN
                            "Calcd. Current Value (LCY)" := GetSalesDocValue(SalesHeader);
                            CurrPage.UPDATE;
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnInit();
    begin
        OptionLostEnable := TRUE;
        OptionWonEnable := TRUE;
        SalesQuoteEnable := TRUE;
        CalcdCurrentValueLCYEnable := TRUE;
    end;

    trigger OnOpenPage();
    begin
        UpdateEditable;
        "Cancel Old To Do" := TRUE;
        //IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        //IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
        //CheckStatus;
        //FinishWizard;
        //END;
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
            CheckStatus_Cust;
            FinishWizard_CUS;
            Validate("Updated By", UserId);
            // 13-09-2019 
            // Below code commented due to error on sandbox
            ///  Modify();

        END;
    end;

    var
        Text000: Label 'untitled';
        Cont: Record "Contact";
        Opp: Record "Opportunity";
        //ClientTypeManagement: Codeunit "ClientTypeManagement";
        [InDataSet]
        CalcdCurrentValueLCYEnable: Boolean;
        [InDataSet]
        SalesQuoteEnable: Boolean;
        [InDataSet]
        OptionWonEnable: Boolean;
        [InDataSet]
        OptionLostEnable: Boolean;
        IsNotAValidSelectionErr: Label '%1 is not a valid selection.', Comment = '%1 - Field Value';
        IsOnMobile: Boolean;

    local procedure Caption(): Text[260];
    var
        CaptionStr: Text[260];
    begin
        IF Cont.GET("Contact Company No.") THEN
            CaptionStr := COPYSTR(Cont."No." + ' ' + Cont.Name, 1, MAXSTRLEN(CaptionStr));
        IF Cont.GET("Contact No.") THEN
            CaptionStr := COPYSTR(CaptionStr + ' ' + Cont."No." + ' ' + Cont.Name, 1, MAXSTRLEN(CaptionStr));
        IF CaptionStr = '' THEN
            CaptionStr := Text000;

        EXIT(CaptionStr);
    end;

    local procedure UpdateEditable();
    begin
        IF GETFILTER("Action Taken") <> '' THEN BEGIN
            OptionWonEnable := FALSE;
            OptionLostEnable := FALSE;
        END;
    end;

    local procedure WonActionTakenOnValidate();
    begin
        IF NOT OptionWonEnable THEN
            ERROR(IsNotAValidSelectionErr, "Action Taken");
    end;

    local procedure LostActionTakenOnValidate();
    begin
        IF NOT OptionLostEnable THEN
            ERROR(IsNotAValidSelectionErr, "Action Taken");
    end;


}

