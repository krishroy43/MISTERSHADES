codeunit 50017 "Posting Transfer Order"
{
    trigger OnRun()
    begin

    end;
    // Start Gloabal Varialbe Section
    // Stop Gloabal Varialbe Section


    // Start Event and Function Section
    // Start Transfer Order to Shipment While posting
    /*
    below Event Subscriber for Transfer Header / Line to Transfer Shipment Header Line While 
    Posting.
    */


    [EventSubscriber(ObjectType::Table, 5744, 'OnAfterCopyFromTransferHeader', '', false, false)]
    local procedure TransferOrderPostShipmentL(var TransferShipmentHeader: Record "Transfer Shipment Header";
                                                TransferHeader: Record "Transfer Header")
    begin
        TransferShipmentHeader."Job No." := TransferHeader."Job No.";
        TransferShipmentHeader."Job description" := TransferHeader."Job description";
        TransferShipmentHeader."Job Task No" := TransferHeader."Job Task No";
        TransferShipmentHeader."Job Task Description" := TransferHeader."Job Task Description";
        TransferShipmentHeader.Receiver := TransferHeader.Creator;
        TransferShipmentHeader.Creator := TransferHeader.Receiver;
        //TransferShipmentHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnBeforeInsertTransShptLine', '', false, false)]
    local procedure OnAfterInsertTransShptLineL(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean)
    begin
        TransShptLine."Job No." := TransLine."Job No.";
        TransShptLine."Job description" := TransLine."Job description";
        TransShptLine."Job Task No" := TransLine."Job Task No";
        TransShptLine."Job Task Description" := TransLine."Job Task Description";
        TransShptLine."Requisition No." := TransLine."Requisition No.";
        //TransShptLine.Modify();
    end;
    // Stop Transfer Order to Shipment While posting
    // Start Transfer Order to Receipt While posting
    /*
    below Event Subscriber for Transfer Header / Line to Transfer Receipt Header Line While 
    Posting.
    */
    [EventSubscriber(ObjectType::Table, 5746, 'OnAfterCopyFromTransferHeader', '', false, false)]
    local procedure TransferOrderPostReceiptHeaderL(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."Job No." := TransferHeader."Job No.";
        TransferReceiptHeader."Job description" := TransferHeader."Job description";
        TransferReceiptHeader."Job Task No" := TransferHeader."Job Task No";
        TransferReceiptHeader."Job Task Description" := TransferHeader."Job Task Description";
        TransferReceiptHeader.Creator := TransferHeader.Creator;
        TransferReceiptHeader.Receiver := TransferHeader.Receiver;
        //TransferReceiptHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, 5705, 'OnBeforeInsertTransRcptLine', '', false, false)]
    local procedure MyProcedure(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean)
    begin
        TransRcptLine."Job No." := TransLine."Job No.";
        TransRcptLine."Job description" := TransLine."Job description";
        TransRcptLine."Job Task No" := TransLine."Job Task No";
        TransRcptLine."Job Task Description" := TransLine."Job Task Description";
        TransRcptLine."Requisition No." := TransLine."Requisition No.";
        //TransRcptLine.Modify();
    end;

    // Stop Transfer Order to Receipt While posting





    // Stop Event and Function Section











}