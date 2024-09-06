codeunit 71707003 "CRM Workflow Management"
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandlingExt: Codeunit "CRM Workflow event handling";
        NoWorflowEnabledErr: TextConst ENU = 'No approval workflow for this record is enabled';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance");
    var
        Camp: Record Campaign;
    begin
        case RecRef.Number of
            Database::Campaign:
                begin
                    RecRef.SetTable(Camp);
                    ApprovalEntryArgument."Document No." := Camp."No.";
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Campaign;
                end;
        end;
    end;
    //Campaign
    [IntegrationEvent(false, false)]
    procedure OnSendCampForApproval(var Camp: Record Campaign)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelCampApprovalRequest(var Camp: Record Campaign)
    begin

    end;

    procedure CheckCampApprovalWorflowEnabled(var Camp: Record Campaign): Boolean
    begin
        if not IsCampDocApprovalWorkflowEnabled(Camp) then
            Error(NoWorflowEnabledErr);
        exit(true);
    end;

    procedure IsCampDocApprovalWorkflowEnabled(var Camp: Record Campaign): Boolean
    begin
        if Camp.Status <> Camp.Status::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(Camp, WorkflowEventHandlingExt.RunWorkflowOnSendCampForApprovalCode));
    end;
}
