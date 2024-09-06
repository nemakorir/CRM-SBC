tableextension 71707001 "User Setup Extendion" extends "User Setup"
{
    fields
    {
        modify("Station/Department")
        {
            trigger OnBeforeValidate()
            begin

            end;
        }
    }
}
