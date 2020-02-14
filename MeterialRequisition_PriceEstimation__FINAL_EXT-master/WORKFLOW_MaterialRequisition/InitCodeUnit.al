codeunit 50003 IntiCodeunit
{
    trigger OnRun()
    begin

    end;

    [IntegrationEvent(false, false)]
    PROCEDURE OnSendMRforApproval(VAR MRHRec: Record "Material Requisition Header");
    begin
    end;

    [IntegrationEvent(False, false)]

    PROCEDURE OnCancelMRforApproval(VAR MRHRec: Record "Material Requisition Header");
    begin
    end;

    procedure IsMREnabled(var MRHRec: Record "Material Requisition Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit WFCode;
    begin
        exit(WFMngt.CanExecuteWorkflow(MRHRec, WFCode.RunWorkflowOnSendMRApprovalCode()))
    end;

    local procedure CheckWorkflowEnabled(): Boolean
    var
        MRHRec: Record "Material Requisition Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsMREnabled(MRHRec) then
            Error(NoWorkflowEnb);
    end;



    var
        myInt: Integer;
}