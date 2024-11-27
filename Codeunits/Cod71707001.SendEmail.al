codeunit 71707001 SendEmail
{

    procedure CaseEscalation(CaseNo: code[100])

    var
        EmailBody: Text;
        ThreadID: Text[250];
    begin
        URL := 'http://192.168.137.120:8080/BC200/';
        SvrHeader.SetRange("Service No.", CaseNo);
        if SvrHeader.FindFirst() then begin
            RecipientEmailAddress := SvrHeader."E mail address";
            Subject := SvrHeader."Service No." + ' ' + SvrHeader.Name + ' ' + Format(SvrHeader."Case Type");
            //Escalation message
            if (SvrHeader.Resolved = false) and (SvrHeader.Hold = false) then begin
                SecondaryEmail();
                EmailSubject := Subject;
                Body := SvrHeader."Service No." + '\' + 'Customer No: ' + SvrHeader."Customer No." + '\' + '  Customer Name: ' + SvrHeader.Name + '\' + ' Mode of Contact:  ' + Format(SvrHeader."Mode of Contact") + '\' + ' Nature of service . ' + Format(SvrHeader."Nature of Service") + '\' + SvrHeader.Remarks + '\' + URL;
                /*TemplateType := TemplateType::Escalation;
                if GetEmailTemplate(TemplateType, EmailBody) then begin
                    Body := FormatEmailBody(EmailBody, SvrHeader);
                end;*/
            end;
            //Resolution message
            if (SvrHeader.Resolved = true) and (SvrHeader.Hold = false) and (SvrHeader."IsReleased?" = false) then begin
                SecondaryEmail();
                EmailSubject := Subject;
                Body := 'Dear Team , ' + ' Ticket No. ' + SvrHeader."Service No." + '  has been resolved with the following remarks  ' + SvrHeader.Remarks + ' ' + URL;
                /*TemplateType := TemplateType::Resolution;
                if GetEmailTemplate(TemplateType, EmailBody) then begin
                    Body := FormatEmailBody(EmailBody, SvrHeader);
                end;*/
            end;
            //Hold message
            if (SvrHeader.Hold = true) and (SvrHeader."IsReleased?" = false) then begin
                SecondaryEmail();
                EmailSubject := Subject;
                Body := SvrHeader."Service No." + ' is on hold: ' + SvrHeader.Remarks + ' ' + URL;
            end;
            //Release Ticket
            if (SvrHeader."IsReleased?" = true) then begin
                SecondaryEmail();
                EmailSubject := Subject;
                Body := SvrHeader."Service No." + ' has been released: ' + SvrHeader.Remarks + ' ' + URL;
            end;
            //Closing message
            if SvrHeader."IsClosed?" then begin
                EmailSubject := Subject;
                Body := SvrHeader."Service No." + ' has been closed: ' + SvrHeader.Remarks + ' ' + URL;
                /*TemplateType := TemplateType::Close;
                if GetEmailTemplate(TemplateType, EmailBody) then begin
                    Body := FormatEmailBody(EmailBody, SvrHeader);
                end;*/
            end;
            EmailMessage.Create(RecipientEmailAddress, EmailSubject, Body);
            IsSent := Email.Send(EmailMessage, Enum::"Email Scenario"::"BC Auto Notfications");
            if IsSent then
                Message('Email sent successfully.')
            else begin
                ErrorMessage := GetLastErrorText();
                Message('Failed to send email. Error: %1', ErrorMessage);
            end;
        end;
    end;

    procedure SecondaryEmail()
    begin
        UserSetup.SetRange("User ID", SvrHeader."Created By");
        if UserSetup.FindFirst() then begin
            DeptReassign.SetRange(DimensionCode, UpperCase(Format((UserSetup."Station/Department"))));
            if DeptReassign.FindFirst() then begin
                //Message('RecipientEmailAddress:1%', DeptReassign."Email Address");
                ReassignedDeptEmail := DeptReassign."Email Address";
                RecipientEmailAddress := RecipientEmailAddress + ';' + ReassignedDeptEmail;
            end;
        end;
    end;

    procedure EmailOnClose()
    begin
        RecipientEmailAddress := SvrHeader."E mail address";
    end;

    procedure DeptRessignment()
    begin
        dimvalues.Reset();
        dimvalues.SetRange("Dimension Code", 'DEPARTMENT');
        if dimvalues.FindFirst() then begin
            repeat
                LastEntryNo := 0;
                if dept.FindLast() then
                    LastEntryNo := dept.No;
                dept.SetRange(DimensionCode, dimvalues.Code);
                if NOT (dept.FindFirst()) then begin
                    dept.Init();
                    dept.No := LastEntryNo + 1;
                    dept.DimensionCode := dimvalues.Code;
                    dept.Name := dimvalues.Name;
                    dept.Insert();
                end;
            until dimvalues.Next() = 0;
        end;
    end;

    procedure DeptToEscalateTo(CaseNo: code[100])
    begin
        SvrHeader.Reset();
        SvrHeader.SetRange("Service No.", CaseNo);
        //Message('CaseNo:%1', CaseNo);
        if SvrHeader.FindFirst() then begin
            if SvrHeader.Status = SvrHeader.Status::BD then begin
                DeptReassign.SetRange(DimensionCode, Format(SvrHeader.Status::BD));
                if DeptReassign.FindFirst() then begin
                    SvrHeader."Department assigned" := DeptReassign.DimensionCode;
                    SvrHeader."E mail address" := DeptReassign."Email Address";
                    SvrHeader.Modify();
                end;
            end;

            if SvrHeader.Status = SvrHeader.Status::Credit then begin

                DeptReassign.SetRange(DimensionCode, Format(SvrHeader.Status::Credit));
                if DeptReassign.FindFirst() then begin
                    SvrHeader."Department assigned" := DeptReassign.DimensionCode;
                    SvrHeader."E mail address" := DeptReassign."Email Address";
                    SvrHeader.Modify();
                end;
            end;

            if SvrHeader.Status = SvrHeader.Status::Finance then begin
                DeptReassign.Reset();
                DeptReassign.SetRange(DimensionCode, Format(SvrHeader.Status::Finance));
                if DeptReassign.FindFirst() then begin
                    SvrHeader."Department assigned" := DeptReassign.DimensionCode;
                    SvrHeader."E mail address" := DeptReassign."Email Address";
                    SvrHeader.Modify(true);
                end;
            end;

            if SvrHeader.Status = SvrHeader.Status::CX then begin
                DeptReassign.Reset();
                DeptReassign.SetRange(DimensionCode, Format(SvrHeader.Status::cx));
                if DeptReassign.FindFirst() then begin
                    SvrHeader."Department assigned" := DeptReassign.DimensionCode;
                    SvrHeader."E mail address" := DeptReassign."Email Address";
                    SvrHeader.Modify(true);
                end;
            end;

            if SvrHeader.Status = SvrHeader.Status::ICT then begin
                DeptReassign.Reset();
                DeptReassign.SetRange(DimensionCode, Format(SvrHeader.Status::ICT));
                if DeptReassign.FindFirst() then begin
                    SvrHeader."Department assigned" := DeptReassign.DimensionCode;
                    SvrHeader."E mail address" := DeptReassign."Email Address";
                    SvrHeader.Modify(true);
                end;
            end;

            if SvrHeader.Status = SvrHeader.Status::HR then begin
                DeptReassign.Reset();
                DeptReassign.SetRange(DimensionCode, Format(SvrHeader.Status::HR));
                if DeptReassign.FindFirst() then begin
                    SvrHeader."Department assigned" := DeptReassign.DimensionCode;
                    SvrHeader."E mail address" := DeptReassign."Email Address";
                    SvrHeader.Modify(true);
                end;
            end;
            if SvrHeader.Status = SvrHeader.Status::Closed then begin
                OnClosing();
            end;
        end;
    end;

    procedure OnClosing()
    begin
        UserSetup.SetRange("User ID", SvrHeader."Created By");
        if UserSetup.FindFirst() then begin
            DeptReassign.Reset();
            DeptReassign.SetRange(DimensionCode, Format(UserSetup."Station/Department"));
            if DeptReassign.FindFirst() then begin
                Message('email:%1', DeptReassign."Email Address");
                SvrHeader."E mail address" := DeptReassign."Email Address";
                SvrHeader.Modify();
            end;
        end;
    end;

    local procedure GetEmailTemplate(TemplateType: Option " ",Escalation,Hold,Resolution,Close; var EmailBody: Text): Boolean
    begin
        EmailTemplate.SetRange(Type, TemplateType);
        if EmailTemplate.FindFirst() then begin
            EmailBody := EmailTemplate."Email Message";
            //Message('Retrieved Email Body: %1', EmailBody);
            exit(true);
        end;
        exit(false);
    end;
    //

    procedure FormatEmailBody(var EmailBody: Text; SvrHeader: Record "Case"): Text
    begin
        Message('Original Email Body: %1', EmailBody);
        Message('Department assigned: %1', SvrHeader."Department assigned");
        //EmailBody := StrSubstNo(EmailBody, '{First Name}', SvrHeader."Department assigned");
        EmailBody := EmailBody.Replace('{Deparrtment}', SvrHeader."Department assigned");
        EmailBody := EmailBody.Replace('{Ref no.}', SvrHeader."Service No.");
        EmailBody := EmailBody.Replace('{Insert Link}', URL);
        Message('After Substitution: %1', EmailBody);
        exit(EmailBody);
    end;

    local procedure GenerateUniqueThreadID(CaseNo: Code[100]): Text[250]
    begin
        exit('<' + Format(CaseNo) + '@mydomain.com>'); // Example ID format
    end;

    procedure EraseComments(CaseNo: Code[100])
    begin
        SvrHeader.SetRange("Service No.", CaseNo);
        if SvrHeader.FindFirst() then begin
            SvrHeader."CX Department Comments" := '';
            SvrHeader."BD Department Comments" := '';
            SvrHeader."Credit Department Comments " := '';
            SvrHeader."Finance Department Comments" := '';
            SvrHeader."ICT Department Comments " := '';
            SvrHeader."HR Department Comments " := '';
            SvrHeader.Modify();
        end;

    end;

    var
        SvrHeader: Record "Case";
        SvrRelLine: Record "Case";
        EmailMessage: Codeunit "Email Message";
        MailManagement: Codeunit "Mail Management";
        Email: Codeunit Email;
        DeptReassign: Record "Departments Re-Assignment";
        SenderEmailAddress: Text[250];
        RecipientEmailAddress: Text[250];
        Subject: Text[100];
        EmailSubject: Text[100];
        Body: Text;
        IsSent: Boolean;
        ErrorMessage: Text;
        EmailAccountFound: Boolean;
        dept: Record "Departments Re-Assignment";
        dimvalues: Record "Dimension Value";
        LastEntryNo: Integer;
        EmailLists: Record "Email Reassignment";
        URL: Text[100];
        UserSetup: Record "User Setup";
        CreatorEmail: Text;
        ReassignedDeptEmail: Text;
        EmailTemplate: Record "Email Templates List";
        TemplateType: Option " ",Escalation,Hold,Release,Resolution,Close;
}
