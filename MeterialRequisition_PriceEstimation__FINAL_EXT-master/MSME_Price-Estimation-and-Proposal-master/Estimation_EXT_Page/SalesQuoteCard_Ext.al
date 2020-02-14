
pageextension 50027 "Ext.SalesOrderCard" extends "Sales Quote"
{
    Caption = 'Proposal';
    layout
    {
        addafter("Work Description")
        {
            field("Order Accepted"; "Order Accepted")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        // Add changes to page layout here
        addafter("VAT Bus. Posting Group")
        {
            field("Customer Posting Group"; "Customer Posting Group")
            {
                ApplicationArea = All;
                Enabled = true;
                Editable = true;
            }
        }

        addafter("Due Date")
        {
            field("Over Head %"; "Over Head %")
            {
                ApplicationArea = all;
                Visible = Visiblility;
                trigger OnValidate()
                begin
                    UserSetupRec.Reset();
                    if UserSetupRec.Get(UserId) then begin
                        If UserSetupRec.Departments <> UserSetupRec.Departments::Management then
                            Error('You don' + 't have permission to change the value. Please check user setup.');
                    end;
                end;

            }
            field("Margin %"; "Margin %")
            {
                ApplicationArea = all;
                /// Visible = Visiblility;
                trigger OnValidate()
                begin
                    // UserSetupRec.Reset();
                    // if UserSetupRec.Get(UserId) then begin
                    //     If UserSetupRec.Departments <> UserSetupRec.Departments::Management then
                    //         Error('You don' + 't have permission to change the value. Please check user setup.');
                    // end;
                end;

            }
            field("Job No."; "Job No.")
            {
                ApplicationArea = all;
            }
            field("Version No."; "Version No.")
            {
                ApplicationArea = all;
                Caption = 'Revision No.';
                //Editable = false;
            }
            field("Scope Of Work"; "Scope Of Work")
            {
                ApplicationArea = all;
                Visible = false;

            }
            field("Scope Of Work 1"; "Scope Of Work 1")
            {
                ApplicationArea = all;
            }
            field("Scope Of Work 2"; "Scope Of Work 2")
            {
                ApplicationArea = all;
            }
            field("Product Type"; "Product Type")
            {
                ApplicationArea = all;

            }
            field("Fabric Type"; "Fabric Type")
            {
                ApplicationArea = All;
            }
            field("Location Details"; "Location Details")
            {
                ApplicationArea = all;

            }
            field("Quote Validity"; "Quote Validity")
            {
                ApplicationArea = all;
                Visible = false;

            }
            field(Warranty; Warranty)
            {
                ApplicationArea = all;

            }
            field(Insurance; Insurance)
            {
                ApplicationArea = all;

            }
            field("Estimation Version No."; "Estimation Version No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            // Start 01-07-2019
            field("Project Description"; "Project Description")
            {
                ApplicationArea = All;
            }
            field(Client; Client)
            {
                ApplicationArea = All;
            }
            field(Consultant; Consultant)
            {
                ApplicationArea = All;
            }

            // Stop 01-07-2019
        }
        modify("Opportunity No.")
        {
            Caption = 'Sales Enquiry No.';
            Editable = false;
        }
        // Start 01-07-2019

        modify("Work Description")
        {
            Visible = false;
        }
        // Stop 01-07-2019


    }


    actions
    {
        addafter(IncomingDocument)
        {
            action("Order Acceptance")
            {
                ApplicationArea = All;
                Image = OrderPromising;
                //RunObject = page "Order Acceptance";
                //RunPageLink = "Sales Quote No." = field ("No.");
                trigger
                OnAction()
                var
                    OrderAccptRecL: Record "Order Acceptance";
                    OrderAccptRec1L: Record "Order Acceptance";
                begin
                    OrderAccptRecL.Reset();
                    OrderAccptRecL.SetRange("Sales Quote No.", "No.");
                    if OrderAccptRecL.FindFirst() then
                        page.RunModal(50651, OrderAccptRecL)
                    else begin
                        OrderAccptRec1L.Init();
                        OrderAccptRec1L.Validate("Sales Quote No.", "No.");
                        OrderAccptRec1L.Validate("Document Date", "Document Date");
                        OrderAccptRec1L.Insert(true);
                        Commit();
                        page.RunModal(50651, OrderAccptRec1L);
                    end;
                end;

            }
        }
        addlast(Create)
        {
            //group("Payment MileStones")
            // {
            action("Payment Milestone")
            {
                Image = Payment;
                //Caption = 'Payment Milestone';
                //Promoted = true;
                //PromotedCategory = Process;
                // ApplicationArea = "#Basic", "#Suite";
                //PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = page "Payment Milestone List";
                RunPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");

                //PromotedOnly = true;
                TRIGGER OnAction()
                var
                    PaymentMilestone: Record "Payment Milestone";
                    PaymentMileStoneRecL: Record "Payment Milestone";
                    LineNumberDecL: Integer;
                BEGIN
                    // PaymentMilestone.Reset();
                    //PaymentMilestone.SetRange("Document Type", Rec."Document Type");
                    //PaymentMilestone.SetRange("Document No.", Rec."No.");
                    //if PaymentMilestone.Find() then begin
                    //  PAGE.RUNMODAL(50033, PaymentMilestone);
                    //end;                  

                END;
            }
            action("Open Page")
            {
                ApplicationArea = All;
                RunObject = page "Payment Milestone List";
            }
        }
        addafter("C&ontact")
        {
            action("Create Job")
            {
                ApplicationArea = All;
                Image = CreateJobSalesCreditMemo;
                trigger OnAction()
                var
                    SalesHeaderRecL: Record "Sales Header";
                    OppRecL: Record Opportunity;
                    JobsRecL: Record Job;

                begin
                    // Start 22-07-2019
                    // Check Job Already is Created or not
                    //JobsRecL.Reset();
                    //JobsRecL.SetRange("Sales Quote", "No.");
                    //if JobsRecL.FindFirst() then
                    //Error('Job already created %1 ', JobsRecL."No.");
                    // Stop 22-07-2019 

                    TestField("Order Accepted", true);
                    OppRecL.Reset();
                    if OppRecL.Get("Opportunity No.") then begin
                        if NOT (OppRecL.Status = OppRecL.Status::Won) then
                            Error('Sales Enquiry Status should WON, but current Status %1', OppRecL.Status)
                        else
                            if NOT (Status = Status::Released) then
                                Error('Sales Quote Status Should be RELEASED, but current Status %1', Status)
                            else begin
                                CurrPage.SetSelectionFilter(SalesHeaderRecL);
                                TestField("Version No.");
                                Report.RunModal(50018, false, false, SalesHeaderRecL);
                            end;
                    end
                    else begin
                        CurrPage.SetSelectionFilter(SalesHeaderRecL);
                        TestField("Version No.");
                        Report.RunModal(50018, false, false, SalesHeaderRecL);
                    end;

                end;

            }
        }
        modify("Co&mments")
        {
            Caption = 'Terms & Condition';
        }
        // Start 20-08-2019
        modify(Reopen)
        {
            trigger
            OnAfterAction()
            var
                ArchiveManagement: Codeunit ArchiveManagement;
                OrderAcceptance: record "Order Acceptance";
            begin
                if "Order Accepted" then begin
                    "Order Accepted" := false;
                    Modify();

                end;
                OrderAcceptance.reset;
                OrderAcceptance.SetRange("Sales Quote No.", rec."No.");
                if OrderAcceptance.findfirst then begin
                    OrderAcceptance."Acceptance date" := 0D;
                    OrderAcceptance."Order Acceptance status" := OrderAcceptance."Order Acceptance status"::Open;
                    OrderAcceptance.Modify;
                end;
                clear(ArchiveManagement);
                ArchiveManagement.AutoArchiveSalesDocument(rec);

            end;
        }
        // Stop 20-08-2019

        // Start 27-06-2019
        modify(Email)
        {
            trigger
            OnAfterAction()
            var
                OppRecL: Record Opportunity;
            begin
                OppRecL.Reset();
                if OppRecL.Get("Opportunity No.") then begin
                    OppRecL."MSME Status" := OppRecL."MSME Status"::"Quotation sent";
                    OppRecL.Modify();
                end;

            end;
        }

        // Stop 27-06-2019
        addafter(CopyDocument)
        {
            action("Estimation Details")
            {
                ApplicationArea = All;
                Image = Process;
                RunObject = page "Estimation Header Page";
                RunPageLink = "Quote No." = FIELD("No."), "Version No. Disp" = field("Estimation Version No."), "Version No." = field("Version No.");
                //RunPageLink = "Quote No." = FIELD ("No."), "Version No. Disp" = field ("Version No."), "Version No." = field ("Version No.");


                trigger OnAction()
                var
                    EstimationHdrRec: Record "Estimation Header";
                begin

                    // // // EstimationHdrRec.Reset();
                    // // // EstimationHdrRec.SetRange("Quote No.", "No.");
                    // // // EstimationHdrRec.SetRange("Version No. Disp", "Estimation Version No.");
                    // // // EstimationHdrRec.SetRange("Version No.", "Version No.");
                    // // // if EstimationHdrRec.FindFirst() then begin
                    // // //     Page.Run(50019, EstimationHdrRec);
                    // // // end
                    // // // else begin
                    // // //     EstimationHdrRec.Reset();
                    // // //     EstimationHdrRec.Init();
                    // // //     EstimationHdrRec.Validate("Quote No.", "No.");
                    // // //     EstimationHdrRec.Validate("Version No. Disp", 1);
                    // // //     EstimationHdrRec.Validate("Version No.", 1);
                    // // //     EstimationHdrRec.Insert();
                    // // //     Page.Run(50019, EstimationHdrRec);
                    // // // end;

                    //Page.Run(50015, Rec);
                    //GetSetValue.SetValue("No.");
                    //Message("No.");
                    //EstimationHdrRec.Reset();
                    //EstimationHdrRec.SetRange("Quote No.", Rec."No.");
                    //if EstimationHdrRec.FindLast() then
                    //Page.Run(50011, EstimationHdrRec)
                    //else
                    //page.Run(50011);
                    // Process.DeleteAll();
                    If "Version No." = 0 then begin
                        "Version No." := 1;
                        Rec.Modify();
                    end;
                end;
            }
            action("Get Estimation Details")
            {
                ApplicationArea = all;
                Image = GetEntries;
                trigger OnAction()
                var
                    EstimHdrRec: Record "Estimation Header";
                    EstimationLineRec: Record "Estimation Line Tbl";
                    SalesLineRec: Record "Sales Line";
                    SalesLine2Rec: Record "Sales Line";
                    SnR: Record "Sales & Receivables Setup";
                begin
                    // Start 05-07-2019
                    TestField("Margin %");
                    TestField("Over Head %");
                    // Stop 05-07-2019
                    EstimHdrRec.Reset();
                    EstimHdrRec.SetRange("Quote No.", "No.");
                    EstimHdrRec.SetRange("Version No.", "Version No.");
                    //EstimHdrRec.SetRange("Version No. Disp", "Estimation Version No.");
                    If EstimHdrRec.FindFirst() then begin
                        if EstimHdrRec.Status = EstimHdrRec.Status::Released then begin
                            EstimationLineRec.Reset();
                            EstimationLineRec.SetRange("Quote No.", Rec."No.");
                            EstimationLineRec.SetRange("Version No.", Rec."Version No.");
                            if EstimationLineRec.FindFirst then begin
                                repeat
                                    SalesLineRec.Reset();
                                    SalesLineRec.SetRange("Document No.", Rec."No.");
                                    SalesLineRec.SetRange("Drawing No.", EstimationLineRec."Drawing Number");
                                    if not SalesLineRec.FindFirst then
                                        Process.SalesQuoteLineCreate("No.", "Version No.");
                                UNtil EstimationLineRec.Next = 0;
                            end;
                        end else
                            Error('Record should be released for creating sales quote lines');
                    End;
                    // Start 02-09-2019
                    // Need to check with Ankur Y this method required.
                    // Comment due to Unit Price Calculation coming wrong 
                    SalesLine2Rec.Reset();
                    SalesLine2Rec.SetRange("Document No.", "No.");
                    SalesLine2Rec.SetRange("Document Type", "Document Type");
                    if SalesLine2Rec.FindFirst() then
                        Process.UpdateUnitPriceExclVAT("No.");
                    // Stop 02-09-2019


                end;
            }
            /*
            action(DeleteAll)
            {
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Process.DeleteAll();
                end;
            }
            */


        }
        // Start 19-07-2019
        modify(MakeOrder)
        {
            trigger
            OnBeforeAction()
            begin
                TestField("Order Accepted", true);
            end;
        }
        // Stop 19-07-2019
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        UserSetupRec.Reset();
        if UserSetupRec.Get(UserId) then begin
            If UserSetupRec.Departments <> UserSetupRec.Departments::Management then
                Visiblility := False;
        end;
        If ("Margin %" = 0) Or ("Over Head %" = 0) then begin
            SalesRece.Reset();
            SalesRece.Get();
            SalesRece.TestField("Margin %");
            SalesRece.TestField("Over Head %");
            Rec."Margin %" := SalesRece."Margin %";
            Rec."Over Head %" := SalesRece."Over Head %";
            Rec.Modify();/////////////*********
        End;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        UserSetupRec.Reset();
        if UserSetupRec.Get(UserId) then begin
            If UserSetupRec.Departments <> UserSetupRec.Departments::Management then
                Visiblility := False;
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Visiblility := True;
        UserSetupRec.Reset();
        if UserSetupRec.Get(UserId) then begin
            If UserSetupRec.Departments <> UserSetupRec.Departments::Management then
                Visiblility := False;
        end;

    end;
    // Start 08-09-2019
    trigger
    OnDeleteRecord(): Boolean
    var
        OpporRecL: Record Opportunity;
        SalesHeaderRec: Record "Sales Header";
    begin
        SalesHeaderRec.Reset();
        SalesHeaderRec.SetRange("No.", "No.");
        SalesHeaderRec.SetRange("Document Type", "Document Type");
        SalesHeaderRec.SetRange("Opportunity No.", "Opportunity No.");
        if SalesHeaderRec.FindFirst() then begin
            OpporRecL.Reset();
            OpporRecL.SetRange("No.", SalesHeaderRec."Opportunity No.");
            if OpporRecL.FindFirst() then begin
                OpporRecL."Date for Submit Quotation" := 0D;
                OpporRecL.Modify();
            end;
        end;

    end;
    // Stop 08-09-2019


    var
        EstimationPage: Page "Estimation Header Page";
        EstimationHdrRec: Record "Estimation Header";
        GetSetValue: XmlPort "BOQ-Import";
        Process: Codeunit Process;
        UserSetupRec: Record "User Setup";
        Visiblility: Boolean;

        SalesRece: Record "Sales & Receivables Setup";

}