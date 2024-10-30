tableextension 71707013 "Customer Extensions" extends Customer
{
     fields
    {
        field(71707000; "Campaign No."; Code[100])
        {
            Caption = 'Campaign No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71707001; "Campaign Name"; Text[200])
        {
            Caption = 'Campaign Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71707002; "Segment No."; Code[200])
        {
            Caption = 'Segment No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(71707003; "Segment Name"; Text[200])
        {
            Caption = 'Segment Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
