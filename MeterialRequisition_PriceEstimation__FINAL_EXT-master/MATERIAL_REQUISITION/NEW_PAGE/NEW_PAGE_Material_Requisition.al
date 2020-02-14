page 50005 "Material Requisition"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Material Requisition Header";
    //Caption = 'Material Req. Card';
    Caption = 'Requisition Order Card';
    LinksAllowed = true;

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("Requisition No."; "Requisition No.")
                {
                    ApplicationArea = All;
                    //Editable = EditableFalseTrueAllControl;
                    Editable = false;

                }
                field("Req. Creation Date"; "Req. Creation Date")
                {
                    ApplicationArea = All;
                    Caption = 'Requsition Creation Date';
                    Editable = false;

                }
                field("Enquiry Type"; "Enquiry Type")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;

                }
                field("Date of Requisition"; "Date of Requisition")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;


                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;

                }
                field("Job task No."; "Job task No.")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;

                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;

                }
                field("Expected receipt date"; "Expected receipt date")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;

                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;

                }
                field("Supplier’s name"; "Supplier name 2")
                {
                    ApplicationArea = All;
                    //Caption = 'Supplier name';
                    Caption = ' Vendor No.';
                    Editable = EditableFalseTrueAllControl;

                }
                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;

                }
                field("Origin of Item"; "Origin of Item 2")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;


                }
                field("Project Code"; "Project Code")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;
                    Visible = false;

                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger
                    OnValidate()
                    var
                        MRSunform: Page "Material Requisition Subform";
                    begin
                        /*
                        if (Status = Status::Released) OR (Status = Status::"Pending Approval") then begin
                            MRSunform.Editable := false;
                            ReleasedBool := false
                        end
                        else begin
                            ReleasedBool := true;
                            MRSunform.Editable := true;
                        end;
                        */
                    end;


                }

            }

            part("Materail Requisition Subform"; "Material Requisition Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field ("Requisition No.");
                UpdatePropagation = Both;
                Enabled = "Requisition No." <> '';
                //Editable = subformEnableBoolG;
                //, "Job No." = field ("Job No."), "Job task No." = field ("Job task No.")
            }
        }
        area(FactBoxes)
        {

            systempart("Link"; Links)
            {
                ApplicationArea = All;
            }
            //systempart("Attachment";)

        }

    }

    actions
    {
        area(Processing)
        {

            action("Send Approval Request")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = SendApprovalRequest;

                trigger OnAction()
                begin
                    IF "Enquiry Type" = "Enquiry Type"::Project then
                        TestField("Job No.");
                    //TestField("Job task No.");
                    IntCU.OnSendMRforApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = CancelApprovalRequest;

                trigger OnAction()
                begin
                    IntCU.OnCancelMRforApproval(Rec);
                end;
            }
            ////// here



            /// till here
            action(Reopen)
            {
                Image = ReOpen;
                ApplicationArea = All;
                trigger
                OnAction()
                begin

                    IF Status = Status::"Pending Approval" THEN
                        ERROR('The approval process must be cancelled or completed to reopen this document.')
                    else begin
                        Status := Status::Open;
                        CurrPage.Editable(true);
                        subformEnableBoolG := true;
                        Modify();
                        CurrPage.Update();
                    end;
                    // IF Status = Status::Open THEN
                    //EXIT;

                end;

            }
            action(Approvals)
            {
                Image = Approvals;
                ApplicationArea = All;
                //RunObject = page "Material Requisition Approvals";
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    ApprovalEntry.SETFILTER("Table ID", '%1', DATABASE::"Material Requisition Header");
                    ApprovalEntry.SETFILTER("Record ID to Approve", '%1', Rec.RecordId);
                    ApprovalEntry.SETRANGE("Related to Change", FALSE);
                    PAGE.RUN(PAGE::"Material Requisition Approvals", ApprovalEntry);
                end;
            }
            action("Purchase Enquiry List")
            {
                Image = List;
                ApplicationArea = All;
                RunObject = page "Purch. Enquiry List";
                RunPageView = sorting ("No.");
                RunPageLink = "Requisition No." = field ("Requisition No.");
                /*
                trigger
                OnAction()
                var
                    PurchEnqryHeaderRecL: Record "Purch. Enquiry Header";
                    PurchEnqryListPageL: Page "Purch. Enquiry List";
                begin
                    PurchEnqryHeaderRecL.Reset();

                    PurchEnqryHeaderRecL.SetRange("Requisition No.", "Requisition No.");
                    if PurchEnqryHeaderRecL.FindSet() then begin
                        PurchEnqryListPageL.SetTableView(PurchEnqryHeaderRecL);
                        PurchEnqryListPageL.Run();
                    end;
                
                end;
                */
            }
            action("Attachment")
            {
                ApplicationArea = All;
                Image = Attachments;
                Promoted = true;
                Caption = 'Attachment';
                //PromotedCategory = Category8;
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
            action("Report")
            {
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger
                OnAction()
                var
                    MatReqHeaderRecL: Record "Material Requisition Header";
                    // MatReqReportL: Report "Material Requisition";
                begin
                    MatReqHeaderRecL.Reset();
                    CurrPage.SETSELECTIONFILTER(MatReqHeaderRecL);
                    if MatReqHeaderRecL.FindFirst() then
                        Report.Run(50004, true, true, MatReqHeaderRecL);



                end;

            }

        }
    }

    var
        TestPagee: Codeunit InitialiseAllCodeunit;
        TestPage1: Page "Dynamic Request Page Fields";
        TestPage2: Page WorkFLowEvents;
        Testpage3: Page WFResponses;
        IntCU: Codeunit IntiCodeunit;
        ApprovalEntry: Record "Approval Entry";
        subformEnableBoolG: Boolean;
        ReleasedBool: Boolean;
        EditableFalseTrueAllControl: Boolean;


    trigger
    OnOpenPage()
    begin
        DisableHeaderLinePage;
    end;

    trigger
    OnModifyRecord(): Boolean
    begin
        DisableHeaderLinePage;
    end;

    trigger
    OnAfterGetRecord()
    begin
        DisableHeaderLinePage;

    end;

    trigger
    OnAfterGetCurrRecord()
    begin
        DisableHeaderLinePage;
    end;

    trigger
    OnDeleteRecord(): Boolean
    var
        MaterialReqLineL: Record "Material Requisition Line";
    begin
        MaterialReqLineL.Reset();
        MaterialReqLineL.SetRange("Document No.", "Requisition No.");
        if MaterialReqLineL.FindSet() then
            MaterialReqLineL.DeleteAll();
    end;


    procedure DisableHeaderLinePage()
    begin
        if (Status = Status::"Pending Approval") or (Status = Status::Released) then begin
            //CurrPage.Editable(false);
            EditableFalseTrueAllControl := false;
            subformEnableBoolG := false;
        end
        else begin
            //CurrPage.Editable(true);
            EditableFalseTrueAllControl := true;
            subformEnableBoolG := true;
        end;
    end;


}