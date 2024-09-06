tableextension 71707003 "Opportunity Ext" extends Opportunity
{
    fields
    {

        modify("Campaign No.")
        {
            trigger OnAfterValidate()
            begin
                if camp.get("Campaign No.") then begin
                    "Campaign Name" := camp.Description;
                end;
            end;
        }
        modify("Segment No.")
        {
            trigger OnAfterValidate()
            var
                SegHeader: Record "Segment Header";
            begin
                if SegHeader.Get("Segment No.") then begin
                    "Segment Name" := SegHeader.Description;
                    SegName := SegHeader.Description;
                    SegNo := "Segment No.";
                end;
            end;
        }

        field(71707000; "ID No."; Code[50])
        {
            Caption = 'ID No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if not IsNumeric("ID No.") then
                    Error('ID No. must contain only numeric digits.');
                if (StrLen("ID No.") < 6) or (StrLen("ID No.") > 8) then
                    Error('ID No. must be between 6 and 8 digits long.');
            end;
        }
        field(71707001; "Source Of Business"; Option)
        {
            Caption = 'Source Of Business';
            DataClassification = ToBeClassified;
            OptionMembers = "","Agent","Social Media","Website","Call Center","Customer Referral","Shareholder","Own Initiative","Staff Referral","Existing top-up","Existing Revived","Outdoor activities";
        }
        field(71707002; "Loan Type"; Option)
        {
            Caption = 'Loan Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Logbook Loans","Business Loans","Asset Finance Loans","Jiinue Loans","Quick Cash Loans","Import Duty Financing","Insurance Premium","Nawiri","School Fees Loans","Spring Salo";
        }
        field(71707003; "Phone No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71707004; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71707005; "Security Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Log Book","Land and Building","Share Guarantee","CheckOff","Staff Guarantee","HASL",Guarantor;
        }
        field(71707006; "Campaign Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71707007; "Relationship Officer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71707008; "Lead Type"; Option)
        {
            OptionMembers = " ","Interested Lead","Engaged Lead","Marketing Qualified Lead";
            Editable = false;
        }
        field(71707009; "Lead Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(71707010; "Lead Email"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(71707011; "Contact Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Individual,Groups,Business;
        }
        field(71707012; "Segment Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(71707013; "CampNo"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(71707014; "CampName"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(71707015; "SegNo"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(71707016; "SegName"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(717070017; "Sales Person"; Text[100])
        {
            Caption = 'Salesperson Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71707018; "Relationship Officer Code"; Code[100])
        {
            Caption = 'Relationship Officer Code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            trigger OnValidate()
            begin
                if SalsPur.Get("Relationship Officer Code") then begin
                    "Relationship Officer Name" := SalsPur.Name;
                end
            end;
        }
        field(717070019; "Recruited By"; Code[100])
        {
            Caption = 'Salesperson Code';
            DataClassification = ToBeClassified;
            TableRelation = if ("Source Of Business" = const("Agent")) Vendor."No."
            else
            if ("Source Of Business" = const("Staff referral")) Employee."No."
            else
            if ("Source Of Business" = const("Customer referral")) Customer."No."
            else if ("Source Of Business" = const("Shareholder")) Vendor."No."
            else if ("Source Of Business" = const("Own initiative")) Employee."No."
            else if ("Source Of Business" = const("Social media")) "Salesperson/Purchaser".Code
            else
            if ("Source Of Business" = const("Website")) "Salesperson/Purchaser".Code
            else
            if ("Source Of Business" = const("Call center")) "Salesperson/Purchaser".Code
            else if ("Source Of Business" = const("Existing top-up")) "Salesperson/Purchaser".Code
            else if ("Source Of Business" = const("Existing revived")) "Salesperson/Purchaser".Code
            else if ("Source Of Business" = const("Outdoor activities")) "Salesperson/Purchaser".Code;
            trigger OnValidate()
            begin
                if "Source Of Business" = "Source Of Business"::Agent then begin
                    if Vend.get("Recruited By") then begin
                        "Sales Person" := Vend."Search Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Staff referral" then begin
                    if Employee.get("Recruited By") then begin
                        "Sales Person" := Employee."First Name" + ' ' + Employee."Last Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Customer referral" then begin
                    if Cust.get("Recruited By") then begin
                        "Sales Person" := Cust."Search Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::Shareholder then begin
                    if Vend.get("Recruited By") then begin
                        "Sales Person" := Vend."Search Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Own initiative" then begin
                    if Employee.get("Recruited By") then begin
                        "Sales Person" := Employee."First Name" + ' ' + Employee."Last Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Social media" then begin
                    if SalsPur.get("Recruited By") then begin
                        "Sales Person" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Website" then begin
                    if SalsPur.get("Recruited By") then begin
                        "Sales Person" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Call center" then begin
                    if SalsPur.get("Recruited By") then begin
                        "Sales Person" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Existing top-up" then begin
                    if SalsPur.get("Recruited By") then begin
                        "Sales Person" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Existing revived" then begin
                    if SalsPur.get("Recruited By") then begin
                        "Sales Person" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Outdoor activities" then begin
                    if SalsPur.get("Recruited By") then begin
                        "Sales Person" := SalsPur.Name;
                    end;
                end;
            end;
        }
        field(71707020; "Branch Code"; Code[50])
        {
            Caption = 'Branch Code';
            DataClassification = ToBeClassified;
            tableRelation ="Dimension Value".Code where ("Dimension Code"=const('BRANCH'));

        }

    }
    trigger OnInsert()
    begin
        "Sales Cycle Code" := 'HOT';
        "Lead Type" := "Lead Type"::"Interested Lead";

    end;

    trigger OnAfterInsert()
    begin
        "Sales Cycle Code" := 'HOT';
        "Lead Type" := "Lead Type"::"Interested Lead";
    end;

    local procedure IsNumeric(Value: Text): Boolean
    var
        i: Integer;
        Char: Char;
    begin
        for i := 1 to StrLen(Value) do begin
            Char := Value[i];
            if not (Char in ['0' .. '9']) then
                exit(false);
        end;
        exit(true);
    end;

    var
        camp: Record Campaign;
        DimVALUES: Record "Dimension Value";
        SalsPur: Record "Salesperson/Purchaser";
        Cust: Record Customer;
        IsEditable: Boolean;
        MailManagement: Codeunit "Mail Management";
        DimValue: Record "Dimension Value";
        Employee: Record Employee;
        Vend: Record Vendor;
}
