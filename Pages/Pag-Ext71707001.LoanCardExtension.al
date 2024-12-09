pageextension 71707001 "Loan Card Extension" extends "Loan Card"
{
    layout
    {
        modify("Repayment Start Date")
        {
            trigger OnAfterValidate()
            begin
                DisbursementDate := Rec."Disbursement Date";
                MinRepaymentStartDate := DisbursementDate + 30;
                if Rec."Repayment Start Date" < MinRepaymentStartDate then
                    Error('Repayment Start Date must be at least 30 days after the Disbursement Date.');
            end;

        }
        addafter("Requested Amount")
        {
            field("Loan Amount In Words"; Rec."Loan Amount In Words")
            {
                ApplicationArea = All;
            }
        }
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
    var
        DisbursementDate: Date;
        MinRepaymentStartDate: Date;
}
