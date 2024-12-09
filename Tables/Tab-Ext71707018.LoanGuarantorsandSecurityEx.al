tableextension 71707018 "LoanGuarantors and Security Ex" extends "Loan Guarantors and Security"
{
    fields
    {
        modify("Collateral Reg. No.")
        {
            trigger OnAfterValidate()
            var
                CollRegister: Record "Collateral Register";
            begin
                if CollRegister.get("Collateral Reg. No.") then begin
                    Description := CollRegister."Collateral Name";
                end;
            end;
        }
    }
}
