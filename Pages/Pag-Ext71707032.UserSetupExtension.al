pageextension 71707032 "User Setup Extension" extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("Allow Open My Settings"; Rec."Allow Open My Settings")
            {
                ApplicationArea = All;
            }
            field("Allow Change Role"; Rec."Allow Change Role")
            {
                ApplicationArea = All;
            }
            field("Allow Change Company"; Rec."Allow Change Company")
            {
                ApplicationArea = All;
            }
            field("Allow Change Work Day"; Rec."Allow Change Work Day")
            {
                ApplicationArea = All;
            }
            field("Allow Change Region"; Rec."Allow Change Region")
            {
                ApplicationArea = All;
            }
            field("Allow Change Language"; Rec."Allow Change Language")
            {
                ApplicationArea = All;
            }
            field("Allow Change TimeZone"; Rec."Allow Change TimeZone")
            {
                ApplicationArea = All;
            }

        }
    }
}
