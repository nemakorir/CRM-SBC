pageextension 71707029 " General Ledger Setup Ext" extends "General Ledger Setup"
{
    layout
    {
        addafter(EnableDataCheck)
        {
            field("Current Budget"; Rec."Current Budget")
            {
                ApplicationArea = All;
            }
        }
    }
}
