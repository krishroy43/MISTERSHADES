codeunit 50004 WFCode
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendMRReq: TextConst ENU = 'Material Requisition Request is requested', ENG = 'SS Approval Request for Job is requested';

        CancelMRReq: TextConst ENU = 'Material Requisition Request is cancelled', ENG = 'SS Approval Request for Job is requested';
        AppReqMR: TextConst ENU = 'Material Requisition Approval Request is approved', ENG = 'SS Approval Request for Job is approved';
        RejReqMR: TextConst ENU = 'Material Requisition Approval Request is rejected', ENG = 'SS Approval Request for Job is rejected';
        DelReqMR: TextConst ENU = 'Material Requisition Approval Request is delegated', ENG = 'SS Approval Request for Job is delegated';
        SendForPendAppTxt: TextConst ENU = 'Material Requisition Status changed to Pending approval', ENG = 'SS Status of Job changed to Pending approval';
        ReleaseMRTxt: TextConst ENU = 'MR Release ', ENG = 'Release Job';
        ReOpenMRTxt: TextConst ENU = 'MR ReOpen', ENG = 'ReOpen Job';

    procedure RunWorkflowOnSendMRApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMRApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntiCodeunit, 'OnSendMRforApproval', '', false, false)]
    procedure RunWorkflowOnSendMRApproval(var MRHRec: Record "Material Requisition Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendMRApprovalCode(), MRHRec);
    end;

    procedure RunWorkflowOnCancelMRApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMRApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntiCodeunit, 'OnCancelMRforApproval', '', false, false)]
    procedure RunWorkflowOnCancelMRApproval(var MRHRec: Record "Material Requisition Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelMRApprovalCode(), MRHRec);
    end;

    procedure RunWorkflowOnApproveMRApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveMRApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveMRApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveMRApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectMRApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectMRApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectMRApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectMRApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateMRApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateMRApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateMRApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateMRApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeMR(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalMR'));
    end;

    procedure SetStatusToPendingApprovalMR(var Variant: Variant)
    var
        RecRef: RecordRef;
        MRHRec: Record "Material Requisition Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Material Requisition Header":
                begin
                    RecRef.SetTable(MRHRec);
                    MRHRec.Validate(Status, MRHRec.Status::"Pending Approval");
                    MRHRec.Modify();
                    Variant := MRHRec;
                end;
        end;
    end;

    procedure ReleaseMRCode(): Code[128]
    begin
        exit(UpperCase('ReleaseMR'));
    end;

    procedure ReleaseMR(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        MRHRec: Record "Material Requisition Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseMR(Variant);
                end;
            DATABASE::"Material Requisition Header":
                begin
                    RecRef.SetTable(MRHRec);
                    MRHRec.Validate(Status, MRHRec.Status::Released);
                    MRHRec.Modify();
                    Variant := MRHRec;
                end;
        end;
    end;

    procedure ReOpenMRCode(): Code[128]
    begin
        exit(UpperCase('ReOpenMR'));
    end;

    procedure ReOpenMR(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        MRHRec: Record "Material Requisition Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenMR(Variant);
                end;
            DATABASE::"Material Requisition Header":
                begin
                    RecRef.SetTable(MRHRec);
                    MRHRec.Validate(Status, MRHRec.Status::Open);
                    MRHRec.Modify();
                    Variant := MRHRec;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddMREventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendMRApprovalCode(), 50005, SendMRReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMRApprovalCode(), 50005, CancelMRReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveMRApprovalCode(), Database::"Approval Entry", AppReqMR, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectMRApprovalCode(), Database::"Approval Entry", RejReqMR, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateMRApprovalCode(), Database::"Approval Entry", DelReqMR, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddMRRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeMR(), 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseMRCode(), 0, ReleaseMRTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenMRCode(), 0, ReOpenMRTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForJob(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeMR():
                    begin
                        SetStatusToPendingApprovalMR(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseMRCode():
                    begin
                        ReleaseMR(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenMRCode():
                    begin
                        ReOpenMR(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


}