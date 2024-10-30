pageextension 71707028 "Member Application Card Exts" extends "Member Application Card"
{
    layout
    {
        
        
        addafter("KRA PIN")
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
