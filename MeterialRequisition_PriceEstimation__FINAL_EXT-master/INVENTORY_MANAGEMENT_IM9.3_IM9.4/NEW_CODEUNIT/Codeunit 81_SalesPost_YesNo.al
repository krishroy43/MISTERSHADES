codeunit 50005 Salespostyesno81

{
    // version NAVW111.00.00.24232

    EventSubscriberInstance = Manual;
    TableNo = 36;

    trigger OnRun();
    var
        SalesHeader: Record "Sales Header";
    begin
        IF NOT FIND THEN
            ERROR(NothingToPostErr);

        SalesHeader.COPY(Rec);
        Code(SalesHeader, FALSE);
        Rec := SalesHeader;

    end;

    var
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';
        ShipInvoiceQst2: Label '&Ship';
        PostConfirmQst: TextConst Comment = '%1 = Document Type', ENU = 'Do you want to post the %1?';
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        NothingToPostErr: Label 'There is nothing to post.';

    procedure PostAndSend(var SalesHeader: Record "Sales Header");
    var
        SalesHeaderToPost: Record "Sales Header";
    begin
        SalesHeaderToPost.COPY(SalesHeader);
        Code(SalesHeaderToPost, TRUE);
        SalesHeader := SalesHeaderToPost;
    end;

    local procedure "Code"(var SalesHeader: Record "Sales Header"; PostAndSend: Boolean);
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";
        HideDialog: Boolean;
    begin
        HideDialog := FALSE;

        OnBeforeConfirmSalesPost(SalesHeader, HideDialog);
        IF NOT HideDialog THEN
            IF NOT ConfirmPost(SalesHeader) THEN
                EXIT;

        SalesSetup.GET;
        IF SalesSetup."Post with Job Queue" AND NOT PostAndSend THEN
            SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
        ELSE
            CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);

        OnAfterPost(SalesHeader);
    end;

    local procedure ConfirmPost(var SalesHeader: Record "Sales Header"): Boolean;
    var
        Selection: Integer;
    begin
        WITH SalesHeader DO BEGIN
            CASE "Document Type" OF
                "Document Type"::Order:
                    BEGIN
                        Selection := STRMENU(ShipInvoiceQst2, 1);
                        Ship := Selection IN [1, 1];
                        // Invoice := Selection IN [2, 3];
                        IF Selection = 0 THEN
                            EXIT(FALSE);
                    END;

                "Document Type"::"Return Order":
                    BEGIN
                        Selection := STRMENU(ReceiveInvoiceQst, 3);
                        IF Selection = 0 THEN
                            EXIT(FALSE);
                        Receive := Selection IN [1, 3];
                        Invoice := Selection IN [2, 3];
                    END
                ELSE
                    IF NOT CONFIRM(PostConfirmQst, FALSE, LOWERCASE(FORMAT("Document Type"))) THEN
                        EXIT(FALSE);
            END;
            "Print Posted Documents" := FALSE;
        END;
        EXIT(TRUE);
    end;

    //    [Scope('Internal')]
    procedure Preview(var SalesHeader: Record "Sales Header");
    var
        SalesPostYesNo: Codeunit "Salespostyesno81";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
    begin
        BINDSUBSCRIPTION(SalesPostYesNo);
        GenJnlPostPreview.Preview(SalesPostYesNo, SalesHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPost(var SalesHeader: Record "Sales Header");
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 19, 'OnRunPreview', '', false, false)]
    local procedure OnRunPreview(var Result: Boolean; Subscriber: Variant; RecVar: Variant);
    var
        SalesHeader: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";
    begin
        WITH SalesHeader DO BEGIN
            COPY(RecVar);
            Receive := "Document Type" = "Document Type"::"Return Order";
            Ship := "Document Type" = "Document Type"::Order;
            Invoice := TRUE;
        END;
        SalesPost.SetPreviewMode(TRUE);
        Result := SalesPost.RUN(SalesHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean);
    begin
    end;
}

