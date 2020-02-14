codeunit 50016 "Event Publisher Sub."
{
    [EventSubscriber(ObjectType::Table, 37, 'OnAfterAssignFieldsForNo', '', false, false)]
    procedure OnAfterAssignFieldsForNoL(VAR SalesLine: Record "Sales Line"; VAR xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        SalesLine.Validate("Job No.", SalesHeader."Job No.");
        SalesLine.Validate("Job Task No.", SalesHeader."Job Task No");
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
            DATABASE::Opportunity:
                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    DocumentAttachment.SETRANGE("No.", RecNo);
                    //FlowFieldsEditable := FALSE;
                END;
        END;
    end;



}
