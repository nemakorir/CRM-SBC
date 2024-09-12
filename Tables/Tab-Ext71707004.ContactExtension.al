tableextension 71707004 "Contact Extension" extends Contact
{
    fields
    {
        modify("E-Mail")
        {
            trigger OnBeforeValidate()
            begin
                //MailManagement.CheckValidEmailAddress("E-Mail")
            end;
        }
        modify(Name)
        {
            trigger OnAfterValidate()
            begin
                "Company No." := '';
                "Company Name" := '';
                "Contact Name" := Name;
            end;
        }
        /*field(71707000; IsCustomer; Boolean)
        {
            Caption = 'IsCustomer';
            DataClassification = ToBeClassified;

        }
        field(71707001; "Customer No."; code[100])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = if (IsCustomer = const(true)) Customer."No." where("Member Status" = const(Active));
            trigger OnValidate()
            begin
                if Cust.get("Customer No.") then begin
                    Name := cust."Search Name";
                    "Search Name" := Cust."Search Name";
                    Address := Cust.Address;
                    "Address 2" := Cust."Address 2";
                    "Country/Region Code" := Cust."Country/Region Code";
                    "Post Code" := cust."Post Code";
                    City := Cust.City;
                    "Phone No." := Cust."Phone No.";
                    "Mobile Phone No." := Cust."Mobile Phone No";
                    "E-Mail" := Cust."E-Mail";
                end;
            end;
        }*/
        field(71707002; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(71707003; "Relationship Officer Code"; Code[100])
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
        field(71707004; "Relationship Officer Name"; Text[100])
        {
            Caption = 'Relationship Officer Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71707005; "Branch Code"; Code[50])
        {
            Caption = 'Branch Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
            trigger OnValidate()
            begin
            end;

        }
        field(71707006; "Source Of Business"; Option)
        {
            Caption = 'Source Of Business';
            DataClassification = ToBeClassified;
            OptionMembers = "","Agent","Social Media","Website","Call Center","Customer Referral","Shareholder","Own Initiative","Staff Referral","Existing top-up","Existing Revived","Outdoor activities";
        }
        field(71707007; "Loan Type"; Option)
        {
            Caption = 'Loan Type';
            DataClassification = ToBeClassified;
            OptionMembers = "","Logbook Loans","Business Loans","Asset Finance Loans","Jiinue Loans","Quick Cash Loans","Import Duty Financing","Insurance Premium","Nawiri","School Fees Loans","Spring Salo";
        }
        field(71707009; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(717070010; "Security Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Car LogBook","Title Deed","Pay Slip","None";
        }
        field(717070012; "Contact Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Individual,Groups,"Business/Company","Co-Borrowing";
            trigger OnValidate()
            begin
                if "Contact Type" = "Contact Type"::Individual then begin
                    "Company No." := '';
                    "Company Name" := '';
                end;
            end;
        }
        field(717070013; "Campaign No."; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Campaign;
            trigger OnValidate()
            begin
                if camp.Get("Campaign No.") then begin
                    "Campaign Name" := camp.Description;
                end;
            end;
        }
        field(717070014; "Campaign Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(717070015; "Recruited By"; Code[20])
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
                        "SalesPerson Name" := Vend."Search Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Staff referral" then begin
                    if Employee.get("Recruited By") then begin
                        "SalesPerson Name" := Employee."First Name" + ' ' + Employee."Last Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Customer referral" then begin
                    if Cust.get("Recruited By") then begin
                        "SalesPerson Name" := Cust."Search Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::Shareholder then begin
                    if Vend.get("Recruited By") then begin
                        "SalesPerson Name" := Vend."Search Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Own initiative" then begin
                    if Employee.get("Recruited By") then begin
                        "SalesPerson Name" := Employee."First Name" + ' ' + Employee."Last Name";
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Social media" then begin
                    if SalsPur.get("Recruited By") then begin
                        "SalesPerson Name" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Website" then begin
                    if SalsPur.get("Recruited By") then begin
                        "SalesPerson Name" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Call center" then begin
                    if SalsPur.get("Recruited By") then begin
                        "SalesPerson Name" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Existing top-up" then begin
                    if SalsPur.get("Recruited By") then begin
                        "SalesPerson Name" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Existing revived" then begin
                    if SalsPur.get("Recruited By") then begin
                        "SalesPerson Name" := SalsPur.Name;
                    end;
                end;
                if "Source Of Business" = "Source Of Business"::"Outdoor activities" then begin
                    if SalsPur.get("Recruited By") then begin
                        "SalesPerson Name" := SalsPur.Name;
                    end;
                end;
            end;
        }
        field(717070016; "Contact Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(717070017; "SalesPerson Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }
    keys
    {
        /*key(key11; "Customer No.")
        {

        }*/
    }
    var
        Cust: Record Customer;
        IsEditable: Boolean;
        camp: Record Campaign;
        DimVALUES: Record "Dimension Value";
        SalsPur: Record "Salesperson/Purchaser";
        MailManagement: Codeunit "Mail Management";
        DimValue: Record "Dimension Value";
        Employee: Record Employee;
        Vend: Record Vendor;

}
