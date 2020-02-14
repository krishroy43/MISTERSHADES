page 50032 "Sales Enquiry List"
{


    Caption = 'Sales Enquiry';
    CardPageID = "Opportunity Card";
    // DataCaptionExpression = Caption;
    Editable = false;
    PageType = List;
    SourceTable = Opportunity;
    ApplicationArea = All;

    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(groups)
            {
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Contact Name"; "Contact Name")
                {

                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                }
                field("Days of Conversion in Proposal"; "Date of Conversion in Proposal")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    Caption = 'Proposal conversion Date';
                }
                field("Enquiry Registered by"; "Enquiry Registered by")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                }

                field(Closed; Closed)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies that the opportunity is closed.';
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the date that the opportunity was created.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the description of the opportunity.';
                }
                field("Contact No."; "Contact No.")
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the number of the contact that this opportunity is linked to.';
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                }
                field("Contact Company No."; "Contact Company No.")
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the number of the company that is linked to this opportunity.';
                    Visible = false;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = Advanced;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the code of the salesperson that is responsible for the opportunity.';
                }
                field(Status; Status)
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the status of the opportunity. There are four options:';
                }
                field("Sales Cycle Code"; "Sales Cycle Code")
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the code of the sales cycle that the opportunity is linked to.';
                    Visible = false;
                }
                field(CurrSalesCycleStage; CurrSalesCycleStage)
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    Caption = 'Current Sales Cycle Stage';
                    ToolTip = 'Specifies the current sales cycle stage of the opportunity.';
                }
                field("Campaign No."; "Campaign No.")
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the number of the campaign to which this opportunity is linked.';
                }
                field("Campaign Description"; "Campaign Description")
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    DrillDown = false;
                    ToolTip = 'Specifies the description of the campaign to which the opportunity is linked. The program automatically fills in this field when you have entered a number in the Campaign No. field.';
                }
                field("Sales Document Type"; "Sales Document Type")
                {
                    ApplicationArea = Advanced;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the type of the sales document (Quote, Order, Posted Invoice). The combination of Sales Document No. and Sales Document Type specifies which sales document is assigned to the opportunity.';
                }
                field("Sales Document No."; "Sales Document No.")
                {
                    ApplicationArea = Advanced;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the number of the sales document that has been created for this opportunity.';
                }
                field("Estimated Closing Date"; "Estimated Closing Date")
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the estimated closing date of the opportunity.';
                }
                field("Estimated Value (LCY)"; "Estimated Value (LCY)")
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the estimated value of the opportunity.';
                }
                field("Calcd. Current Value (LCY)"; "Calcd. Current Value (LCY)")
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    ToolTip = 'Specifies the current calculated value of the opportunity.';
                }



            }
            group(Name)
            {
                // // // field("Contact Name"; "Contact Name")
                // // // {
                // // //     ApplicationArea = RelationshipMgmt;
                // // //     StyleExpr = StyleExprBoolG;
                // // //     Style = Unfavorable;
                // // //     Caption = 'Contact Name';
                // // //     DrillDown = false;
                // // //     ToolTip = 'Specifies the name of the contact to which this opportunity is linked. The program automatically fills in this field when you have entered a number in the No. field.';
                // // // }
                field("Contact Company Name"; "Contact Company Name")
                {
                    ApplicationArea = RelationshipMgmt;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    DrillDown = false;
                    ToolTip = 'Specifies the name of the company of the contact person to which this opportunity is linked. The program automatically fills in this field when you have entered a number in the Contact Company No. field.';
                }
            }// till here
        }
        area(factboxes)
        {
            /// part(; 5174)
            // {
            // ApplicationArea = RelationshipMgmt;
            // SubPageLink = "No." = FIELD ("No.");
            // }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Opportunity)
            {
                Caption = 'Oppo&rtunity';
                Image = Opportunity;
                action(Statistics)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5127;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Interaction Log E&ntries")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    RunObject = Page 5076;
                    RunPageLink = "Opportunity No." = FIELD("No.");
                    RunPageView = SORTING("Opportunity No.", Date);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View a list of the interactions that you have logged, for example, when you create an interaction, print a cover sheet, a sales order, and so on.';
                }
                action("Postponed &Interactions")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Postponed &Interactions';
                    Image = PostponedInteractions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 5082;
                    RunPageLink = "Opportunity No." = FIELD("No.");
                    RunPageView = SORTING("Opportunity No.", Date);
                    Scope = Repeater;
                    ToolTip = 'View postponed interactions for opportunities.';
                }
                action("T&asks")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'T&asks';
                    Image = TaskList;
                    RunObject = Page "Task List";
                    RunPageLink = "Opportunity No." = FIELD("No."), "System To-do Type" = FILTER(Organizer);
                    RunPageView = SORTING("Opportunity No.");
                    ToolTip = '"View all marketing tasks that involve the opportunity. "';
                }
                action("Co&mments")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Rlshp. Mgt. Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Opportunity),
                                  "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action("Show Sales Quote")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Show Sales Quote';
                    Image = Quote;
                    Promoted = true;
                    PromotedCategory = Process;
                    Scope = Repeater;
                    ToolTip = 'Show the assigned sales quote.';

                    trigger OnAction();
                    begin
                        ShowSalesQuoteWithCheck;
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics 365 for Sales';
                Visible = CRMIntegrationEnabled;
                action(CRMGotoOpportunity)
                {
                    ApplicationArea = Suite;
                    Caption = 'Opportunity';
                    Image = CoupledContactPerson;
                    ToolTip = 'Open the coupled Dynamics 365 for Sales opportunity.';

                    trigger OnAction();
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(RECORDID);
                    end;
                }
                action(CRMSynchronizeNow)
                {
                    AccessByPermission = TableData "CRM Integration Record" = IM;
                    ApplicationArea = Suite;
                    Caption = 'Synchronize';
                    Image = Refresh;
                    ToolTip = 'Send or get updated data to or from Dynamics 365 for Sales.';

                    trigger OnAction();
                    var
                        Opportunity: Record "Opportunity";
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        OpportunityRecordRef: RecordRef;
                    begin
                        CurrPage.SETSELECTIONFILTER(Opportunity);
                        Opportunity.NEXT;

                        IF Opportunity.COUNT = 1 THEN
                            CRMIntegrationManagement.UpdateOneNow(Opportunity.RECORDID)
                        ELSE BEGIN
                            OpportunityRecordRef.GETTABLE(Opportunity);
                            CRMIntegrationManagement.UpdateMultipleNow(OpportunityRecordRef);
                        END
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling', Comment = 'Coupling is a noun';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Dynamics 365 for Sales record.';
                    action(ManageCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        ApplicationArea = Suite;
                        Caption = 'Set Up Coupling';
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Dynamics 365 for Sales opportunity.';

                        trigger OnAction();
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(RECORDID);
                        end;
                    }
                    action(DeleteCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        ApplicationArea = Suite;
                        Caption = 'Delete Coupling';
                        Enabled = CRMIsCoupledToRecord;
                        Image = UnLinkAccount;
                        ToolTip = 'Delete the coupling to a Dynamics 365 for Sales opportunity.';

                        trigger OnAction();
                        var
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        begin
                            CRMCouplingManagement.RemoveCoupling(RECORDID);
                        end;
                    }
                }
                action(ShowLog)
                {
                    ApplicationArea = Suite;
                    Caption = 'Synchronization Log';
                    Image = Log;
                    ToolTip = 'View integration synchronization jobs for the opportunity table.';

                    trigger OnAction();
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowLog(RECORDID);
                    end;
                }
            }
        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Update)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Update';
                    Enabled = OppInProgress;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Update all the actions that are related to your opportunities.';

                    trigger OnAction();
                    begin
                        UpdateOpportunity;
                    end;
                }
                action(Close)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Close';
                    Enabled = OppNotStarted OR OppInProgress;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Close all the actions that are related to your opportunities.';

                    trigger OnAction();
                    begin
                        CloseOpportunity;
                    end;
                }
                action("Activate First Stage")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Activate First Stage';
                    Enabled = OppNotStarted;
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Scope = Repeater;
                    ToolTip = 'Specify if the opportunity is to be activated. The status is set to In Progress.';

                    trigger OnAction();
                    begin
                        //StartActivateFirstStage;
                        StartActivateFirstStage_Cust;
                    end;
                }
                /* action(AssignSalesQuote)
                 {
                     ApplicationArea = RelationshipMgmt;
                     Caption = 'Assign Sales &Quote';
                     Enabled = OppInProgress;
                     Image = Allocate;
                     Promoted = true;
                     PromotedCategory = Process;
                     PromotedIsBig = true;
                     Scope = Repeater;
                     ToolTip = 'Assign a sales quote to an opportunity.';

                     trigger OnAction();
                     begin
                         // AssignQuote;
                     end;
                 }*/
                action("Print Details")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Print Details';
                    Image = Print;
                    ToolTip = 'View information about your sales stages, activities and planned tasks for an opportunity.';

                    trigger OnAction();
                    var
                        Opp: Record "Opportunity";
                    begin
                        Opp := Rec;
                        Opp.SETRECFILTER;
                        REPORT.RUN(REPORT::"Opportunity - Details", TRUE, FALSE, Opp);
                    end;
                }
                action("Create &Interaction")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Create &Interaction';
                    Image = CreateInteraction;
                    Promoted = true;
                    PromotedCategory = Process;
                    Scope = Repeater;
                    ToolTip = 'Create an interaction with a specified opportunity.';

                    trigger OnAction();
                    var
                        TempSegmentLine: Record "Segment Line" temporary;
                    begin
                        TempSegmentLine.CreateInteractionFromOpp(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        CALCFIELDS("Contact Name", "Contact Company Name");
        OppNotStarted := Status = Status::"Not Started";
        OppInProgress := Status = Status::"In Progress";
    end;

    trigger OnAfterGetRecord();
    var
        SalesCycleStage: Record "Sales Cycle Stage";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        CALCFIELDS("Current Sales Cycle Stage");
        CurrSalesCycleStage := '';
        IF SalesCycleStage.GET("Sales Cycle Code", "Current Sales Cycle Stage") THEN
            CurrSalesCycleStage := SalesCycleStage.Description;

        IF CRMIntegrationEnabled THEN
            CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);

        UpdateDayConversionProposalStyle("No.");
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    var
        RecordsFound: Boolean;
    begin
        RecordsFound := FIND(Which);
        EXIT(RecordsFound);
    end;

    trigger OnOpenPage();
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        CurrPage.EDITABLE := TRUE;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    end;

    var
        Text001: Label 'untitled';
        OppNotStarted: Boolean;
        OppInProgress: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        CurrSalesCycleStage: Text;
        StyleExprBoolG: Boolean;
        StyleVarG: Integer;

    local procedure Caption(): Text[260];
    var
        CaptionStr: Text[260];
    begin
        CASE TRUE OF
            BuildCaptionContact(CaptionStr, GETFILTER("Contact Company No.")),
          BuildCaptionContact(CaptionStr, GETFILTER("Contact No.")),
          BuildCaptionSalespersonPurchaser(CaptionStr, GETFILTER("Salesperson Code")),
          BuildCaptionCampaign(CaptionStr, GETFILTER("Campaign No.")),
          BuildCaptionSegmentHeader(CaptionStr, GETFILTER("Segment No.")):
                EXIT(CaptionStr)
        END;

        EXIT(Text001);
    end;

    local procedure BuildCaptionContact(var CaptionText: Text[260]; "Filter": Text): Boolean;
    var
        Contact: Record "Contact";
    begin
        WITH Contact DO
            EXIT(BuildCaption(CaptionText, Contact, Filter, FIELDNO("No."), FIELDNO(Name)));
    end;

    local procedure BuildCaptionSalespersonPurchaser(var CaptionText: Text[260]; "Filter": Text): Boolean;
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        WITH SalespersonPurchaser DO
            EXIT(BuildCaption(CaptionText, SalespersonPurchaser, Filter, FIELDNO(Code), FIELDNO(Name)));
    end;

    local procedure BuildCaptionCampaign(var CaptionText: Text[260]; "Filter": Text): Boolean;
    var
        Campaign: Record "Campaign";
    begin
        WITH Campaign DO
            EXIT(BuildCaption(CaptionText, Campaign, Filter, FIELDNO("No."), FIELDNO(Description)));
    end;

    local procedure BuildCaptionSegmentHeader(var CaptionText: Text[260]; "Filter": Text): Boolean;
    var
        SegmentHeader: Record "Segment Header";
    begin
        WITH SegmentHeader DO
            EXIT(BuildCaption(CaptionText, SegmentHeader, Filter, FIELDNO("No."), FIELDNO(Description)));
    end;

    local procedure BuildCaption(var CaptionText: Text[260]; RecVar: Variant; "Filter": Text; IndexFieldNo: Integer; TextFieldNo: Integer): Boolean;
    var
        RecRef: RecordRef;
        IndexFieldRef: FieldRef;
        TextFieldRef: FieldRef;
    begin
        Filter := DELCHR(Filter, '<>', '''');
        IF Filter <> '' THEN BEGIN
            RecRef.GETTABLE(RecVar);
            IndexFieldRef := RecRef.FIELD(IndexFieldNo);
            IndexFieldRef.SETRANGE(Filter);
            IF RecRef.FINDFIRST THEN BEGIN
                TextFieldRef := RecRef.FIELD(TextFieldNo);
                CaptionText := COPYSTR(FORMAT(IndexFieldRef.VALUE) + ' ' + FORMAT(TextFieldRef.VALUE), 1, MAXSTRLEN(CaptionText));
            END;
        END;

        EXIT(Filter <> '');
    end;

    procedure UpdateDayConversionProposalStyle(OpprNo: Code[30])
    var
        OpportunityRecL: Record Opportunity;
        SalesQuoteRecL: Record "Sales Header";
    begin

        OpportunityRecL.Reset();
        if OpportunityRecL.Get(OpprNo) then
            if (OpportunityRecL."Date of Conversion in Proposal" <= Today())
           AND (NOT ((Status = Status::Lost) OR (Status = Status::Won))) AND ("Date of Conversion in Proposal" <> 0D) then
                StyleExprBoolG := true
            else
                StyleExprBoolG := false;

        // Start 07-09-2019
        SalesQuoteRecL.Reset();
        SalesQuoteRecL.SetRange("Opportunity No.", OpprNo);
        SalesQuoteRecL.SetRange(Status, SalesQuoteRecL.Status::Released);
        if SalesQuoteRecL.FindFirst() then
            StyleExprBoolG := false

        // Stop 07-09-2019
    end;
}

