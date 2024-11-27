table 71707006 "Departments Re-Assignment"
{
    Caption = 'Departments Re-Assignment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; DimensionCode; Code[100])
        {
            Caption = 'DimensionCode';
            Editable = false;
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
        }
        field(3; "Email Address"; Text[200])
        {
            Caption = 'Email Address';
        }
        field(4; No; Integer)
        {
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; no)
        {
            Clustered = true;
        }
        key(key1; DimensionCode)
        {
            
        }
    }
    }
