pageextension 71707031 "Loan Card Posted Extension" extends "Loan Card Posted"
{
    layout
    {
        addafter("Loan Application Code")
        {
            field("Campaign No."; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
            field("Campaign Name"; Rec."Campaign Name")
            {
                ApplicationArea = All;
            }
            field("Segment No."; Rec."Segment No.")
            {
                ApplicationArea = All;
            }
            field("Segment Name"; Rec."Segment Name")
            {
                ApplicationArea = All;
            }
        }
    }
}
