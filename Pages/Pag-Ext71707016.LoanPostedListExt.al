pageextension 71707016 "Loan Posted List Exts" extends "Loan Posted List"
{
    layout
    {
        addafter("Outstanding Interest")
        {
            field("Additional Interest"; Rec."Additional Interest")
            {
                ApplicationArea = All;
            }
        }
    }
}
