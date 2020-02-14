codeunit 50008 IntJobCodeunit
{
    trigger OnRun()
    begin

    end;

    [IntegrationEvent(false, false)]
    PROCEDURE OnSendJobforApproval(VAR JobRec: Record Job)
    begin
    end;

    [IntegrationEvent(False, false)]

    PROCEDURE OnCancelJobforApproval(VAR JobRec: Record Job);
    begin
    end;

    procedure IsJobEnabled(var JobRec: Record Job): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit WFJobCode;
    begin
        exit(WFMngt.CanExecuteWorkflow(JobRec, WFCode.RunWorkflowOnSendJobApprovalCode()))
    end;

    local procedure CheckWorkflowEnabled(): Boolean
    var
        JobRec: Record Job;
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsJobEnabled(JobRec) then
            Error(NoWorkflowEnb);
    end;


    var
        myInt: Integer;
}