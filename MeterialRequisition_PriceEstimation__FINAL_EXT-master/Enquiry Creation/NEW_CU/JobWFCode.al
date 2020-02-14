codeunit 50009 WFJobCode
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendJobReq: TextConst ENU = 'Job Approval is requested', ENG = 'SS Approval Request for Job is requested';

        CancelJobReq: TextConst ENU = 'Job Approval Request is cancelled', ENG = 'SS Approval Request for Job is requested';
        AppReqJob: TextConst ENU = 'Job Approval Request is approved', ENG = 'SS Approval Request for Job is approved';
        RejReqJob: TextConst ENU = 'Job Approval Request is rejected', ENG = 'SS Approval Request for Job is rejected';
        DelReqJob: TextConst ENU = 'Job Approval Request is delegated', ENG = 'SS Approval Request for Job is delegated';
        SendForPendAppTxt: TextConst ENU = 'Job Status changed to Pending approval', ENG = 'Job Status changed to Pending approval';
        ReleaseJobTxt: TextConst ENU = 'Job Release ', ENG = 'Release Job';
        ReOpenJobTxt: TextConst ENU = 'Job ReOpen', ENG = 'ReOpen Job';

    procedure RunWorkflowOnSendJobApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendJobApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntJobCodeunit, 'OnSendJobforApproval', '', false, false)]
    procedure RunWorkflowOnSendJobApproval(var JobRec: Record Job)
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendJobApprovalCode(), JobRec);
    end;

    procedure RunWorkflowOnCancelJobApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelJobApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntJobCodeunit, 'OnCancelJobforApproval', '', false, false)]
    procedure RunWorkflowOnCancelJobApproval(var JobRec: Record Job)
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelJobApprovalCode(), JobRec);
    end;

    procedure RunWorkflowOnApproveJobApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveJobApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveJobApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveJobApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectJobApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectJobApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectJobApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectJobApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateJobApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateJobApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateJobApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateJobApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeJob(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalJob'));
    end;

    procedure SetStatusToPendingApprovalJob(var Variant: Variant)
    var
        RecRef: RecordRef;
        JobRec: Record Job;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::Job:
                begin
                    RecRef.SetTable(JobRec);

                    JobRec.Validate("Workflow Status", JobRec."Workflow Status"::"Pending for Approval");
                    JobRec.Modify();
                    Variant := JobRec;

                end;
        end;
    end;

    procedure ReleaseJobCode(): Code[128]
    begin
        exit(UpperCase('ReleaseJob'));
    end;

    procedure ReleaseJob(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        JobRec: Record Job;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseJob(Variant);
                end;
            DATABASE::Job:
                begin
                    RecRef.SetTable(JobRec);
                    JobRec.Validate("Workflow Status", JobRec."Workflow Status"::Released);
                    JobRec.Modify();
                    Variant := JobRec;
                end;
        end;
    end;

    procedure ReOpenJobCode(): Code[128]
    begin
        exit(UpperCase('ReOpenJob'));
    end;

    procedure ReOpenJob(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        JobRec: Record Job;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenJob(Variant);
                end;
            DATABASE::Job:
                begin
                    RecRef.SetTable(JobRec);
                    JobRec.Validate("Workflow Status", JobRec."Workflow Status"::Open);
                    JobRec.Modify();
                    Variant := JobRec;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddJobEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendJobApprovalCode(), Database::"job", SendJobReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelJobApprovalCode(), Database::"job", CancelJobReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveJobApprovalCode(), Database::"Approval Entry", AppReqJob, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectJobApprovalCode(), Database::"Approval Entry", RejReqJob, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateJobApprovalCode(), Database::"Approval Entry", DelReqJob, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddJobRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeJob(), 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseJobCode(), 0, ReleaseJobTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenJobCode(), 0, ReOpenJobTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForJob(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeJob():
                    begin
                        SetStatusToPendingApprovalJob(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseJobCode():
                    begin
                        ReleaseJob(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenJobCode():
                    begin
                        ReOpenJob(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;
}