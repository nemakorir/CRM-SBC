pageextension 71707018 "Create Interaction Extension" extends "Create Interaction"
{
    layout
    {
        addbefore("Interaction Template Code")
        {
            field("Customer No"; Rec."Customer No")
            {
                ApplicationArea = All;
                Visible=false;
            }
        }
    }
    actions
    {

    }
}
