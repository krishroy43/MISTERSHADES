codeunit 50007 "Attachments Subcriber"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Page, 1173, 'OnAfterOpenForRecRef', '', false, false)]
    procedure OnAfterOpenForRecReffun(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        DocType: Option;
        LineNo: Integer;
    begin
        CASE RecRef.NUMBER OF
            DATABASE::"Material Requisition Header":
                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    DocumentAttachment.SETRANGE("No.", RecNo);
                    //FlowFieldsEditable := FALSE;
                END;
        END;
    end;

    // Start 23-07-2019
    [EventSubscriber(ObjectType::Codeunit, 96, 'OnAfterInsertPurchOrderLine', '', false, false)]
    procedure OnAfterInsertPurchOrderLine_LT(VAR PurchaseQuoteLine: Record "Purchase Line"; VAR PurchaseOrderLine: Record "Purchase Line")
    begin
        //PurchaseOrderLine.Validate("Outstanding Qty. (Base)", PurchaseQuoteLine."Outstanding Qty. (Base)");
        //PurchaseOrderLine.Validate();
    end;
    // Stop 23-07-2019

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesLines', '', false, false)]
    procedure OnAfterPostSalesLines(VAR SalesHeader: Record "Sales Header"; VAR SalesShipmentHeader: Record "Sales Shipment Header"; VAR SalesInvoiceHeader: Record "Sales Invoice Header"; VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    var ReturnReceiptHeader: Record "Return Receipt Header"; WhseShip: Boolean; WhseReceive: Boolean; var SalesLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean)
    begin
        //Message('%1', SalesHeader."Dispatch Type");
        SalesShipmentHeader."Dispatch Type" := SalesHeader."Dispatch Type";
        SalesShipmentHeader."Delivery Location" := SalesHeader."Delivery Location";
        // SalesShipmentHeader.Modify();
    end;










}