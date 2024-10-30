page 71707001 "Case Card"
{
    Caption = 'Case Card';
    PageType = Card;
    SourceTable = "Case";
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Navigate,Customer';
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = IsInProgress;
                field("Service No."; Rec."Service No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service No. field.', Comment = '%';
                }
                field("Date Recorded"; Rec."Date Recorded")
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Initiator Type"; Rec."Case Initiator Type")
                {
                    ApplicationArea = All;
                }
                field("Initiator Code"; Rec."Case Initiator Code")
                {
                    ApplicationArea = All;
                }
                field("Initiator Name"; Rec."Case Initiator Name")
                {
                    ApplicationArea = All;
                }
                field(IsExistingCustomer; Rec.IsExistingCustomer)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SetEditableFields();
                        ClearFields();
                    end;

                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                    Editable = IsCustomer;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';

                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.', Comment = '%';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Relationship Officer Name"; Rec."Relationship Officer Name")
                {
                    ApplicationArea = All;
                }
                field("Case Type"; Rec."Case Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    ShowMandatory = true;
                    MultiLine = true;
                }
                field("Mode of Contact"; Rec."Mode of Contact")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Nature of Service"; Rec."Nature of Service")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Department assigned"; Rec."Department assigned")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Dept Email address"; Rec."E mail address")
                {
                    ApplicationArea = All;
                }
                field("Response Type"; Rec."Response Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Name field.', Comment = '%';
                    Editable = IsNotCustomer;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("IsClosed?"; Rec."IsClosed?")
                {
                    ApplicationArea = All;
                }
                field("Is Hold?"; Rec.Hold)
                {
                    ApplicationArea = All;
                }
                field("IsReleased?"; Rec."IsReleased?")
                {
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = All;
                }
                field("Response Time (Hours)"; Rec."Response Time (Hours)")
                {
                    ApplicationArea = All;
                }
                field(Resolved; Rec.Resolved)
                {
                    ApplicationArea = All;
                }
                field("Resolved Date"; Rec."Resolved Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Email Thread ID"; Rec."Email Thread ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            part("Svr Rel Header Lines"; "Svr Rel Header Lines")
            {
                Caption = 'Case TAT Logs';
                ApplicationArea = All;
                SubPageLink = "Service No." = field("Service No.");
            }
            group("CX Department")
            {
                field("CX Department Comments"; Rec."CX Department Comments")
                {
                    ApplicationArea = All;
                    Editable = IsInCX;
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();

                    end;
                }
                field("Employee No.(CX)"; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = IsInCX;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                    end;
                }
                field("Employee Name(CX)"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Response Date/Time(CX)"; Rec."Response Date/Time(CX)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }
            group("BD Department")
            {
                field("BD Department Comments "; Rec."BD Department Comments")
                {
                    ApplicationArea = All;
                    Editable = IsInBD;
                    Visible = true;
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                        
                    end;
                }
                field("Employee No.(BD)"; Rec."Employee No(BD).")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = IsInBD;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                    end;
                }
                field("Employee Name(BD)"; Rec."Employee Name(BD)")
                {
                    ApplicationArea = All;
                }
                field("Response Date/Time(BD)"; Rec."Response Date/Time(BD)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }
            group("Credit Department")
            {
                field("Credit Department Comments "; Rec."Credit Department Comments ")
                {
                    ApplicationArea = All;
                    Editable = IsInCredit;
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                       
                    end;
                }
                field("Employee No.(CREDIT)"; REC."Employee No(CREDIT).")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = IsInCredit;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                    end;
                }
                field("Employee Name(CREDIT)"; Rec."Employee Name(CREDIT)")
                {
                    ApplicationArea = All;
                }
                field("Response Date/Time(CREDIT)"; Rec."Response Date/Time(CREDIT)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }
            group("Finance Department")
            {
                field("Finance Department Comments "; Rec."Finance Department Comments")
                {
                    ApplicationArea = All;
                    Editable = IsInFinance;
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                        
                    end;
                }
                field("Employee No.(FIN)"; Rec."Employee No(FINANCE).")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = IsInFinance;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                    end;
                }
                field("Employee Name(FIN)"; Rec."Employee Name(FINANCE)")
                {
                    ApplicationArea = All;
                }
                field("Response Date/Time(FINANCE)"; Rec."Response Date/Time(FINANCE)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }
            group("ICT Department")
            {
                field("ICT Department Comments "; Rec."ICT Department Comments ")
                {
                    ApplicationArea = All;
                    Editable = IsInICT;
                    Visible = true;
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                       
                    end;
                }
                field("Employee No.(ICT)"; Rec."Employee No(ICT).")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = IsInICT;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                    end;
                }
                field("Employee Name(ICT)"; Rec."Employee Name(ICT)")
                {
                    ApplicationArea = All;
                }
                field("Response Date/Time(ICT)"; Rec."Response Date/Time(ICT)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }

            group("HR Department")
            {
                field("HR Department Comments "; Rec."HR Department Comments ")
                {
                    ApplicationArea = All;
                    Editable = IsInHR;
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                        
                    end;
                }
                field("Employee No.(HR)"; Rec."Employee No(HR).")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = IsInHR;
                    trigger OnValidate()
                    begin
                        UpdateSvrRelLineComments();
                    end;
                }
                field("Employee Name(HR)"; Rec."Employee Name(HR)")
                {
                    ApplicationArea = All;
                }
                field("Response Date/Time(HR)"; Rec."Response Date/Time(HR)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }

        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
            }
            systempart(Control9; MyNotes)
            {
            }
            systempart(Control8; Links)
            {
            }
            part("Service Statistics Factbox"; "Member Statistic FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Customer No.");
            }
        }


    }
    actions
    {
        area(Navigation)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
        area(Processing)
        {
            group(Escalate)
            {
                action(CX)
                {
                    ApplicationArea = All;
                    Caption = 'CX';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    begin
                        CaseNo := Rec."Service No.";
                        if Rec.Hold = false then begin
                            if Rec."IsClosed?" = false then begin
                                Rec.TestField(Rec.Description);
                                Rec.TestField(Rec."Case Type");
                                Rec.TestField(Rec."Mode of Contact");
                                Rec.TestField(Rec."Nature of Service");
                                Rec.TestField(Rec."Response Type");
                                if Rec.Stage = rec.Stage::Open then begin
                                    CalculateFirstDuration();
                                end;
                                if Rec.Stage = Rec.Stage::"In Progress" then begin
                                    CalculateDuration();
                                end;

                                Rec.Status := Rec.Status::CX;
                                Rec.Stage := rec.Stage::"In Progress";
                                SendEmail.EraseComments(CaseNo);
                                Commit();
                                SetEditableFields();
                                CurrPage.Update();
                                //Log SvrLine Dep line
                                CaseManagement.UpdateDepartmentAssigned(CaseNo);
                                //Asing Dept and email
                                SendEmail.DeptToEscalateTo(CaseNo);
                                //Send Email;
                                SendEmail.CaseEscalation(CaseNo);
                                
                            end else begin
                                Error('The case Is closed');
                            end;
                        end else begin
                            Error('The current ticket is on hold');
                        end;
                    end;
                }
                action(BD)
                {
                    ApplicationArea = All;
                    Caption = 'BD';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    begin
                        CaseNo := Rec."Service No.";
                        if Rec.Hold = false then begin
                            if Rec."IsClosed?" = false then begin
                                Rec.TestField(Rec.Description);
                                Rec.TestField(Rec."Case Type");
                                Rec.TestField(Rec."Mode of Contact");
                                Rec.TestField(Rec."Nature of Service");
                                Rec.TestField(Rec."Response Type");
                                if Rec.Stage = rec.Stage::Open then begin
                                    CalculateFirstDuration();
                                end;
                                if Rec.Stage = Rec.Stage::"In Progress" then begin
                                    CalculateDuration();
                                end;
                                Rec.Status := Rec.Status::BD;
                                Rec.Stage := rec.Stage::"In Progress";
                               SendEmail.EraseComments(CaseNo);
                                //Message('Stage To Escalate To:%1', Rec.Status);
                                Commit();
                                SetEditableFields();
                                CurrPage.Update();
                                //Log SvrLine Dep line
                                CaseManagement.UpdateDepartmentAssigned(CaseNo);
                                //Asing Dept and email
                                SendEmail.DeptToEscalateTo(CaseNo);
                                //Message('Dept To Asigned To:%1', Rec."Department assigned");
                                //Send Email;
                                SendEmail.CaseEscalation(CaseNo);
                            end else begin
                                Error('The case Is closed');
                            end;
                        end else begin
                            Error('The current ticket is on hold');
                        end;
                    end;
                }
                action(Credit)
                {
                    ApplicationArea = All;
                    Caption = 'Credit';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    begin
                        CaseNo := Rec."Service No.";
                        if Rec.Hold = false then begin
                            if Rec."IsClosed?" = false then begin
                                Rec.TestField(Rec.Description);
                                Rec.TestField(Rec."Case Type");
                                Rec.TestField(Rec."Mode of Contact");
                                Rec.TestField(Rec."Nature of Service");
                                Rec.TestField(Rec."Response Type");
                                if Rec.Stage = rec.Stage::Open then begin
                                    CalculateFirstDuration();
                                end;
                                if Rec.Stage = Rec.Stage::"In Progress" then begin
                                    CalculateDuration();
                                end;
                                Rec.Status := Rec.Status::Credit;
                                Rec.Stage := rec.Stage::"In Progress";
                                 SendEmail.EraseComments(CaseNo);
                                Commit();
                                SetEditableFields();
                                CurrPage.Update();
                                //Log SvrLine Dep line
                                CaseManagement.UpdateDepartmentAssigned(CaseNo);
                                //Asing Dept and email
                                SendEmail.DeptToEscalateTo(CaseNo);
                                //Message('Dept To Asigned To:%1', Rec."Department assigned");
                                //Send Email;
                                SendEmail.CaseEscalation(CaseNo);
                            end else begin
                                Error('The case Is closed');
                            end;
                        end else begin
                            Error('The current ticket is on hold');
                        end;

                    end;
                }
                action(Finance)
                {
                    ApplicationArea = All;
                    Caption = 'Finance';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    begin
                        CaseNo := Rec."Service No.";
                        if Rec.Hold = false then begin
                            if Rec."IsClosed?" = false then begin
                                Rec.TestField(Rec.Description);
                                Rec.TestField(Rec."Case Type");
                                Rec.TestField(Rec."Mode of Contact");
                                Rec.TestField(Rec."Nature of Service");
                                Rec.TestField(Rec."Response Type");
                                if Rec.Stage = rec.Stage::Open then begin
                                    CalculateFirstDuration();
                                end;
                                if Rec.Stage = Rec.Stage::"In Progress" then begin
                                    CalculateDuration();
                                end;
                                Rec.Status := Rec.Status::Finance;
                                Rec.Stage := rec.Stage::"In Progress";
                                 SendEmail.EraseComments(CaseNo);
                                Commit();
                                SetEditableFields();
                                CurrPage.Update();
                                //Log SvrLine Dep line
                                CaseManagement.UpdateDepartmentAssigned(CaseNo);
                                //Assing Dept and email
                                SendEmail.DeptToEscalateTo(CaseNo);
                                //Send Email;
                                SendEmail.CaseEscalation(CaseNo);
                            end else begin
                                Error('The case Is closed');
                            end;
                        end else begin
                            Error('The current ticket is on hold');
                        end;
                    end;
                }

                action(ICT)
                {
                    ApplicationArea = All;
                    Caption = 'ICT';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    begin
                        CaseNo := Rec."Service No.";
                        if Rec.Hold = false then begin
                            if Rec."IsClosed?" = false then begin
                                Rec.TestField(Rec.Description);
                                Rec.TestField(Rec."Case Type");
                                Rec.TestField(Rec."Mode of Contact");
                                Rec.TestField(Rec."Nature of Service");
                                Rec.TestField(Rec."Response Type");
                                if Rec.Stage = rec.Stage::Open then begin
                                    CalculateFirstDuration();
                                end;
                                if Rec.Stage = Rec.Stage::"In Progress" then begin
                                    CalculateDuration();
                                end;
                                Rec.Status := Rec.Status::ICT;
                                Rec.Stage := rec.Stage::"In Progress";
                                 SendEmail.EraseComments(CaseNo);
                                Commit();
                                SetEditableFields();
                                CurrPage.Update();
                                //Log SvrLine Dep line
                                CaseManagement.UpdateDepartmentAssigned(CaseNo);
                                //Assing Dept and email
                                SendEmail.DeptToEscalateTo(CaseNo);
                                //Send Email;       
                                SendEmail.CaseEscalation(CaseNo);
                            end else begin
                                Error('The case Is closed');
                            end;
                        end else begin
                            Error('The current ticket is on hold');
                        end;
                    end;
                }
                action(HR)
                {
                    ApplicationArea = All;
                    Caption = 'HR';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    begin
                        CaseNo := Rec."Service No.";
                        if Rec.Hold = false then begin
                            if Rec."IsClosed?" = false then begin
                                Rec.TestField(Rec.Description);
                                Rec.TestField(Rec."Case Type");
                                Rec.TestField(Rec."Mode of Contact");
                                Rec.TestField(Rec."Nature of Service");
                                Rec.TestField(Rec."Response Type");
                                if Rec.Stage = rec.Stage::Open then begin
                                    CalculateFirstDuration();
                                end;
                                if Rec.Stage = Rec.Stage::"In Progress" then begin
                                    CalculateDuration();
                                end;
                                Rec.Status := Rec.Status::HR;
                                Rec.Stage := rec.Stage::"In Progress";
                                 SendEmail.EraseComments(CaseNo);
                                Commit();
                                SetEditableFields();
                                CurrPage.Update();
                                //Log SvrLine Dep line
                                CaseManagement.UpdateDepartmentAssigned(CaseNo);
                                //Assing Dept and email
                                SendEmail.DeptToEscalateTo(CaseNo);
                                //Send Email; 
                                SendEmail.CaseEscalation(CaseNo);
                            end else begin
                                Error('The case Is closed');
                            end;
                        end else begin
                            Error('The current ticket is on hold');
                        end;
                    end;
                }
                action(Hold)
                {
                    ApplicationArea = All;
                    Caption = 'Hold';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    var
                        UserAction: Action;
                        NewLineNo: Integer;
                    begin
                        if Rec.Stage = Rec.Stage::"In Progress" then begin
                            if Rec.Hold = false then begin
                                if Rec."IsClosed?" = false then begin
                                    UserAction := CommentDialogPage.RunModal();
                                    if UserAction = ACTION::OK then begin
                                        Comment := CommentDialogPage.GetComment();
                                        SvrRelLine.SetRange("Service No.", Rec."Service No.");
                                        if SvrRelLine.FindLast() then begin
                                            //SvrRelLine.TestField(Comments);
                                            SvrRelLine.TestField("Employee Name");
                                            SvrRelLine."Escalation End Date" := CurrentDateTime;
                                            SvrRelLine.Comments := Comment;
                                            SvrRelLine.Duration := CurrentDateTime - SvrRelLine."Start Date";
                                            SvrRelLine.Modify();
                                            NewLineNo := SvrRelLine."Line No." + 1;
                                        end
                                        else
                                            Error('No existing records found to base the new Line No. on.');
                                        SvrRelLine.Init();
                                        SvrRelLine."Line No." := NewLineNo;
                                        SvrRelLine."Service No." := Rec."Service No.";
                                        SvrRelLine."Department assigned" := 'HOLD';
                                        SvrRelLine."Start Date" := CurrentDateTime;
                                        SvrRelLine.Comments := Comment;
                                        SvrRelLine."User ID" := UserId;
                                        SvrRelLine.Insert(true);
                                        Rec.Hold := true;
                                        Rec."IsReleased?" := false;
                                        Rec.Remarks := Comment;
                                        CurrPage.Update();
                                        //Send Email
                                        SendEmail.CaseEscalation(CaseNo);
                                    end;
                                end else begin
                                    Error('The case Is closed');
                                end;
                            end else begin
                                Error('The case Is already on hold');
                            end;
                        end else begin
                            Error('You can only hold a case which is in progress');
                        end;
                    end;
                }
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category7;
                    Enabled = Rec.Hold = Rec.Hold = true;
                    trigger OnAction()
                    var
                        UserAction: Action;
                        NewLineNo: Integer;
                    begin
                        CaseNo := Rec."Service No.";
                        if Rec.Stage = Rec.Stage::"In Progress" then begin
                            if Rec.Hold = true then begin
                                if Rec."IsClosed?" = false then begin
                                    UserAction := CommentDialogPage.RunModal();
                                    if UserAction = ACTION::OK then begin
                                        Comment := CommentDialogPage.GetComment();
                                        SvrRelLine.SetRange("Service No.", Rec."Service No.");
                                        SvrRelLine.SetRange("Department assigned", 'HOLD');
                                        if SvrRelLine.FindLast() then begin
                                            //SvrRelLine.Remarks := Comment;
                                            SvrRelLine.TestField("Employee Name");
                                            SvrRelLine."Escalation End Date" := CurrentDateTime;
                                            SvrRelLine.Comments := Comment;
                                            SvrRelLine.Duration := CurrentDateTime - SvrRelLine."Start Date";
                                            SvrRelLine.Modify();
                                            NewLineNo := SvrRelLine."Line No." + 1;
                                        end
                                        else
                                            Error('No existing records found to base the new Line No. on.');
                                        SvrRelLine.Init();
                                        SvrRelLine."Line No." := NewLineNo;
                                        SvrRelLine."Service No." := Rec."Service No.";
                                        SvrRelLine."Department assigned" := 'RELEASED';
                                        SvrRelLine."Start Date" := CurrentDateTime;
                                        SvrRelLine.Comments := Comment;
                                        SvrRelLine."User ID" := UserId;
                                        SvrRelLine.Insert(true);
                                        Rec."IsReleased?" := true;
                                        Rec.Hold := false;
                                        Rec.Remarks := Comment;
                                        CurrPage.Update();
                                        //Send Email
                                        SendEmail.CaseEscalation(CaseNo);
                                    end;
                                end else begin
                                    Error('You cannot release a case once closed');
                                end;
                            end else begin
                                Error('You can only release a case which is on hold');
                            end;
                        end else begin
                            Error('You can only release a case which is in progress');
                        end;
                    end;
                }
                action(Resolve)
                {
                    ApplicationArea = All;
                    Caption = 'Resolve';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    var
                        UserAction: Action;
                        NewLineNo: Integer;
                    begin
                        CaseNo := Rec."Service No.";
                        if Rec.Stage = Rec.Stage::"In Progress" then begin
                            if Rec.Hold = false then begin
                                if Rec."IsClosed?" = false then begin
                                    UserAction := CommentDialogPage.RunModal();
                                    if UserAction = ACTION::OK then begin
                                        Comment := CommentDialogPage.GetComment();
                                        SvrRelLine.SetRange("Service No.", Rec."Service No.");
                                        if SvrRelLine.FindLast() then begin
                                            //SvrRelLine.TestField(Comments);
                                            SvrRelLine.TestField("Employee Name");
                                            SvrRelLine.Resolved := true;
                                            SvrRelLine."Escalation End Date" := CurrentDateTime;
                                            SvrRelLine.Comments := Comment;
                                            SvrRelLine.Duration := CurrentDateTime - SvrRelLine."Start Date";
                                            SvrRelLine."Resolved Date" := CurrentDateTime;
                                            SvrRelLine.Remarks := Comment;
                                            SvrRelLine.Modify();
                                            Rec.Resolved := true;
                                            Rec."Resolved Date" := CurrentDateTime;
                                            Rec."IsReleased?" := false;
                                            Rec.Remarks := SvrRelLine.Remarks;
                                        end;
                                        UserSetup.SetRange("User ID", Rec."Created By");
                                        if UserSetup.FindFirst() then begin
                                            if UserSetup."Station/Department" = UserSetup."Station/Department"::"Business Development" then begin
                                                Rec.Status := Rec.Status::BD;
                                                Rec."Department assigned" := Format(UserSetup."Station/Department");
                                            end;
                                            if UserSetup."Station/Department" = UserSetup."Station/Department"::Credit then begin
                                                Rec.Status := Rec.Status::Credit;
                                                Rec."Department assigned" := Format(UserSetup."Station/Department");
                                            end;
                                            if UserSetup."Station/Department" = UserSetup."Station/Department"::Finance then begin
                                                Rec.Status := Rec.Status::Finance;
                                                Rec."Department assigned" := Format(UserSetup."Station/Department");
                                            end;
                                            if UserSetup."Station/Department" = UserSetup."Station/Department"::CX then begin
                                                Rec.Status := Rec.Status::CX;
                                                Rec."Department assigned" := Format(UserSetup."Station/Department");
                                            end;
                                            if UserSetup."Station/Department" = UserSetup."Station/Department"::ICT then begin
                                                Rec.Status := Rec.Status::ICT;
                                                Rec."Department assigned" := Format(UserSetup."Station/Department");
                                            end;
                                            if UserSetup."Station/Department" = UserSetup."Station/Department"::HR then begin
                                                Rec.Status := Rec.Status::HR;
                                                Rec."Department assigned" := Format(UserSetup."Station/Department");
                                            end;
                                        end;
                                        CurrPage.Update();
                                        CaseManagement.UpdateDepartmentAssigned(CaseNo);
                                        //Assing Dept and email
                                        SendEmail.DeptToEscalateTo(CaseNo);
                                        //Send Email
                                        SendEmail.CaseEscalation(CaseNo);
                                    end;
                                end else begin
                                    Error('The case Is closed');
                                end;
                            end
                            else begin
                                Error('The case Is on hold');
                            end;
                        end else begin
                            Error('You can only resolve a case which is in progress');
                        end;
                    end;
                }
                action(Close)
                {
                    ApplicationArea = All;
                    Caption = 'Close';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category7;
                    Enabled = IsCloseActionVisible;
                    trigger OnAction()
                    var
                        SvrHeader: Record "Case";
                        SvrRelHeaderLine: Record "Case Lines";
                        ResponseTimeInMinutes: Duration;
                        DateRecorded: DateTime;
                        DateClosed: DateTime;
                        ResponseTimeMinutes: Duration;
                        UserAction: Action;
                        NewLineNo: Integer;
                    begin
                        CaseNo := Rec."Service No.";
                        if Rec.Status = Rec.Status::Closed then begin
                            Error('The case is already closed');
                        end;
                        if Rec.Stage = Rec.Stage::"In Progress" then begin
                            if Rec.Hold = false then begin
                                UserAction := CommentDialogPage.RunModal();
                                if UserAction = ACTION::OK then begin
                                    Comment := CommentDialogPage.GetComment();
                                    SvrRelLine.SetRange("Service No.", Rec."Service No.");
                                    if SvrRelLine.FindLast() then begin
                                        //SvrRelLine.TestField(Comments);
                                        SvrRelLine.TestField("Employee Name");
                                        SvrRelLine."Escalation End Date" := CurrentDateTime;
                                        SvrRelLine.Comments := Comment;
                                        SvrRelLine.Duration := CurrentDateTime - SvrRelLine."Start Date";
                                        SvrRelLine.Remarks := Comment;
                                        SvrRelLine.Modify();
                                        NewLineNo := SvrRelLine."Line No." + 1;
                                    end
                                    else
                                        Error('No existing records found to base the new Line No. on.');
                                    SvrRelLine.Init();
                                    SvrRelLine."Line No." := NewLineNo;
                                    SvrRelLine."Service No." := Rec."Service No.";
                                    SvrRelLine."Department assigned" := 'CLOSED';
                                    SvrRelLine."Start Date" := CurrentDateTime;
                                    SvrRelLine."Escalation End Date" := CurrentDateTime;
                                    SvrRelLine.Duration := CurrentDateTime - SvrRelLine."Start Date";
                                    SvrRelLine.Comments := Comment;
                                    SvrRelLine."User ID" := UserId;
                                    SvrRelLine.Insert(true);

                                    DateRecorded := Rec."Date Recorded";
                                    Rec.Stage := rec.Stage::Closed;
                                    DateClosed := CurrentDateTime;
                                    ResponseTimeInMinutes := DateClosed - DateRecorded;
                                    Message('ResponseTimeInMinutes:%1', ResponseTimeInMinutes);
                                    Rec."Response Time (Hours)" := ResponseTimeInMinutes;
                                    Rec.Status := rec.Status::Closed;
                                    Rec."IsClosed?" := true;
                                    Rec.Resolved := false;
                                    Rec."Date Closed" := CurrentDateTime;
                                    Rec."Closed By" := UserId;
                                    Rec.Remarks := Comment;
                                    CurrPage.Update();
                                    //Assing Dept and email
                                    //SendEmail.DeptToEscalateTo(CaseNo);
                                    //Send Email
                                    SendEmail.CaseEscalation(CaseNo);

                                end;
                            end else begin
                                Error('The current ticket is on hold');
                            end;
                        end else begin
                            Error('You can only close a case in progress');
                        end;
                    end;
                }
            }
        }
    }

    local procedure CaseEscalation(CaseNo: code[100])

    begin
        URL := 'http://192.168.137.115:8080/BC200/';
        SvrHeader.SetRange("Service No.", CaseNo);
        Message('SendEmail.CaseEscalation called successfully:%1', CaseNo);

        if SvrHeader.FindFirst() then begin
            RecipientEmailAddress := SvrHeader."E mail address";

            if SvrHeader."IsReleased?" then begin
                UserSetup.SetRange("User ID", SvrHeader."Created By");
                if UserSetup.FindFirst() then begin
                    DeptReassign.SetRange(DimensionCode, UpperCase(Format((UserSetup."Station/Department"))));
                    if DeptReassign.FindFirst() then begin
                        ReassignedDeptEmail := DeptReassign."Email Address";
                        RecipientEmailAddress := RecipientEmailAddress + ';' + ReassignedDeptEmail;
                    end;
                end;
            end;

            Subject := SvrHeader."Service No." + ' ' + SvrHeader.Name + ' ' + Format(SvrHeader."Case Type");
            if SvrHeader."IsClosed?" then begin
                Message('IsClosed:%1', SvrHeader."IsClosed?");
                Body := SvrHeader."Service No." + ' has been closed: ' + SvrHeader.Remarks + ' ' + URL;
            end;

            EmailMessage.Create(RecipientEmailAddress, Subject, Body);
            IsSent := Email.Send(EmailMessage, Enum::"Email Scenario"::"BC Auto Notfications");
            if IsSent then
                Message('Email sent successfully.')
            else begin
                ErrorMessage := GetLastErrorText();
                Message('Failed to send email. Error: %1', ErrorMessage);
            end;
        end;
    end;

    procedure CalculateDuration()
    begin
        SvrRelLine.SetRange("Service No.", Rec."Service No.");
        SvrRelLine.SetRange("Department assigned", Rec."Department assigned");
        IF SvrRelLine.FindLast() then begin
            SvrRelLine.TestField(Comments);
            SvrRelLine.TestField("Employee Name");
            SvrRelLine."Escalation End Date" := CurrentDateTime;
            ResponseTimeMinutes := SvrRelLine."Escalation End Date" - SvrRelLine."Start Date";
            SvrRelLine.Duration := ResponseTimeMinutes;
            SvrRelLine.Modify();
        end;

    end;

    procedure CalculateFirstDuration()
    begin
        SvrRelLine.SetRange("Service No.", Rec."Service No.");
        IF SvrRelLine.FindFirst() then begin
            SvrRelLine.TestField(Comments);
            SvrRelLine.TestField("Employee Name");
            SvrRelLine."Escalation End Date" := CurrentDateTime;
            ResponseTimeMinutes := SvrRelLine."Escalation End Date" - SvrRelLine."Start Date";
            SvrRelLine.Duration := ResponseTimeMinutes;
            SvrRelLine.Modify();
        end;
    end;

    procedure SetEditableFields();
    begin
        IsInCX := Rec.Status = Rec.Status::CX;
        IsInCredit := Rec.Status = Rec.Status::Credit;
        IsInFinance := Rec.Status = Rec.Status::Finance;
        IsInHR := Rec.Status = Rec.Status::HR;
        IsInBD := Rec.Status = Rec.Status::BD;
        IsInICT := Rec.Status = Rec.Status::ICT;
        IsCustomer := Rec.IsExistingCustomer = true;
        IsNotCustomer := Rec.IsExistingCustomer = false;
    end;

    procedure ClearFields()
    begin
        if Rec.IsExistingCustomer = false then begin
            Rec."Customer No." := '';
            Rec.Name := '';
            Rec."E-Mail" := '';
            Rec."Phone No." := '';
            Rec."Branch Code" := '';
            Rec."Relationship Officer Code" := '';
            Rec."Relationship Officer Name" := '';
        end;
    end;

    

    trigger OnOpenPage();
    begin
        SetEditableFields();
        CalculateHoldDuration();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec.IsExistingCustomer = true then begin
            IsCustomer := true;
        end;
        if Rec.IsExistingCustomer = false then begin
            IsNotCustomer := true;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.IsExistingCustomer = true then begin
            IsCustomer := true;
        end;
        if Rec.IsExistingCustomer = false then begin
            IsNotCustomer := true;
        end;
    end;

    procedure CalculateHoldDuration()
    begin
        if Rec.Hold = true then begin

            SvrRelLine.SetRange("Service No.", Rec."Service No.");
            SvrRelLine.SetFilter("Department assigned", '=''HOLD''');
            //Message('stage:%1',SvrRelLine."Department assigned");
            if SvrRelLine.FindLast() then begin
                ResponseTimeMinutes := CurrentDateTime - SvrRelLine."Start Date";
                SvrRelLine.Duration := ResponseTimeMinutes;
                SvrRelLine.Modify();
            end;
        end
    end;

    trigger OnAfterGetCurrRecord()
    begin
        IsInProgress := (Rec.Stage = rec.Stage::Open);
        IsCloseActionVisible := false;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then begin
            if UpperCase(Format(UserSetup."Station/Department")) = UpperCase(Rec."Department assigned") then begin
                IsCloseActionVisible := true;
            end;
        end;
    end;

    local procedure UpdateSvrRelLineComments()
    begin
        SvrRelLine.SetRange("Service No.", Rec."Service No.");
        //SvrRelLine.SetFilter("Department assigned", Format(Rec.Status));
        if SvrRelLine.FindLast() then begin
            if Rec.Status = REC.Status::CX then begin
                SvrRelLine.Comments := Rec."CX Department Comments";
                SvrRelLine."Employee Name" := Rec."Employee Name";
                SvrRelLine.Modify();
                Rec.Remarks := Rec."CX Department Comments";
            end;
            if Rec.Status = REC.Status::BD then begin
                SvrRelLine.Comments := Rec."BD Department Comments";
                SvrRelLine."Employee Name" := Rec."Employee Name(BD)";
                SvrRelLine.Modify();
                Rec.Remarks := Rec."BD Department Comments";
            end;
            if Rec.Status = REC.Status::Credit then begin
                SvrRelLine.Comments := Rec."Credit Department Comments ";
                SvrRelLine."Employee Name" := Rec."Employee Name(CREDIT)";
                SvrRelLine.Modify();
                Rec.Remarks := Rec."Credit Department Comments ";
            end;
            if Rec.Status = REC.Status::Finance then begin
                SvrRelLine.Comments := Rec."Finance Department Comments";
                SvrRelLine."Employee Name" := Rec."Employee Name(FINANCE)";
                SvrRelLine.Modify();
                Rec.Remarks := Rec."Finance Department Comments";
            end;
            if Rec.Status = REC.Status::ICT then begin
                SvrRelLine.Comments := Rec."ICT Department Comments ";
                SvrRelLine."Employee Name" := Rec."Employee Name(ICT)";
                SvrRelLine.Modify();
                Rec.Remarks := Rec."ICT Department Comments ";
            end;
            if Rec.Status = REC.Status::HR then begin
                SvrRelLine.Comments := Rec."HR Department Comments ";
                SvrRelLine."Employee Name" := Rec."Employee Name(HR)";
                SvrRelLine.Modify();
                Rec.Remarks := Rec."HR Department Comments ";
            end;
        end;
    end;

    Local procedure CheckUserPermission(): Boolean
    begin
        UserSetup.SetRange("User ID", UserId);
        Message('UserId:%1', UserSetup."User ID");
        if UserSetup.FindFirst() then begin
            if Format(UserSetup."Station/Department") = Rec."Department assigned" then begin
                exit(true);
            end
            else
                exit(false);
        end;
    end;

    var
        IsEscalated: Boolean;
        IsEditable: Boolean;
        IsInFinance: Boolean;
        IsInHR: Boolean;
        IsInCX: Boolean;
        IsInBD: Boolean;
        IsInCredit: Boolean;
        IsInICT: Boolean;
        IsCustomer: Boolean;
        IsNotCustomer: Boolean;
        ServiceNo: Code[20];
        NStatus: Option;
        SendEmail: Codeunit SendEmail;
        CaseNo: code[100];
        SvrHeader: Record "Case";
        SvrRelLine: Record "Case Lines";
        ResponseTimeMinutes: Duration;
        Enabled: Boolean;
        IsInProgress: Boolean;
        DeptReassign: Record "Departments Re-Assignment";
        CaseManagement: Codeunit "Case Management";
        CommentsDialog: Text[250];
        CommentDialogPage: Page "Hold Comment Dialog";
        Comment: Text[250];
        UserSetup: Record "User Setup";
        IsCloseActionVisible: Boolean;

        EmailMessage: Codeunit "Email Message";
        MailManagement: Codeunit "Mail Management";
        Email: Codeunit Email;

        SenderEmailAddress: Text[250];
        RecipientEmailAddress: Text[250];
        Subject: Text[100];
        Body: Text;
        IsSent: Boolean;
        ErrorMessage: Text;
        EmailAccountFound: Boolean;
        dept: Record "Departments Re-Assignment";
        dimvalues: Record "Dimension Value";
        LastEntryNo: Integer;
        EmailLists: Record "Email Reassignment";
        URL: Text[100];
        CreatorEmail: Text;
        ReassignedDeptEmail: Text;
}
