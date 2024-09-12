table 71707016 "Email Templates List"
{
    Caption = 'Email Templates List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            Caption = 'No';
            AutoIncrement = true;
        }
        field(2; Type; Option)
        {
            Caption = 'Template Type';
            OptionMembers = " ",Escalation,Hold,Release,Resolution,Close,Campaign;
        }
        field(3; "Email Message"; Text[250])
        {
            Caption = 'Email Message';
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(5; "Template Key"; Text[250])
        {
            Caption = 'Template Key';
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
