report 50689 "Copy Sales Document-Cust"
{
    Caption = 'Copy Sales Document-Cust';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DocumentType; DocType)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Document Type';
                        OptionCaption = 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Posted Shipment,Posted Invoice,Posted Return Receipt,Posted Credit Memo,Arch. Quote,Arch. Order,Arch. Blanket Order,Arch. Return Order';
                        ToolTip = 'Specifies the type of document that is processed by the report or batch job.';

                        trigger OnValidate()
                        begin
                            DocNo := '';
                            ValidateDocNo;
                        end;
                    }
                    field(DocumentNo; DocNo)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Document No.';
                        ShowMandatory = true;
                        ToolTip = 'Specifies the number of the document that is processed by the report or batch job.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            LookupDocNo;
                        end;

                        trigger OnValidate()
                        begin
                            ValidateDocNo;
                        end;
                    }
                    field(DocNoOccurrence; DocNoOccurrence)
                    {
                        ApplicationArea = Suite;
                        BlankZero = true;
                        Caption = 'Doc. No. Occurrence';
                        Editable = false;
                        ToolTip = 'Specifies the number of times the No. value has been used in the number series.';
                    }
                    field(DocVersionNo; DocVersionNo)
                    {
                        ApplicationArea = Suite;
                        BlankZero = true;
                        Caption = 'Version No.';
                        Editable = false;
                        ToolTip = 'Specifies the version of the document to be copied.';
                    }
                    field(SellToCustNo; FromSalesHeader."Sell-to Customer No.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Sell-to Customer No.';
                        Editable = false;
                        ToolTip = 'Specifies the sell-to customer number that will appear on the new sales document.';
                    }
                    field(SellToCustName; FromSalesHeader."Sell-to Customer Name")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Sell-to Customer Name';
                        Editable = false;
                        ToolTip = 'Specifies the sell-to customer name that will appear on the new sales document.';
                    }
                    field(IncludeHeader_Options; IncludeHeader)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Include Header';
                        ToolTip = 'Specifies if you also want to copy the information from the document header. When you copy quotes, if the posting date field of the new document is empty, the work date is used as the posting date of the new document.';

                        trigger OnValidate()
                        begin
                            ValidateIncludeHeader;
                        end;
                    }
                    field(RecalculateLines; RecalculateLines)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Recalculate Lines';
                        ToolTip = 'Specifies that lines are recalculate and inserted on the sales document you are creating. The batch job retains the item numbers and item quantities but recalculates the amounts on the lines based on the customer information on the new document header. In this way, the batch job accounts for item prices and discounts that are specifically linked to the customer on the new header.';

                        trigger OnValidate()
                        begin
                            IF (DocType = DocType::"Posted Shipment") OR (DocType = DocType::"Posted Return Receipt") THEN
                                RecalculateLines := TRUE;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF DocNo <> '' THEN BEGIN
                CASE DocType OF
                    DocType::Quote:
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::Quote, DocNo) THEN
                            ;
                    DocType::"Blanket Order":
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::"Blanket Order", DocNo) THEN
                            ;
                    DocType::Order:
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::Order, DocNo) THEN
                            ;
                    DocType::Invoice:
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::Invoice, DocNo) THEN
                            ;
                    DocType::"Return Order":
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::"Return Order", DocNo) THEN
                            ;
                    DocType::"Credit Memo":
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::"Credit Memo", DocNo) THEN
                            ;
                    DocType::"Posted Shipment":
                        IF FromSalesShptHeader.GET(DocNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromSalesShptHeader);
                    DocType::"Posted Invoice":
                        begin
                            IF FromSalesInvHeader.GET(DocNo) THEN
                                FromSalesHeader.TRANSFERFIELDS(FromSalesInvHeader);

                        end;
                    DocType::"Posted Return Receipt":
                        IF FromReturnRcptHeader.GET(DocNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromReturnRcptHeader);
                    DocType::"Posted Credit Memo":
                        IF FromSalesCrMemoHeader.GET(DocNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromSalesCrMemoHeader);
                    DocType::"Arch. Order":
                        IF FromSalesHeaderArchive.GET(FromSalesHeaderArchive."Document Type"::Order, DocNo, DocNoOccurrence, DocVersionNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromSalesHeaderArchive);
                    DocType::"Arch. Quote":
                        IF FromSalesHeaderArchive.GET(FromSalesHeaderArchive."Document Type"::Quote, DocNo, DocNoOccurrence, DocVersionNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromSalesHeaderArchive);
                    DocType::"Arch. Blanket Order":
                        IF FromSalesHeaderArchive.GET(FromSalesHeaderArchive."Document Type"::"Blanket Order", DocNo, DocNoOccurrence, DocVersionNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromSalesHeaderArchive);
                    DocType::"Arch. Return Order":
                        IF FromSalesHeaderArchive.GET(FromSalesHeaderArchive."Document Type"::"Return Order", DocNo, DocNoOccurrence, DocVersionNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromSalesHeaderArchive);
                END;
                IF FromSalesHeader."No." = '' THEN
                    DocNo := '';
            END;
            ValidateDocNo;

            OnAfterOpenPage;
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            IF CloseAction = ACTION::OK THEN
                IF DocNo = '' THEN
                    ERROR(DocNoNotSerErr);

            // Credit Memo Copy Payment MileStone
            SalesInvoiceHeaderRec_G.Reset();
            SalesInvoiceHeaderRec_G.SetRange("No.", DocNo);
            if (DocType = DocType::"Posted Invoice") AND (SalesInvoiceHeaderRec_G.FindFirst()) then begin
                //Message('PSI Doc %1   CURR DOC %2', DocNo, SalesHeader."No.");
                CopyPaymentMileStone(SalesInvoiceHeaderRec_G, SalesHeader);
            end;
            // Credit Memo Copy PAyment Milestone    
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        SalesSetup.GET;
        CopyDocMgt.SetProperties(
          IncludeHeader, RecalculateLines, FALSE, FALSE, FALSE, SalesSetup."Exact Cost Reversing Mandatory", FALSE);
        CopyDocMgt.SetArchDocVal(DocNoOccurrence, DocVersionNo);

        OnPreReportOnBeforeCopySalesDoc(CopyDocMgt);

        CopyDocMgt.CopySalesDoc(DocType, DocNo, SalesHeader);
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesHeaderRec_G: Record "Sales Header";
        SalesInvoiceHeaderRec_G: Record "Sales Invoice Header";
        FromSalesHeader: Record "Sales Header";
        FromSalesShptHeader: Record "Sales Shipment Header";
        FromSalesInvHeader: Record "Sales Invoice Header";
        FromReturnRcptHeader: Record "Return Receipt Header";
        FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        FromSalesHeaderArchive: Record "Sales Header Archive";
        SalesSetup: Record "Sales & Receivables Setup";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        DocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
        DocNo: Code[20];
        IncludeHeader: Boolean;
        RecalculateLines: Boolean;
        Text000: Label 'The price information may not be reversed correctly, if you copy a %1. If possible copy a %2 instead or use %3 functionality.';
        Text001: Label 'Undo Shipment';
        Text002: Label 'Undo Return Receipt';
        Text003: Label 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Posted Shipment,Posted Invoice,Posted Return Receipt,Posted Credit Memo';
        DocNoOccurrence: Integer;
        DocVersionNo: Integer;
        DocNoNotSerErr: Label 'Select a document number to continue, or choose Cancel to close the page.';

    procedure SetSalesHeader(var NewSalesHeader: Record "Sales Header")
    begin
        NewSalesHeader.TESTFIELD("No.");
        SalesHeader := NewSalesHeader;
    end;

    local procedure ValidateDocNo()
    var
        DocType2: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo";
    begin
        IF DocNo = '' THEN BEGIN
            FromSalesHeader.INIT;
            DocNoOccurrence := 0;
            DocVersionNo := 0;
        END ELSE
            IF FromSalesHeader."No." = '' THEN BEGIN
                FromSalesHeader.INIT;
                CASE DocType OF
                    DocType::Quote,
                  DocType::"Blanket Order",
                  DocType::Order,
                  DocType::Invoice,
                  DocType::"Return Order",
                  DocType::"Credit Memo":
                        FromSalesHeader.GET(CopyDocMgt.SalesHeaderDocType(DocType), DocNo);
                    DocType::"Posted Shipment":
                        BEGIN
                            FromSalesShptHeader.GET(DocNo);
                            FromSalesHeader.TRANSFERFIELDS(FromSalesShptHeader);
                            IF SalesHeader."Document Type" IN
                               [SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"]
                            THEN BEGIN
                                DocType2 := DocType2::"Posted Invoice";
                                MESSAGE(Text000, SELECTSTR(1 + DocType, Text003), SELECTSTR(1 + DocType2, Text003), Text001);
                            END;
                        END;
                    DocType::"Posted Invoice":
                        BEGIN
                            FromSalesInvHeader.GET(DocNo);
                            FromSalesHeader.TRANSFERFIELDS(FromSalesInvHeader);
                        END;
                    DocType::"Posted Return Receipt":
                        BEGIN
                            FromReturnRcptHeader.GET(DocNo);
                            FromSalesHeader.TRANSFERFIELDS(FromReturnRcptHeader);
                            IF SalesHeader."Document Type" IN
                               [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]
                            THEN BEGIN
                                DocType2 := DocType2::"Posted Credit Memo";
                                MESSAGE(Text000, SELECTSTR(1 + DocType, Text003), SELECTSTR(1 + DocType2, Text003), Text002);
                            END;
                        END;
                    DocType::"Posted Credit Memo":
                        BEGIN
                            FromSalesCrMemoHeader.GET(DocNo);
                            FromSalesHeader.TRANSFERFIELDS(FromSalesCrMemoHeader);
                        END;
                    DocType::"Arch. Quote",
                    DocType::"Arch. Order",
                    DocType::"Arch. Blanket Order",
                    DocType::"Arch. Return Order":
                        BEGIN
                            IF NOT FromSalesHeaderArchive.GET(
                                 CopyDocMgt.ArchSalesHeaderDocType(DocType), DocNo, DocNoOccurrence, DocVersionNo)
                            THEN BEGIN
                                FromSalesHeaderArchive.SETRANGE("No.", DocNo);
                                IF FromSalesHeaderArchive.FINDLAST THEN BEGIN
                                    DocNoOccurrence := FromSalesHeaderArchive."Doc. No. Occurrence";
                                    DocVersionNo := FromSalesHeaderArchive."Version No.";
                                END;
                            END;
                            FromSalesHeader.TRANSFERFIELDS(FromSalesHeaderArchive);
                        END;
                END;
            END;
        FromSalesHeader."No." := '';

        IncludeHeader :=
          (DocType IN [DocType::"Posted Invoice", DocType::"Posted Credit Memo"]) AND
          ((DocType = DocType::"Posted Credit Memo") <>
           (SalesHeader."Document Type" IN
            [SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"])) AND
          (SalesHeader."Bill-to Customer No." IN [FromSalesHeader."Bill-to Customer No.", '']);

        OnBeforeValidateIncludeHeader(IncludeHeader);
        ValidateIncludeHeader;
        OnAfterValidateIncludeHeader(IncludeHeader, RecalculateLines);
    end;

    local procedure LookupDocNo()
    begin
        CASE DocType OF
            DocType::Quote,
          DocType::"Blanket Order",
          DocType::Order,
          DocType::Invoice,
          DocType::"Return Order",
          DocType::"Credit Memo":
                LookupSalesDoc;
            DocType::"Posted Shipment":
                LookupPostedShipment;
            DocType::"Posted Invoice":
                LookupPostedInvoice;
            DocType::"Posted Return Receipt":
                LookupPostedReturn;
            DocType::"Posted Credit Memo":
                LookupPostedCrMemo;
            DocType::"Arch. Quote",
          DocType::"Arch. Order",
          DocType::"Arch. Blanket Order",
          DocType::"Arch. Return Order":
                LookupSalesArchive;
        END;
        ValidateDocNo;
    end;

    local procedure LookupSalesDoc()
    begin
        FromSalesHeader.FILTERGROUP := 0;
        FromSalesHeader.SETRANGE("Document Type", CopyDocMgt.SalesHeaderDocType(DocType));
        IF SalesHeader."Document Type" = CopyDocMgt.SalesHeaderDocType(DocType) THEN
            FromSalesHeader.SETFILTER("No.", '<>%1', SalesHeader."No.");
        FromSalesHeader.FILTERGROUP := 2;
        FromSalesHeader."Document Type" := CopyDocMgt.SalesHeaderDocType(DocType);
        FromSalesHeader."No." := DocNo;
        IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
            IF FromSalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.") THEN BEGIN
                FromSalesHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                IF FromSalesHeader.FIND('=><') THEN;
            END;
        IF PAGE.RUNMODAL(0, FromSalesHeader) = ACTION::LookupOK THEN
            DocNo := FromSalesHeader."No.";
    end;

    local procedure LookupSalesArchive()
    begin
        FromSalesHeaderArchive.RESET;
        FromSalesHeaderArchive.FILTERGROUP := 0;
        FromSalesHeaderArchive.SETRANGE("Document Type", CopyDocMgt.ArchSalesHeaderDocType(DocType));
        FromSalesHeaderArchive.FILTERGROUP := 2;
        FromSalesHeaderArchive."Document Type" := CopyDocMgt.ArchSalesHeaderDocType(DocType);
        FromSalesHeaderArchive."No." := DocNo;
        FromSalesHeaderArchive."Doc. No. Occurrence" := DocNoOccurrence;
        FromSalesHeaderArchive."Version No." := DocVersionNo;
        IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
            IF FromSalesHeaderArchive.SETCURRENTKEY("Document Type", "Sell-to Customer No.") THEN BEGIN
                FromSalesHeaderArchive."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                IF FromSalesHeaderArchive.FIND('=><') THEN;
            END;
        IF PAGE.RUNMODAL(0, FromSalesHeaderArchive) = ACTION::LookupOK THEN BEGIN
            DocNo := FromSalesHeaderArchive."No.";
            DocNoOccurrence := FromSalesHeaderArchive."Doc. No. Occurrence";
            DocVersionNo := FromSalesHeaderArchive."Version No.";
            RequestOptionsPage.UPDATE(FALSE);
        END;
    end;

    local procedure LookupPostedShipment()
    begin
        FromSalesShptHeader."No." := DocNo;
        IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
            IF FromSalesShptHeader.SETCURRENTKEY("Sell-to Customer No.") THEN BEGIN
                FromSalesShptHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                IF FromSalesShptHeader.FIND('=><') THEN;
            END;
        IF PAGE.RUNMODAL(0, FromSalesShptHeader) = ACTION::LookupOK THEN
            DocNo := FromSalesShptHeader."No.";
    end;

    local procedure LookupPostedInvoice()
    begin
        FromSalesInvHeader."No." := DocNo;
        IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
            IF FromSalesInvHeader.SETCURRENTKEY("Sell-to Customer No.") THEN BEGIN
                FromSalesInvHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                IF FromSalesInvHeader.FIND('=><') THEN;
            END;
        FromSalesInvHeader.FILTERGROUP(2);
        FromSalesInvHeader.SETRANGE("Prepayment Invoice", FALSE);
        FromSalesInvHeader.FILTERGROUP(0);
        IF PAGE.RUNMODAL(0, FromSalesInvHeader) = ACTION::LookupOK THEN
            DocNo := FromSalesInvHeader."No.";
    end;

    local procedure LookupPostedCrMemo()
    begin
        FromSalesCrMemoHeader."No." := DocNo;
        IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
            IF FromSalesCrMemoHeader.SETCURRENTKEY("Sell-to Customer No.") THEN BEGIN
                FromSalesCrMemoHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                IF FromSalesCrMemoHeader.FIND('=><') THEN;
            END;
        FromSalesCrMemoHeader.FILTERGROUP(2);
        FromSalesCrMemoHeader.SETRANGE("Prepayment Credit Memo", FALSE);
        FromSalesCrMemoHeader.FILTERGROUP(0);
        IF PAGE.RUNMODAL(0, FromSalesCrMemoHeader) = ACTION::LookupOK THEN
            DocNo := FromSalesCrMemoHeader."No.";
    end;

    local procedure LookupPostedReturn()
    begin
        FromReturnRcptHeader."No." := DocNo;
        IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
            IF FromReturnRcptHeader.SETCURRENTKEY("Sell-to Customer No.") THEN BEGIN
                FromReturnRcptHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                IF FromReturnRcptHeader.FIND('=><') THEN;
            END;
        IF PAGE.RUNMODAL(0, FromReturnRcptHeader) = ACTION::LookupOK THEN
            DocNo := FromReturnRcptHeader."No.";
    end;

    local procedure ValidateIncludeHeader()
    begin
        RecalculateLines :=
          (DocType IN [DocType::"Posted Shipment", DocType::"Posted Return Receipt"]) OR NOT IncludeHeader;
    end;

    procedure InitializeRequest(NewDocType: Option; NewDocNo: Code[20]; NewIncludeHeader: Boolean; NewRecalcLines: Boolean)
    begin
        DocType := NewDocType;
        DocNo := NewDocNo;
        IncludeHeader := NewIncludeHeader;
        RecalculateLines := NewRecalcLines;
    end;

   // [IntegrationEvent(false, TRUE)]
    local procedure OnAfterOpenPage()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateIncludeHeader(var IncludeHeader: Boolean; var RecalculateLines: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateIncludeHeader(var DoIncludeHeader: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPreReportOnBeforeCopySalesDoc(var CopyDocumentMgt: Codeunit "Copy Document Mgt.")
    begin
    end;

    procedure CopyPaymentMileStone(SalesInvoiceHeaderRec_P: Record "Sales Invoice Header"; SalesHeader_CrMemo_P: Record "Sales Header")
    var
        PaymentMilestone2: Record "Payment Milestone";
        PaymentMilestone4: Record "Payment Milestone";
        PaymentMilestone3: Record "Payment Milestone";
        PaymentMileStonePage: Page "Payment Milestone List";
    begin
        PaymentMilestone4.Reset();
        PaymentMilestone4.SetRange("Document Type", PaymentMilestone4."Document Type"::"Credit Memo");
        PaymentMilestone4.SetRange("Document No.", SalesHeader_CrMemo_P."No.");
        if PaymentMilestone4.FindSet() then
            PaymentMilestone4.DeleteAll();

        // Message('inside  Posted Inv %1   Cre MO %2', SalesInvoiceHeaderRec_P."No.", SalesHeader_CrMemo_P."No.");
        PaymentMilestone2.Reset();
        PaymentMilestone2.SetRange("Document Type", PaymentMilestone2."Document Type"::"Posted Invoice");
        PaymentMilestone2.SetRange("Document No.", SalesInvoiceHeaderRec_P."No.");
        IF PaymentMilestone2.FindSet() THEN BEGIN
            // Message('Payment Go IT');
            REPEAT
                PaymentMilestone3.Init();
                PaymentMilestone3."Document Type" := PaymentMilestone3."Document Type"::"Credit Memo";
                PaymentMilestone3."Document No." := SalesHeader_CrMemo_P."No.";

                PaymentMilestone3.Validate("Currency Factor", PaymentMilestone2."Currency Factor");
                PaymentMilestone3."Document Date" := PaymentMilestone2."Document Date";
                PaymentMilestone3."Milestone %" := PaymentMilestone2."Milestone %";

                PaymentMilestone3."Total Value" := PaymentMilestone2."Total Value";
                // Message('Total Va %1', PaymentMilestone2."Total Value");
                PaymentMilestone3.Amount := PaymentMilestone2.Amount;
                PaymentMilestone3."Total Value(LCY)" := PaymentMilestone2."Total Value(LCY)";
                PaymentMilestone3."Amount(LCY)" := PaymentMilestone2."Amount(LCY)";

                PaymentMilestone3."Milestone Description" := PaymentMilestone2."Milestone Description";
                PaymentMilestone3."Payment Terms" := PaymentMilestone2."Payment Terms";
                PaymentMilestone3."Due Date" := PaymentMilestone2."Due Date";
                PaymentMilestone3."Line No." := PaymentMilestone2."Line No.";
                PaymentMilestone3.Validate("Posting Type", PaymentMilestone2."Posting Type");
                PaymentMilestone3.Insert;
            UNTIL PaymentMilestone2.NEXT = 0;
        END;
        // PaymentMileStonePage.UpdateValueForSalesCreditMemo(SalesHeader_CrMemo_P."No.");
    end;
}

