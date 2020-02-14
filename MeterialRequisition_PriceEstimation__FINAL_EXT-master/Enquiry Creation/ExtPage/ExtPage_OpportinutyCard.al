pageextension 50003 "Ext. Opportunity" extends "Opportunity Card"
{
    Caption = 'Sales Enquiry';
    layout
    {
        addafter(Description)
        {
            field("MSME Type"; "Lead Type")
            {
                ApplicationArea = All;
                Editable = AllContrlEnableBool;
                trigger
                OnValidate();
                begin
                    if "Lead Type" = "Lead Type"::Customer then begin
                        EditiableCustomerBoolG := true;
                        EditiableContactBoolG := false

                    end
                    else
                        if "Lead Type" = "Lead Type"::Contact then begin
                            EditiableContactBoolG := true;
                            EditiableCustomerBoolG := false

                        end
                        else begin
                            EditiableCustomerBoolG := false;
                            EditiableContactBoolG := false;
                        end;

                end;
            }

            field("Source of Enquiry"; "Source of Enquiry")
            {
                ApplicationArea = All;
                Editable = AllContrlEnableBool;
            }
            field("MSME Status"; "MSME Status")
            {
                ApplicationArea = All;
                Caption = 'Enquiry Status';
                // Editable = AllContrlEnableBool;
            }

            field("Enquiry Type"; "Enquiry Type")
            {
                ApplicationArea = All;
                Editable = AllContrlEnableBool;
                Caption = 'Enquiry Type';
                trigger
                OnValidate()
                begin
                    ExtOpptLstPgeG.UpdateDayConversionProposalStyle(Rec."No.");
                    //CurrPage.Update();

                end;
            }
            field(Remarks; Remarks)
            {
                ApplicationArea = All;
                Editable = AllContrlEnableBool;
            }


        }

        //  movebefore("Contact No."; "Contact Name")
        addbefore("Salesperson Code")
        {

            field("Customer No."; "Customer No.")
            {
                ApplicationArea = All;
                Enabled = EditiableCustomerBoolG;
            }
            field("Customer Name"; "Customer Name")
            {
                ApplicationArea = All;
            }

        }
        addbefore("Contact Company Name")
        {
            field("Contact Company No."; "Contact Company No.")
            {
                ApplicationArea = All;
                Editable = AllContrlEnableBool;
                Visible = false;
                trigger
                OnValidate()
                var
                    ContactL: Record Contact;
                begin
                    if "Contact Company No." <> Xrec."Contact Company No." then
                        Clear("Contact Company Name");
                    ContactL.Reset();
                    if ContactL.get("Contact Company No.") then
                        "Contact Company Name" := ContactL.Name;

                end;

            }
        }


        addafter("Segment No.")
        {
            field("Salesperson Name"; "Salesperson Name")
            {
                ApplicationArea = All;
                Caption = 'Account Holder';
                Editable = true;
            }
        }
        /*
            Start Modify Control on page level
        */
        modify("Contact No.")
        {
            ApplicationArea = All;
            Enabled = EditiableContactBoolG;
        }

        modify(Description)
        {
            ApplicationArea = All;
            Editable = AllContrlEnableBool;
            Caption = 'Scope Of Work';
        }
        addbefore("Sales Document Type")
        {
            field("Scope of Work 2"; "Scope of Work 2")
            {
                ApplicationArea = All;
            }
        }
        modify("Campaign No.")
        {
            ApplicationArea = All;
            Editable = false;
            Visible = false;
        }
        modify("Segment No.")
        {
            ApplicationArea = All;
            Editable = false;
            Visible = false;
        }
        modify("Contact Company Name")
        {
            Visible = false;
            ApplicationArea = All;
        }

        //Stop Modify Control on page level
        // Star tNew Group/ Tab is creatded for MSME CR
        addafter(General)
        {
            // Start Document and Approvals
            group("Document and Approvals")
            {

                field("Person in charge"; "Person in charge")
                {
                    ApplicationArea = All;
                    Editable = AllContrlEnableBool;
                }
                field("Necessary documents"; "Necessary documents")
                {
                    ApplicationArea = All;
                    Editable = AllContrlEnableBool;
                }
                field(Initiatives; Initiatives)
                {
                    ApplicationArea = All;
                    Editable = AllContrlEnableBool;
                }
                field("Authority Required"; "Authority Required")
                {
                    ApplicationArea = All;
                    Editable = AllContrlEnableBool;
                    // Start 01-07-2019
                    Caption = 'Approval required';
                    // Stop 01-07-2019
                    trigger
                    OnValidate()
                    begin
                        if "Authority Required" then
                            AuthoBoolG := true
                        else begin
                            Clear(Authorities);
                            AuthoBoolG := false;

                        end;
                    end;
                }
                field(Authorities; Authorities)
                {
                    ApplicationArea = All;
                    Editable = AuthoBoolG;
                }

                field("Date of Conversion in Proposal"; "Date of Conversion in Proposal")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprBoolG;
                    Style = Unfavorable;
                    // Caption = 'Proposal conversion Date';
                    Caption = 'Quotation Due Date';


                }
                field("Date for Submitting the Quotation"; "Date for Submit Quotation")
                {
                    ApplicationArea = All;
                    //Editable = AllContrlEnableBool;
                    Editable = false;
                    //Caption = 'Quotation Submition Date';
                    Caption = ' Quotation Generation Date';
                }
                field("Enquiry Registered by"; "Enquiry Registered by")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Follow-up By"; "Follow-up By")
                {
                    ApplicationArea = All;
                    // Editable = AllContrlEnableBool;
                }
                field("Follow-up Date/Time"; "Follow-up Date/Time")
                {
                    ApplicationArea = All;
                }


            }
            // Stop Document and Approvals
            // Start Technical specification
            group("Technical specification")
            {
                field("Product Type"; "Product Type")
                {
                    ApplicationArea = All;
                    Editable = AllContrlEnableBool;

                }
                // Start 27-06-2019
                field("Fabric Type"; "Fabric Type")
                {
                    ApplicationArea = All;
                    Editable = AllContrlEnableBool;

                }
                // Start 27-06-2019
                field("Project Location"; "Project Location")
                {
                    ApplicationArea = All;
                    Editable = AllContrlEnableBool;
                }

                field("Technical Specifications"; "Technical Specification")
                {
                    ApplicationArea = All;
                    // Editable = AllContrlEnableBool;
                }
                field("Customer Drawing Details"; "Drawing Details")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Drawing Details';
                    //Editable = AllContrlEnableBool;
                }
                field("Design Input required"; "Design Input required")
                {
                    ApplicationArea = All;
                    Editable = AllContrlEnableBool;
                }
                field("Sample requested"; "Sample requested")
                {
                    ApplicationArea = All;
                    Editable = AllContrlEnableBool;
                }

            }
            // Stop Technical specification

        }


        moveafter("Salesperson Code"; Description)
        //moveafter("Customer No."; "Contact No.")
        /*
            Star tNew Group/ Tab is creatded for MSME CR
        */










    }

    actions
    {
        addafter(Update)
        {
            action(CloseCustomer)
            {
                ApplicationArea = All;
                Caption = 'Close By Cusotmer';
                Image = Closed;
                Visible = ClosedByCustBoolG;
                trigger OnAction();
                begin
                    CloseOpportunity_CUS;
                end;
            }
        }


        modify("Activate the First Stage")
        {
            trigger
            OnBeforeAction()
            begin
                // Start 27-06-2019 
                "MSME Status" := "MSME Status"::"Under Progress";
                Modify();
                // Stop 27-06-2019
            end;

            trigger
            OnAfterAction()
            var
                OppEntryRecL: Record "Opportunity Entry";
            begin
                System.Sleep(100);
                Commit();
                OppEntryRecL.Reset();
                OppEntryRecL.SetRange("Opportunity No.", "No.");
                if OppEntryRecL.FindFirst() then begin
                    OppEntryRecL.LeadType := "Lead Type";
                    OppEntryRecL.CustomerNo := "Customer No.";
                    OppEntryRecL.Modify();
                end;
            end;
        }
        addafter(ActionGroupCRM)
        {
            action("Open Opportunity type")
            {
                Image = TaskPage;
                ApplicationArea = All;
                RunObject = page "Enquiry Type";
            }
            action("Open Product Type")
            {
                Image = TaskPage;
                ApplicationArea = All;
                RunObject = page "Product Type";
            }
            // Start 27-06-2019
            action("Attachment")
            {
                ApplicationArea = All;
                Image = Attachments;
                Promoted = true;
                Caption = 'Attachment';
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                trigger
                OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GETTABLE(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RUNMODAL;
                end;
            }
            // Stop 27-06-2019
        }
        addafter(CreateSalesQuote)
        {
            action("Create Sales Quote ")
            {
                ApplicationArea = All;
                Image = Allocate;
                Visible = CreateSalesQuoteBool2;
                trigger
                OnAction()
                begin
                    CreateQuoteForCustomer();
                    // Start 08-09-2019
                    "Date for Submit Quotation" := Today();
                    // Stop 08-09-2019
                end;
            }
        }


        modify(CreateSalesQuote)
        {
            Visible = CreateSalesQuoteBool;
            // Start 15-07-2019
            trigger
            OnBeforeAction()
            var
                ContactRecL: Record Contact;
                BusinessRelationContactRecL: Record "Contact Business Relation";
            begin
                ContactRecL.Reset();
                if ContactRecL.Get("Contact No.") then begin
                    ContactRecL.TestField("Company No.");
                    BusinessRelationContactRecL.Reset();
                    BusinessRelationContactRecL.SetRange("Contact No.", ContactRecL."Company No.");
                    BusinessRelationContactRecL.SetRange("Business Relation Code", 'CUST');
                    BusinessRelationContactRecL.SetRange("Link to Table", BusinessRelationContactRecL."Link to Table"::Customer);
                    if BusinessRelationContactRecL.FindFirst() then
                        if BusinessRelationContactRecL."No." = '' then
                            Error('Please Specify Customer Against this Contact %1 ,Before create Sales Quote ', ContactRecL."No.");
                end;
                // Start 08-09-2019
                "Date for Submit Quotation" := Today();
                // Stop 08-09-2019
            end;

            trigger
           OnAfterAction()
            var
                SalesHeader: Record "Sales Header";
            begin
                if SalesHeader.GET(SalesHeader."Document Type"::Quote, "Sales Document No.") then begin
                    SalesHeader."Product Type" := "Product Type";
                    SalesHeader."Location Details" := "Project Location";
                    SalesHeader."Scope Of Work 1" := Description;
                    SalesHeader."Scope Of Work 2" := "Scope Of Work 2";
                    SalesHeader.Modify();
                end;


            end;
            // Stop 15-07-2019

        }
        modify(CloseOpportunity)
        {
            Caption = 'Close By Contact';
        }

    }
    var
        EditiableCustomerBoolG: Boolean;
        EditiableContactBoolG: Boolean;
        AuthoBoolG: Boolean;
        StyleExprBoolG: Boolean;
        StyleVarG: Integer;
        ExtOpptLstPgeG: Page "Opportunity List";
        AllContrlEnableBool: Boolean;
        Opprtniy: Record Opportunity;
        CreateSalesQuoteBool: Boolean;
        CreateSalesQuoteBool2: Boolean;
        ClosedByCustBoolG: Boolean;
        ClosedByContBoolG: Boolean;

    trigger
    OnOpenPage();
    begin
        Opprtniy.OnModifyRecords(Rec);
        EditiableCustomerBoolG := false;
        EditiableContactBoolG := false;
        AllContrlEnableBool := false;

        CreateSalesQuoteBool2 := false;
        CreateSalesQuoteBool := false;
        //"Enquiry Registered by" := UserId;
        //"Follow-up Date/Time" := CurrentDateTime;
        NonEditableControl;
        CheckOnceAgainLeadType;

        if not "Authority Required" then
            AuthoBoolG := false;
        if "Lead Type" = "Lead Type"::Contact then begin
            ClosedByContBoolG := true;
            ClosedByCustBoolG := false;
        end else begin
            ClosedByContBoolG := false;
            ClosedByCustBoolG := true;
        end;





    end;

    procedure NonEditableControl()
    begin
        if (Status = Status::Won) OR (Status = Status::Lost) OR (NOT (Status = Status::"Not Started")) then begin
            AuthoBoolG := false;
            AllContrlEnableBool := false;
        end
        else begin
            AuthoBoolG := true;
            AllContrlEnableBool := true;
        end
    end;

    procedure CheckOnceAgainLeadType()
    begin
        if "Lead Type" = "Lead Type"::Customer then begin
            EditiableCustomerBoolG := true;
            EditiableContactBoolG := false

        end
        else
            if "Lead Type" = "Lead Type"::Contact then begin
                EditiableContactBoolG := true;
                EditiableCustomerBoolG := false

            end
            else begin
                EditiableCustomerBoolG := false;
                EditiableContactBoolG := false;
            end;
    end;

    trigger
    OnAfterGetRecord()
    begin
        if "Lead Type" = "Lead Type"::Contact then begin
            CreateSalesQuoteBool := true;
            CreateSalesQuoteBool2 := false;
        end
        else begin
            CreateSalesQuoteBool2 := true;
            CreateSalesQuoteBool := false;
        end;
    end;

    trigger
    OnModifyRecord(): Boolean
    begin

        if Status = Status::Lost then begin
            "MSME Status" := "MSME Status"::Regret;
            Modify();
            Message('on val status');
            Commit();

        end;
        // Start 14-09-2019
        if ("Contact No." <> '') and ("Contact Name" <> '') then
            "Lead Type" := "Lead Type"::Contact;
        // Stop 14-09-2019

    end;

    trigger
    OnAfterGetCurrRecord()
    begin
        if Status = Status::Lost then begin
            "MSME Status" := "MSME Status"::Regret;
            Modify();
            //Message('on val status');
            //Commit();

        end;
        // Start 14-09-2019
        if ("Contact No." <> '') and ("Contact Name" <> '') then
            "Lead Type" := "Lead Type"::Contact;
        // Stop 14-09-2019

    end;


}

