page 50002 "Purch. Enquiry Card"
{
    PageType = Card;
    //ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = "Purch. Enquiry Header";
    Caption = 'Purchase Enquiry';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(Contact; Contact)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Purchaser code"; "Purchase Code")
                {
                    ApplicationArea = All;
                    Caption = 'Purchaser Code';
                }
                field("Requisition No."; "Requisition No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Creation date/Time"; "Creation dateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Expected delivery date"; "Expected delivery date")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Converted to Quote"; "Converted to Quote")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Purchase Lines")
            {
                part("Purch. Line"; "Purch. Enquiry Subform")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No." = field ("No.");
                    UpdatePropagation = Both;
                    Enabled = "No." <> '';
                    Caption = 'Purch. Enquiry Line';


                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Quote")
            {
                ApplicationArea = All;
                Image = Create;

                trigger OnAction()
                var
                    PurchQuoteHdrRecL: Record "Purchase Header";
                begin
                    if "Converted to Quote" then begin
                        PurchQuoteHdrRecL.Reset();
                        PurchQuoteHdrRecL.SetRange("Enquiry No.", "No.");
                        if PurchQuoteHdrRecL.FindLast() then
                            if Confirm(StrSubstNo('Quote no. %1 is already created from the enquiry. Do you want to create another Purchase Quote ', PurchQuoteHdrRecL."No.")) then
                                CreatePurchaseQuote();
                    end else
                        CreatePurchaseQuote();
                end;


            }

            action("Purchase Quote List")
            {
                ApplicationArea = All;
                Image = Purchase;
                trigger OnAction()
                var
                    PurchaseHeaderG: Record "Purchase Header";
                begin
                    PurchaseHeaderG.Reset();
                    PurchaseHeaderG.SetRange("Enquiry No.", Rec."No.");
                    if PurchaseHeaderG.FindFirst() then
                        PAGE.RunModal(9306, PurchaseHeaderG)
                    //PAGE.RunModal(49, PurchaseHeaderG)
                    else
                        Error('There is no Purchase Quote against this Enquiry.');
                end;
            }
            group("Print Report")
            {
                action("Purchase Enquiry")
                {
                    ApplicationArea = All;
                    Image = Purchase;
                    trigger OnAction()
                    var
                        PurchaseEnqryHeaderRecL: Record "Purch. Enquiry Header";
                    begin
                        CurrPage.SetSelectionFilter(PurchaseEnqryHeaderRecL);
                        Report.RunModal(50130, true, true, PurchaseEnqryHeaderRecL);
                    end;

                }
            }
            group(Comments)
            {
                action(Comment)
                {
                    ApplicationArea = All;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Report;
                    RunObject = page "Purchase Enq. Comment Sheet";
                    RunPageLink = "Document Type" = CONST ("Purchase Enquiry"), "No." = FIELD ("No.");
                    trigger OnAction()
                    var
                    begin
                    end;

                }
            }
        }


    }

    trigger
    OnDeleteRecord(): Boolean
    var
        MaterilaReqLineL: Record "Material Requisition Line";
        PurchEnqryLineL: Record "Purch. Enquiry Line";
    BEGIN
        PurchEnqryLineL.Reset();
        MaterilaReqLineL.Reset();
        PurchEnqryLineL.SetRange("Document No.", "No.");
        if PurchEnqryLineL.FindSet() then
            repeat
                MaterilaReqLineL.SetRange("Document No.", "Requisition No.");
                MaterilaReqLineL.SetRange("Job No.", PurchEnqryLineL."Job No.");
                MaterilaReqLineL.SetRange("Job task No.", PurchEnqryLineL."Job task No.");
                MaterilaReqLineL.SetRange("Job Planning Line No.", PurchEnqryLineL."Job Planning Line No.");
                if MaterilaReqLineL.FindFirst() then begin
                    MaterilaReqLineL."Req. To Enqry" := false;
                    MaterilaReqLineL.Modify();
                end;
            until PurchEnqryLineL.Next() = 0;
        PurchEnqryLineL.DeleteAll();

    END;

    var
        EditiableVendorBoolG: Boolean;
        EditiableContactBoolG: Boolean;
        PQuoteNo: Code[20];
        NoSeriesMgmnt: Codeunit NoSeriesManagement;

        // Start 10-07-2019
        // Created New funcation 

    procedure CreatePurchaseQuote()
    var
        PurchQuoteHdr: Record "Purchase Header";
        PurchQuoteLineRec: Record "Purchase Line";
        PurchQuoteLineRec_1: Record "Purchase Line";
        PurchEnqLineRec: Record "Purch. Enquiry Line";
        PurchEnqLineRec_1: Record "Purch. Enquiry Line";
        LineNo: Integer;
        ContactREcL: Record Contact;
        vendorRecL: Record Vendor;
        // Start 27-06-2019
        ContactBusinessRelation: Record "Contact Business Relation";
        // Stop 27-06-2019
        // Start 10-07-2019
        PurchQuoteHdrRecL: Record "Purchase Header";
        // Stop 10-07-2019
        // Start 07-09-2019
        PurchasePayableSetupRecL: Record "Purchases & Payables Setup";
        // Stop 07-09-2019

    begin
        // Start 10-09-2019
        PurchasePayableSetupRecL.Reset();
        PurchasePayableSetupRecL.Get();
        PurchasePayableSetupRecL.TestField("Quote Nos.");
        Clear(PQuoteNo);
        PurchQuoteHdr.Init;
        ContactREcL.Reset();
        ContactREcL.Get(Contact);
        //PQuoteNo := NoSeriesMgmnt.GetNextNo('P-QUO', Today, true);
        PQuoteNo := NoSeriesMgmnt.GetNextNo(PurchasePayableSetupRecL."Quote Nos.", Today, true);
        //PQuoteNo := NoSeriesMgmnt.GetNextNo3(PurchasePayableSetupRecL."Quote Nos.", Today, true, true);
        // PurchQuoteHdr.validate("No.", PQuoteNo);
        PurchQuoteHdr."No." := PQuoteNo;
        PurchQuoteHdr.Validate("Requisition No.", Rec."Requisition No.");
        PurchQuoteHdr.Validate("Enquiry No.", Rec."No.");
        // Start 27-06-2019
        ContactBusinessRelation.Reset();
        //ContactBusinessRelation.SetRange("Contact No.", Contact);
        ContactBusinessRelation.SetRange("Contact No.", ContactREcL."Company No.");
        ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Vendor);
        if ContactBusinessRelation.FindFirst() then begin
            vendorRecL.Reset();
            vendorRecL.SetRange("No.", ContactBusinessRelation."No.");
            if vendorRecL.FindFirst() then
                PurchQuoteHdr.Validate("Buy-from Vendor No.", vendorRecL."No.")
            else
                Error('There is no Vendor exsist for this Contact No. %1', Contact);
        end;
        PurchQuoteHdr.Validate("Job No.", Rec."Job No.");
        // PurchQuoteHdr.Validate("Job Task No.", Rec."Job Task No.");
        //PurchQuoteHdr."Job No." := Rec."Job No.";
        //PurchQuoteHdr."Job Task No." := Rec."Job Task No.";

        PurchQuoteHdr.Validate("Purchaser Code", Rec."Purchase Code");
        // Start 23-07-2019
        PurchQuoteHdr.Validate("Location Code", Rec."Location Code");
        // Stop 23-07-2019
        // Start 26-07-2019
        PurchQuoteHdr.Validate("Document Date", Today);
        PurchQuoteHdr.Validate("Posting Date", Today);
        PurchQuoteHdr.Validate("Dimension Set ID", CopyFromJobDimensionToReleaseProductionOrder(Rec."Job No."));
        // Stop 26-07-2019
        PurchQuoteHdr.Insert();
        PurchEnqLineRec.Reset();
        //PurchEnqLineRec.Ascending();
        PurchEnqLineRec.SetRange("Document No.", Rec."No.");
        if PurchEnqLineRec.FindFirst() then begin
            repeat
                PurchQuoteLineRec_1.Reset();
                PurchQuoteLineRec_1.SetRange("Document No.", PQuoteNo);
                if PurchQuoteLineRec_1.FindLast then
                    LineNo := PurchQuoteLineRec_1."Line No." + 10000
                else
                    LineNo := 10000;

                PurchQuoteLineRec.init();
                PurchQuoteLineRec."Document No." := PQuoteNo;
                PurchQuoteLineRec."Document Type" := PurchQuoteLineRec."Document Type"::Quote;
                PurchQuoteLineRec."Line No." := LineNo;
                if PurchEnqLineRec.Type = PurchEnqLineRec.Type::"G/L Account" then
                    PurchQuoteLineRec.Validate(Type, PurchQuoteLineRec.Type::"G/L Account")
                else
                    if PurchEnqLineRec.Type = PurchEnqLineRec.Type::Item then
                        PurchQuoteLineRec.Validate(Type, PurchQuoteLineRec.Type::Item);

                PurchQuoteLineRec.validate("No.", PurchEnqLineRec."No.");
                PurchQuoteLineRec.Validate(Quantity, PurchEnqLineRec.Quantity);
                PurchQuoteLineRec.Validate("Unit of Measure", PurchEnqLineRec."Unit of Measure");

                // PurchQuoteLineRec.Validate("Job No.", PurchEnqLineRec."Job No.");
                // PurchQuoteLineRec.Validate("Job Task No.", PurchEnqLineRec."Job task No.");
                // PurchQuoteLineRec.Validate("Job Planning Line No.", PurchEnqLineRec."Job Planning Line No.");

                ///---->PurchQuoteLineRec."Job No." := PurchEnqLineRec."Job No.";
                ///////------->PurchQuoteLineRec."Job Task No." := PurchEnqLineRec."Job task No.";
                /////////------> PurchQuoteLineRec."Job Planning Line No." := PurchEnqLineRec."Job Planning Line No.";

                // Start 09-07-2019
                PurchQuoteLineRec."Location Code" := PurchEnqLineRec.Location;
                // Stop 09-07-2019
                // Start 23-07-2019
                PurchQuoteLineRec.Validate("Outstanding Qty. (Base)", PurchEnqLineRec.Quantity);
                PurchQuoteLineRec.Validate("Quantity (Base)", PurchEnqLineRec.Quantity);
                // Stop 23-07-2019
                PurchQuoteLineRec.Validate("Job No.", '');
                PurchQuoteLineRec.Validate("Job Task No.", '');
                PurchQuoteLineRec.Validate("Job Planning Line No.", 0);

                PurchQuoteLineRec.Insert();

            until PurchEnqLineRec.Next = 0;
            Message('Purchase Quote %1 is Created ', PQuoteNo);
            // Start 10-07-2019
            "Converted to Quote" := true;
            // Stop 10-07-2019
        End;
        // 10-09-2019
    end;

    procedure CopyFromJobDimensionToReleaseProductionOrder(JobNoP: Code[20]): Integer
    var
        DefaultDimensionRecL: Record "Default Dimension";
        DimensionSetEntryRecL: Record "Dimension Set Entry" temporary;
        DimensionValueRecL: Record "Dimension Value";
        DimensionManagementCU: Codeunit DimensionManagement;
    begin
        DefaultDimensionRecL.Reset();
        DefaultDimensionRecL.SetCurrentKey("Table ID", "No.", "Dimension Code");
        DefaultDimensionRecL.SetRange("Table ID", Database::Job);
        DefaultDimensionRecL.SetRange("No.", JobNoP);
        if DefaultDimensionRecL.FindSet() then begin
            repeat
                DimensionSetEntryRecL.Init();
                DimensionSetEntryRecL.Validate("Dimension Code", DefaultDimensionRecL."Dimension Code");
                DimensionSetEntryRecL.Validate("Dimension Value Code", DefaultDimensionRecL."Dimension Value Code");

                DimensionValueRecL.Reset();
                DimensionValueRecL.SetRange("Dimension Code", DefaultDimensionRecL."Dimension Code");
                DimensionValueRecL.SetRange(Code, DefaultDimensionRecL."Dimension Value Code");
                if DimensionValueRecL.FindFirst() then
                    DimensionSetEntryRecL.Validate("Dimension Value ID", DimensionValueRecL."Dimension Value ID");

                if DimensionSetEntryRecL.Insert() then;
            until DefaultDimensionRecL.Next() = 0;
        end;

        exit(DimensionManagementCU.GetDimensionSetID(DimensionSetEntryRecL));


    end;
}