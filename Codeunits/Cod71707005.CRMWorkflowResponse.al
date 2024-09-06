codeunit 71707005 "CRM WorkflowResponse"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128]);
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEventHandlingExt: Codeunit "CRM Workflow event handling";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandlingExt.RunWorkflowOnSendCampForApprovalCode);
                end;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandlingExt.RunWorkflowOnSendCampForApprovalCode);

                end;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandlingExt.RunWorkflowOnCancelCampApprovalCode);

                end;
            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandlingExt.RunWorkflowOnCancelCampApprovalCode);

                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean);
    begin
        case RecRef.Number of
            database::Campaign:
                begin
                    RecRef.SetTable(Camp);
                    Camp.Status := Camp.Status::Open;
                    Camp.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean);
    begin
        case RecRef.Number of

            database::Campaign:
                begin
                    RecRef.SetTable(Camp);
                    Camp.Status := Camp.Status::"Pending Approval";
                    Camp.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean);
    begin
        case RecRef.Number of


            Database::Campaign:
                begin
                    RecRef.SetTable(Camp);
                    Camp.Status := Camp.Status::Approved;
                    CampaignMgmt.ActivateCampaign(Camp);
                    Camp.Modify();
                    Handled := true;
                end;
        end;
    end;

    var
        Camp: Record Campaign;
        CampNo: Code[100];
        CampaignMgmt: Codeunit "Campaign Target Group Mgt";
}
