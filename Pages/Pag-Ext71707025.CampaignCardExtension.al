pageextension 71707025 "Campaign Card Extension" extends "Campaign Card"
{

    layout
    {
        modify(General)
        {
            Editable = EditPage;
        }
        addafter("Salesperson Code")
        {
            field("Relationship Officer Name"; Rec."Relationship Officer Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Campaign Name"; Rec."Campaign Name")
            {
                ApplicationArea = All;
            }
        }
        addbefore(Activated)
        {
            field("Budget Name"; Rec."Budget Name")
            {
                ApplicationArea = All;
            }
            field("Available Budget"; Rec."Available Budget")
            {
                ApplicationArea = All;
            }
            field("Total Cost"; Rec."Total Cost")
            {
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }

        }

    }
    actions
    {

        modify("S&egments")
        {
            Caption = 'Marketing List';
        }
        modify(ActivateSalesPricesLineDisc)
        {
            Caption = 'Activate Campaign';
            Visible = false;
            trigger OnAfterAction()
            begin
                if (Rec.Status = Rec.Status::Open) and (Rec.Status = Rec.Status::"Pending Approval") then begin
                    Error('The Campaign has not been approved');
                end;
            end;
        }
        modify("&Deactivate Sales Prices/Line Discounts")
        {
            Caption = 'Deactivate Campaign';
        }
        addafter(ActivateSalesPricesLineDisc)
        {
            group("Approval")
            {

                action("Send Approval Request.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //Enabled = CanRequestApprovalForFlow and (Rec.Status = Rec.Status::Open);
                    trigger OnAction()
                    begin
                        Rec.TestField(Description);
                        Rec.TestField("Starting Date");
                        Rec.TestField("Ending Date");
                        Rec.TestField("Starting Date");
                        Rec.TestField("Salesperson Code");
                        if ApprovalsMgmt.CheckCampApprovalWorflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendCampForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request.")
                {
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Enabled = CanCancelApprovalForRecord;
                    //Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    trigger OnAction()
                    var
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        rec.TestField(Status, Rec.Status::"Pending Approval");
                        ApprovalsMgmt.OnCancelCampApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
                action("Approval Entries")
                {
                    Image = Approvals;
                    RunPageMode = View;
                    ApplicationArea = Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);

                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                        CurrPage.Close();
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                        CurrPage.Close();
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                        CurrPage.Close();

                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = (Rec.Status = Rec.Status::Approved);
                    trigger OnAction();
                    begin
                        if (Rec.Status = Rec.Status::Approved) then begin
                            if not Confirm('This will reopen document. Continue?', false) then
                                exit;
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                        end;

                    end;
                }
            }

        }
    }
    Local Procedure DrilldownApprovalEntries()
    Var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.FindSet() then begin
            PAGE.RunModal(PAGE::"Approval Entries", ApprovalEntry);
            CurrPage.Update(false);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmtExt: Codeunit "CRM Workflow management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        EditPage := false;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        // Make the page non-editable if Status is "Pending Approval" or "Approved"
        if (Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::Approved) then
            EditPage := false
        else
            EditPage := true;
    end;

    var
        ApprovalsMgmt: Codeunit "CRM Workflow management";
        DocumentIsPosted: Boolean;
        DocumentIsReleased: Boolean;
        SkipConfirmationDialogOnClosing: Boolean;
        StatusStyleTxt: Text;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        EditPage: Boolean;
        CanRejectApprovalForFlow: Boolean;
        CanRejectApprovalForRecord: Boolean;
        CampNo: Code[100];
        IsEditable: Boolean;
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        CRMSetup: Record "CRM No Series Setup";
        AvailableBudget: Decimal;

}
