table 71707001 "Svr Rel.Lines"
{
    Caption = 'Svr. Rel Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Service No."; Code[50])
        {
            Caption = 'Service No.';
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Finance,Credit,CX,Closed,HR;

        }
        field(4; "Case Type"; Option)
        {
            Caption = 'Case Type';
            OptionMembers = "",Complaint,"service request",compliment;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(7; "Mode of Contact"; Option)
        {
            Caption = 'Mode of Contact';
            OptionMembers = "Phone Call","E-mal",Physical;
        }
        field(8; "Nature of Service"; Option)
        {
            Caption = 'Nature of Service';
            OptionMembers = critical,high,medium;
        }
        field(9; Descriptions; Text[100])
        {
            Caption = 'Descriptions';
        }
        field(10; "Date recorded"; DateTime)
        {
            Caption = 'Date recorded';
        }
        field(11; "Time recorded"; Time)
        {
            Caption = 'Time recorded';
        }
        field(12; "Department assigned"; Code[50])
        {
            Caption = 'Department assigned';
        }
        field(13; "Departmental Officer/Individual"; Code[50])
        {
            Caption = 'Departmental Officer/Individual';
            TableRelation = Employee;
            trigger OnValidate()
            begin
                if Emp.get("Departmental Officer/Individual") then begin
                    "Departmental Officer/Individual Name" := Emp."Search Name";
                    "Mobile Number" := Emp."Mobile Phone No.";
                    "E mail address" := Emp."Company E-Mail";
                end;
            end;
        }
        field(14; "Departmental Officer/Individual Name"; Text[100])
        {
            Caption = 'Departmental Officer/Individual Name';
            Editable = false;

        }
        field(15; "Mobile Number"; Text[20])
        {
            Caption = 'Mobile Number';
            Editable = false;
        }
        field(16; "E mail address"; Text[100])
        {
            Caption = 'E mail address';
            Editable = false;
        }
        field(17; "Response Type"; Option)
        {
            Caption = 'Response Type';
            OptionMembers = FCR,"non-FCR";
        }
        field(18; "Response Time (Hours)"; Duration)
        {
            Caption = 'Response Time (Hours)';
            Editable = false;
        }
        field(19; "Credit Memo Date"; Date)
        {
            Caption = 'Credit Memo Date';
        }
        field(20; "Contract Expiration Date"; Date)
        {
            Caption = 'Contract Expiration Date';
        }
        field(21; "Service Period"; DateFormula)
        {
            Caption = 'Service Period';
        }
        field(22; "Variant Code"; Code[20])
        {
            Caption = 'Variant Code';
        }
        field(23; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(24; "New Line"; Boolean)
        {
            Caption = 'New Line';
        }
        field(25; Credited; Boolean)
        {
            Caption = 'Credited';
        }
        field(26; "Line Cost"; Decimal)
        {
            Caption = 'Line Cost';
        }
        field(27; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
        }
        field(28; Profit; Decimal)
        {
            Caption = 'Profit';
        }
        field(29; "Response Date/Time(Service)"; DateTime)
        {
            Caption = 'Response Date/Time(Service)';
        }
        field(30; "Response Date/Time(Finance)"; DateTime)
        {
            Caption = 'Response Date/Time(Finance)';
        }
        field(31; "Response Date/Time(Credit)"; DateTime)
        {
            Caption = 'Response Date/Time(Credit)';
        }
        field(32; "Response Date/Time(CX)"; DateTime)
        {
            Caption = 'Response Date/Time(CX)';
        }
        field(33; "Response Date/Time(HR)"; DateTime)
        {
            Caption = 'Response Date/Time(HR)';
        }
        field(34; "Response Date/Time(Closed)"; DateTime)
        {
            Caption = 'Response Date/Time(Closed)';
        }
        field(35; "Service Department Comments"; Text[200])
        {
            Caption = 'Service Department Comments';
        }
        field(36; "Service Department Finance"; Text[200])
        {
            Caption = 'Service Department Finance';
        }
        field(37; "Service Department Credit"; Text[200])
        {
            Caption = 'Service Department Credit';
        }
        field(38; "Service Department CX"; Text[200])
        {
            Caption = 'Service Department CX';
        }
        field(39; "Service Department HR"; Text[200])
        {
            Caption = 'Service Department HR';
        }
        field(40; "Start Date"; DateTime)
        {
            Editable = false;
        }
        field(41; "Escalation End Date"; DateTime)
        {
            Editable = false;
        }
        field(42; "Comments"; Text[200])
        {
            Editable = false;
        }
        field(43; Duration; Duration)
        {
            Editable = false;
        }
        field(44; Resolved; Boolean)
        {
            Editable = false;
        }
        field(45; "Resolved Date"; DateTime)
        {
            Editable = false;
        }
        field(47; "User ID"; Code[100])
        {
            Editable = false;
        }
        field(48; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(49; Remarks; Text[100])
        {
            Editable = false;
        }
        field(50; Stage; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,"In Progress",Closed;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Line No.", "Service No.")
        {
            // Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Date recorded" := CurrentDateTime;

    end;

    trigger OnModify()
    begin

    end;



    var
        SvrHeader: Record "Svr Rel.Header";
        SvrRelHeaderLine: Record "Svr Rel.Lines";
        Emp: Record Employee;

}
