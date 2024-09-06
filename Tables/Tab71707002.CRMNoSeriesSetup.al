table 71707002 "CRM No Series Setup"
{
    Caption = 'CRM No Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; code[50])
        {
            //AutoIncrement = true;
        }
        field(2; "Svr Rel.Header"; Code[100])
        {
            Caption = 'Svr Rel.Header';
            TableRelation = "No. Series".Code;
        }
        field(3; "Marketing G/L Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
