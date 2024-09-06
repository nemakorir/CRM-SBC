table 71707007 "Email Reassignment"
{
    Caption = 'Email Reassignment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Account Id"; Guid)
        {
            Caption = 'No.';
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
        }
        field(3; "Email Address"; Text[200])
        {
            Caption = 'Email Address';
        }
        field(4; Connector; Option)
        {
            Caption = 'Connector';
            OptionMembers = "","SMTP";
        }
        field(5; Logo; Media)
        {
        }
        field(6; LogoBlob; Blob)
        {
        }
        
    }
    keys
    {
        key(PK; "Account Id", Connector)
        {
            Clustered = true;
        }
    }

    
}
