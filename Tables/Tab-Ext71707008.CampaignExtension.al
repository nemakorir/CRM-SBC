tableextension 71707008 "Campaign Extension" extends Campaign
{
    fields
    {
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            begin
                if SalsPur.Get("Salesperson Code") then begin
                    "Relationship Officer Name" := SalsPur.Name;
                end;
            end;
        }
        field(71707000; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval","Approved","Declined",Deffered;
            Editable = false;
        }
        field(71707001; "Budget Name"; Code[100])
        {
            Caption = 'Budget Name';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "G/L Budget Name";
            trigger OnValidate()
            begin
                GLSetup.Get();
                if "Budget Name" <> GLSetup."Current Budget" then begin
                    Error('The Budget Name selected does not match the Current Budget');
                end;
                budgeCheck();
            end;
        }
        field(71707002; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Rec."Total Cost" > "Available Budget" then
                    Error('The Total Cost exceeds the available budget for the marketing G/L account.');
            end;
        }
        field(71707003; "Available Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71707004; "Relationship Officer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    local procedure budgeCheck()
    begin
        CRMSetup.Get();

        if GLAcc.Get(CRMSetup."Marketing G/L Account") then begin
            GLAcc.CalcFields(Balance);
            AvailableBudget := GLAcc.Balance;
            "Available Budget" := AvailableBudget;
        end else
            Error('Marketing G/L Account not found in CRM Setup.');
    end;

    trigger OnInsert()
    begin
        CRMSetup.Get();
        GLSetup.Get();
        "Budget Name" := GLSetup."Current Budget";
        if GLAcc.Get(CRMSetup."Marketing G/L Account") then begin
            if GLAcc.Get(CRMSetup."Marketing G/L Account") then begin
                GLAcc.CalcFields(Balance);
                AvailableBudget := GLAcc.Balance;
                Rec."Available Budget" := AvailableBudget;
            end else
                Error('Marketing G/L Account not found in CRM Setup.');
        end else
            Error('CRM Setup not configured.');
    end;

    var
        GLAcc: Record "G/L Account";
        CRMSetup: Record "CRM No Series Setup";
        AvailableBudget: Decimal;
        GLSetup: Record "General Ledger Setup";
        SalsPur: Record "Salesperson/Purchaser";
}
