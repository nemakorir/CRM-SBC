tableextension 71707011 "Segment Header Extension" extends "Segment Header"
{
    fields
    {
        field(71707000; "Budget Name"; Code[100])
        {
            Caption = 'Budget Name';
            DataClassification = ToBeClassified;
        }
        field(71707001; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            DataClassification = ToBeClassified;
        }
    }
}
