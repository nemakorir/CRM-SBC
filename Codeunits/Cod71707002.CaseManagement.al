codeunit 71707002 "Case Management"
{
    procedure UpdateDepartmentAssigned(CaseNo: code[100])
    begin
        SvrHeader.SetRange("Service No.", CaseNo);
        if SvrHeader.FindFirst() then begin
            NewLineNo := GetNextLineNo();
            SvrRelLine.Init();
            SvrRelLine."Line No." := NewLineNo;
            SvrRelLine."Service No." := SvrHeader."Service No.";
            case SvrHeader.Status of
                SvrHeader.Status::CX:
                    begin
                        SvrRelLine."Department assigned" := 'CX';
                    end;
                SvrHeader.Status::Finance:
                    begin
                        SvrRelLine."Department assigned" := 'Finance';
                    end;
                SvrHeader.Status::Credit:
                    begin
                        SvrRelLine."Department assigned" := 'Credit';
                    end;
                SvrHeader.Status::Closed:
                    begin
                        SvrRelLine."Department assigned" := 'Closed';
                    end;
                SvrHeader.Status::HR:
                    begin
                        SvrRelLine."Department assigned" := 'HR';
                    end;
                SvrHeader.Status::BD:
                    begin
                        SvrRelLine."Department assigned" := 'BD';
                    end;
                SvrHeader.Status::ICT:
                    begin
                        SvrRelLine."Department assigned" := 'ICT';
                    end;
            end;
            SvrRelLine."Start Date" := CurrentDateTime;
            SvrRelLine."User ID" := UserId;
            SvrRelLine.Insert();
        end;
    end;
    procedure UpdateHoldStatus(CaseNo: code[100])

    begin
        SvrHeader.SetRange("Service No.", CaseNo);
        if SvrHeader.FindFirst() then begin
            NewLineNo := GetNextLineNo();
            SvrRelLine.Init();
            SvrRelLine."Line No." := NewLineNo;
            SvrRelLine."Service No." := SvrHeader."Service No.";
            if SvrHeader.Hold = true then begin
                SvrRelLine."Department assigned" := 'Hold';
            end;
            SvrRelLine."Start Date" := CurrentDateTime;
            SvrRelLine.Insert(true);
        end;
    end;

    procedure UpdateHoldStatus1(CaseNo: code[100])

    begin
        SvrHeader.SetRange("Service No.", CaseNo);
        if SvrHeader.FindFirst() then begin
            NewLineNo := GetNextLineNo();
            SvrRelLine.Init();
            SvrRelLine."Line No." := NewLineNo;
            SvrRelLine."Service No." := SvrHeader."Service No.";
            SvrRelLine."Department assigned" := 'Hold';

            SvrRelLine."Start Date" := CurrentDateTime;
            SvrRelLine.Insert(true);
        end;
    end;

    procedure GetNextLineNo(): Integer
    begin
        SvrRelLine.SetRange("Service No.", SvrHeader."Service No.");
        if SvrRelLine.FindLast() then
            exit(SvrRelLine."Line No." + 1);
        exit(1);
    end;

    procedure UpdateSvrRelLineComments(CaseNo: code[100])
    begin
        SvrHeader.SetRange("Service No.", CaseNo);
        if SvrHeader.FindFirst() then begin
            SvrRelLine.SetRange("Service No.", SvrHeader."Service No.");
            SvrRelLine.SetFilter("Department assigned", Format(SvrHeader.Status));
            if SvrRelLine.FindLast() then begin
                IsModified := false;
                //Update Comments
                case SvrHeader.Status of
                    SvrHeader.Status::CX:
                        if SvrRelLine.Comments <> SvrHeader."CX Department Comments" then begin
                            SvrRelLine.Comments := SvrHeader."CX Department Comments";
                            IsModified := true;
                        end;
                    SvrHeader.Status::Finance:
                        if SvrRelLine.Comments <> SvrHeader."Finance Department Comments" then begin
                            SvrRelLine.Comments := SvrHeader."Finance Department Comments";
                            IsModified := true;
                        end;
                    SvrHeader.Status::Credit:
                        if SvrRelLine.Comments <> SvrHeader."Credit Department Comments " then begin
                            SvrRelLine.Comments := SvrHeader."Credit Department Comments ";
                            IsModified := true;
                        end;
                    SvrHeader.Status::HR:
                        if SvrRelLine.Comments <> SvrHeader."HR Department Comments " then begin
                            SvrRelLine.Comments := SvrHeader."HR Department Comments ";
                            IsModified := true;
                        end;
                    SvrHeader.Status::BD:
                        if SvrRelLine.Comments <> SvrHeader."BD Department Comments" then begin
                            SvrRelLine.Comments := SvrHeader."BD Department Comments";
                            IsModified := true;
                        end;
                    SvrHeader.Status::ICT:
                        if SvrRelLine.Comments <> SvrHeader."ICT Department Comments " then begin
                            SvrRelLine.Comments := SvrHeader."ICT Department Comments ";
                            IsModified := true;
                        end;
                end;
                /// Update Employee Name
                case SvrHeader.Status of
                    SvrHeader.Status::CX:
                        if SvrRelLine."Employee Name" <> SvrHeader."Employee Name" then begin
                            SvrRelLine."Employee Name" := SvrHeader."Employee Name";
                            IsModified := true;
                        end;
                    SvrHeader.Status::BD:
                        if SvrRelLine."Employee Name" <> SvrHeader."Employee Name(BD)" then begin
                            SvrRelLine."Employee Name" := SvrHeader."Employee Name(BD)";
                            IsModified := true;
                        end;
                    SvrHeader.Status::Credit:
                        if SvrRelLine."Employee Name" <> SvrHeader."Employee Name(CREDIT)" then begin
                            SvrRelLine."Employee Name" := SvrHeader."Employee Name(CREDIT)";
                            IsModified := true;
                        end;
                    SvrHeader.Status::Finance:
                        if SvrRelLine."Employee Name" <> SvrHeader."Employee Name(FINANCE)" then begin
                            SvrRelLine."Employee Name" := SvrHeader."Employee Name(FINANCE)";
                            IsModified := true;
                        end;
                    SvrHeader.Status::ICT:
                        if SvrRelLine."Employee Name" <> SvrHeader."Employee Name(ICT)" then begin
                            SvrRelLine."Employee Name" := SvrHeader."Employee Name(ICT)";
                            IsModified := true;
                        end;
                    SvrHeader.Status::HR:
                        if SvrRelLine."Employee Name" <> SvrHeader."Employee Name(HR)" then begin
                            SvrRelLine."Employee Name" := SvrHeader."Employee Name(HR)";
                            IsModified := true;
                        end;
                end;
                if IsModified then begin
                    SvrRelLine."User ID" := UserId;
                    SvrRelLine.Modify(true);
                end;
            end
        end;
    end;

    procedure ResolveCase(CaseNo: code[100])
    begin
        SvrHeader.SetRange("Service No.", CaseNo);
        if SvrHeader.FindFirst() then begin
            SvrRelLine.SetRange("Service No.", SvrHeader."Service No.");
            if SvrRelLine.FindLast() then begin
                SvrRelLine.Resolved := true;
                SvrRelLine."Resolved Date" := SvrHeader."Resolved Date";
                SvrRelLine.Remarks := SvrHeader.Remarks;
                SvrRelLine.Modify();
            end;
        end;
    end;

    var
        IsEditable: Boolean;
        SvrHeader: Record "Case";
        SvrRelLine: Record "Case Lines";
        Cust: Record Customer;
        LoansR: Record Loans;
        CollRegister: Record "Collateral Register";
        LoanGuarantors: Record "Loan Guarantors and Security";
        Emp: Record Employee;
        Vend: Record Vendor;
        ResponseTimeMinutes: Duration;
        NewLineNo: Integer;
        IsModified: Boolean;
}
