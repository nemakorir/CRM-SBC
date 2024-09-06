codeunit 71707004 "CRM Workflow event handling"
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        SendCampForApprovalEventDescTxt: TextConst ENU = 'Approval for an Campaign is requested';
        CancelApprovalForCampEventDescTxt: TextConst ENU = 'Approval for an Campaign is cancelled';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibrary();
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendCampForApprovalCode(), Database::Campaign, SendCampForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCampApprovalCode(), Database::Campaign, CancelApprovalForCampEventDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128]);
    begin
        case EventFunctionName of
            RunWorkflowOnCancelCampApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelCampApprovalCode, RunWorkflowOnSendCampForApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendCampForApprovalCode);
                end;

            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendCampForApprovalCode);
                end;

            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendCampForApprovalCode);
                end;
        end;
    end;

    //collateral edit
    procedure RunWorkflowOnSendCampForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendCampForApproval'));
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Workflow Management", 'OnSendCampForApproval', '', true, true)]
    local procedure RunWorkflowOnSendCampForApproval(var Camp: Record Campaign);
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendCampForApprovalCode(), Camp);
    end;

    procedure RunWorkflowOnCancelCampApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelCampApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Workflow management", 'OnCancelCampApprovalRequest', '', true, true)]
    local procedure RunWorkflowOnCancelCampApprovalRequest(var Camp: Record Campaign);
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelCampApprovalCode(), Camp);
    end;


}
