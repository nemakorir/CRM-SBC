table 71707000 "Case"
{
    Caption = 'Case';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Service No."; Code[20])
        {
            Caption = 'Service No.';
            Editable = false;
        }
        field(2; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            OptionMembers = "",Complaint,"service request",compliment;

        }
        field(3; Description; Text[1000])
        {
            Caption = 'Description';
        }
        field(4; Status; Option)
        {
            Caption = 'Stage';
            OptionMembers = "",CX,Finance,Credit,Closed,HR,BD,ICT,Hold,"Business Development";
            Editable = false;

        }
        field(5; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                cust: Record Customer;
            begin
                if cust.get(Rec."Customer No.") then begin
                    Name := cust.Name;
                    "E-Mail" := cust."E-Mail";
                    "Phone No." := cust."Mobile Phone No";
                    "Branch Code" := cust."Branch Code";
                    "Relationship Officer Code" := cust."Relationship Officer";
                    "Relationship Officer Name" := cust."Relationship Officer Name";
                end;

            end;
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(7; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(8; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(9; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
        }
        field(11; "Contact Name"; Text[50])
        {
            Caption = 'Contact Name';
        }
        field(12; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(13; "Resource Code"; Code[20])
        {
            Caption = 'Resource Code';
        }
        field(14; Comment; Boolean)
        {
            Caption = 'Comment';
        }
        field(15; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
        }
        field(16; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
        }
        field(17; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(18; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            Editable = false;
        }
        field(19; County; Text[30])
        {
            Caption = 'County';
        }
        field(20; "Response Date/Time(CX)"; DateTime)
        {
            Caption = 'Response Date/Time(CX)';
            Editable = false;
        }
        field(21; "Response Date/Time(Finance)"; DateTime)
        {
            Caption = 'Response Date/Time(Finance)';
            Editable = false;
        }
        field(22; "Response Date/Time(Credit)"; DateTime)
        {
            Caption = 'Response Date/Time(Credit)';
            Editable = false;
        }
        field(23; "Response Date/Time(BD)"; DateTime)
        {
            Caption = 'Response Date/Time(BD)';
            Editable = false;
        }
        field(24; "Response Date/Time(HR)"; DateTime)
        {
            Caption = 'Response Date/Time(HR)';
            Editable = false;
        }
        field(25; "Response Date/Time(Closed)"; DateTime)
        {
            Caption = 'Response Date/Time(Closed)';
            Editable = false;
        }
        field(26; "CX Department Comments"; Text[500])
        {
            Caption = 'CX Department Comments';

            trigger OnValidate()
            begin
                "Response Date/Time(CX)" := CurrentDateTime;
                CaseNo := "Service No.";
                //CaseManagement.UpdateSvrRelLineComments(CaseNo);

            end;
        }
        field(27; "Finance Department Comments"; Text[500])
        {
            Caption = 'Finance Department Comments';
            Editable = false;
            trigger OnValidate()
            begin
                "Response Date/Time(Finance)" := CurrentDateTime;
                CaseNo := "Service No.";
                //CaseManagement.UpdateSvrRelLineComments(CaseNo);

            end;
        }
        field(28; "Credit Department Comments "; Text[500])
        {
            Caption = 'Credit Department Comments ';
            Editable = false;
            trigger OnValidate()
            begin
                "Response Date/Time(CREDIT)" := CurrentDateTime;
                CaseNo := "Service No.";
                // CaseManagement.UpdateSvrRelLineComments(CaseNo);

            end;
        }
        field(29; "BD Department Comments"; Text[500])
        {
            Caption = 'BD Department Comments';
            Editable = false;
            trigger OnValidate()
            begin
                "Response Date/Time(BD)" := CurrentDateTime;
                CaseNo := "Service No.";
                //CaseManagement.UpdateSvrRelLineComments(CaseNo);
            end;
        }
        field(30; "HR Department Comments "; Text[500])
        {
            Caption = 'HR Department Comments';
            Editable = false;
            trigger OnValidate()
            begin
                "Response Date/Time(HR)" := CurrentDateTime;
                CaseNo := "Service No.";
                //CaseManagement.UpdateSvrRelLineComments(CaseNo);
            end;
        }
        field(31; "Created By"; code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Date Recorded"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Date Closed"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "IsClosed?"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Closed By"; code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Response Time (Hours)"; Duration)
        {
            Caption = 'Response Time (Hours)';
            Editable = false;
        }
        field(37; "Response Date/Time(ICT)"; DateTime)
        {
            Caption = 'Response Date/Time(ICT)';
            Editable = false;
        }
        field(38; "ICT Department Comments "; Text[500])
        {
            Caption = 'ICT Department Comments';
            Editable = false;
            trigger OnValidate()
            begin
                "Response Date/Time(ICT)" := CurrentDateTime;
                CaseNo := "Service No.";
                //CaseManagement.UpdateSvrRelLineComments(CaseNo);
            end;
        }
        /* field(39; "Response Date/Time(BD)"; DateTime)
        {
            Caption = 'Response Date/Time(ICT)';
            Editable = false;
        }*/
        field(40; "Case Type"; Option)
        {
            Caption = 'Case Type';
            OptionMembers = "",Complaint,"Service Request",Compliment,Enquiry;
        }
        field(41; "Mode of Contact"; Option)
        {
            Caption = 'Mode of Contact';
            OptionMembers = "","Phone Call","E-mail",Physical;
        }
        field(42; "Nature of Service"; Option)
        {
            Caption = 'Nature of Service';
            OptionMembers = "",Critical,High,Medium;
        }
        field(43; "Department assigned"; Code[50])
        {
            Caption = 'Department assigned';
            Editable = false;
            TableRelation="Departments Re-Assignment".DimensionCode;
        }
        field(44; "Departmental Officer"; Code[50])
        {
            Caption = 'Departmental Officer/Individual';
            TableRelation = Employee;
            trigger OnValidate()
            begin
                if Emp.get("Departmental Officer") then begin
                    "Departmental Officer Name" := Emp."Search Name";
                    "Mobile Number" := Emp."Mobile Phone No.";
                    "E mail address" := Emp."Company E-Mail";
                end;
            end;
        }
        field(45; "Departmental Officer Name"; Text[100])
        {
            Caption = 'Departmental Officer/Individual Name';
            Editable = false;
        }
        field(46; "Mobile Number"; Text[20])
        {
            Caption = 'Mobile Number';
            Editable = false;
        }
        field(47; "E mail address"; Text[100])
        {
            Caption = 'Dept Email address';
            Editable = false;
        }
        field(48; "Response Type"; Option)
        {
            Caption = 'Response Type';
            OptionMembers = "",FCR,"non-FCR";
        }
        field(49; "Relationship Officer Code"; Code[100])
        {
            Editable = false;
        }
        field(50; "Relationship Officer Name"; Text[100])
        {
            Editable = false;
        }
        field(51; "Branch Code"; Code[100])
        {
            Editable = false;
        }
        field(52; "Case Initiator Type"; Option)
        {
            OptionMembers = "",Agent,Staff,Customer;
            Caption = 'Case Source';
        }
        field(53; "Case Initiator Code"; Code[100])
        {
            Caption = 'Case Source code';
            TableRelation = if ("Case Initiator Type" = const(Agent)) Vendor."No."
            else
            if ("Case Initiator Type" = const(Staff)) Employee."No."
            else
            if ("Case Initiator Type" = const(Customer)) Customer."No.";

            trigger OnValidate()
            begin
                if "Case Initiator Type" = "Case Initiator Type"::Agent then begin
                    if Vend.get("Case Initiator Code") then begin
                        "Case Initiator Name" := Vend."Search Name";
                    end;
                end;
                if "Case Initiator Type" = "Case Initiator Type"::Staff then begin
                    if Emp.get("Case Initiator Code") then begin
                        "Case Initiator Name" := Emp."First Name" + ' ' + Emp."Last Name";
                    end;
                end;
                if "Case Initiator Type" = "Case Initiator Type"::Customer then begin
                    if Cust.get("Case Initiator Code") then begin
                        "Case Initiator Name" := Cust.Name;
                        "Customer No." := cust."No.";
                        Name := cust.Name;
                        "E-Mail" := cust."E-Mail";
                        "Phone No." := cust."Mobile Phone No";
                        "Branch Code" := cust."Branch Code";
                        "Relationship Officer Code" := cust."Relationship Officer";
                        "Relationship Officer Name" := cust."Relationship Officer Name";
                        IsExistingCustomer := true;
                    end;
                end;
            end;
        }
        field(54; "Case Initiator Name"; Text[100])
        {
            Editable = false;
            Caption = 'Case Source Name';
        }
        field(55; IsExistingCustomer; Boolean)
        {

        }
        field(57; "Employee No."; Code[100])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                if Emp.get("Employee No.") then begin
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Last Name";
                end
            end;
        }
        field(58; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(59; Hold; Boolean)
        {
            trigger OnValidate()
            begin
                CaseNo := "Service No.";
                CaseManagement.UpdateHoldStatus(CaseNo);
            end;
        }
        field(60; Stage; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"In Progress",Closed;
            Editable = false;

        }
        field(61; Resolved; Boolean)
        {
            Editable = false;
        }
        field(62; "Resolved Date"; DateTime)
        {
            Editable = false;
        }
        field(63; "Employee No(BD)."; Code[100])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                if Emp.get("Employee No(BD).") then begin
                    "Employee Name(BD)" := Emp."First Name" + ' ' + Emp."Last Name";
                end
            end;
        }
        field(64; "Employee Name(BD)"; Text[100])
        {
            Editable = false;
            Caption = 'Employee Name';
        }
        field(65; "Employee No(CREDIT)."; Code[100])
        {

            TableRelation = Employee."No.";
            Caption = 'Employee No.';
            trigger OnValidate()
            begin
                if Emp.get("Employee No(CREDIT).") then begin
                    "Employee Name(CREDIT)" := Emp."First Name" + ' ' + Emp."Last Name";
                end
            end;
        }
        field(66; "Employee Name(CREDIT)"; Text[100])
        {
            Editable = false;
            Caption = 'Employee Name';
        }
        field(67; "Employee No(FINANCE)."; Code[100])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                if Emp.get("Employee No(FINANCE).") then begin
                    "Employee Name(FINANCE)" := Emp."First Name" + ' ' + Emp."Last Name";
                end
            end;
        }
        field(68; "Employee Name(FINANCE)"; Text[100])
        {
            Editable = false;
            Caption = 'Employee Name';
        }
        field(69; "Employee No(ICT)."; Code[100])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                if Emp.get("Employee No(ICT).") then begin
                    "Employee Name(ICT)" := Emp."First Name" + ' ' + Emp."Last Name";
                end
            end;
        }
        field(70; "Employee Name(ICT)"; Text[100])
        {
            Editable = false;
            Caption = 'Employee Name';
        }
        field(71; "Employee No(HR)."; Code[100])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                if Emp.get("Employee No(HR).") then begin
                    "Employee Name(HR)" := Emp."First Name" + ' ' + Emp."Last Name";
                end
            end;
        }
        field(72; "Employee Name(HR)"; Text[100])
        {
            Editable = false;
            Caption = 'Employee Name';
        }
        field(73; Remarks; Text[500])
        {
            Caption = 'Resolution/Remarks';
            Editable=false;
        }
        field(74; "IsReleased?"; Boolean)
        {
            Editable = false;
        }
        field(75; "Email Thread ID"; Text[250])
        {
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Service No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Setup: Record "CRM No Series Setup";
        NoMgtm: Codeunit NoSeriesManagement;
    begin
        if "Service No." = '' then begin
            Setup.Get();
            "Service No." := NoMgtm.GetNextNo(Setup."Svr Rel.Header", WorkDate, true)
        end;
        "Created By" := UserId;
        UpdateStatusOninsert();
        "Date Recorded" := CurrentDateTime;
        InsertSvrRelLines();
    end;

    trigger OnModify()
    begin

    end;

    local procedure UpdateStatusOninsert()
    begin
        //CX
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Station/Department", UserSetup."Station/Department"::CX);
        if UserSetup.FindFirst() then begin
            //Message('deprt:%1', UserSetup."Station/Department");
            Status := Status::CX;
        end;
        //BD
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Station/Department", UserSetup."Station/Department"::"Business Development");
        if UserSetup.FindFirst() then begin
            //Message('deprt:%1', UserSetup."Station/Department");
            Status := Status::BD;
        end;
        //Credit
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Station/Department", UserSetup."Station/Department"::Credit);
        if UserSetup.FindFirst() then begin
            //Message('deprt:%1', UserSetup."Station/Department");
            Status := Status::Credit;
        end;
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Station/Department", UserSetup."Station/Department"::Finance);
        if UserSetup.FindFirst() then begin
            //Message('deprt:%1', UserSetup."Station/Department");
            Status := Status::Finance;
        end;
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Station/Department", UserSetup."Station/Department"::ICT);
        if UserSetup.FindFirst() then begin
            //Message('deprt:%1', UserSetup."Station/Department");
            Status := Status::ICT;
        end;
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Station/Department", UserSetup."Station/Department"::HR);
        if UserSetup.FindFirst() then begin
            //Message('deprt:%1', UserSetup."Station/Department");
            Status := Status::HR;
        end;
    end;

    local procedure InsertSvrRelLines()
    begin
        SvrRelLine.Init();
        SvrRelLine."Service No." := Rec."Service No.";
        SvrRelLine."Department assigned" := Format(Status);
        SvrRelLine.Stage := Stage;
        SvrRelLine."Start Date" := CurrentDateTime;
        SvrRelLine."User ID" := UserId;
        SvrRelLine.Insert();
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
        CaseManagement: Codeunit "Case Management";
        CaseNo: code[100];
        IsModified: Boolean;
        UserSetup: Record "User Setup";
}
