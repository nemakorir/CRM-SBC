pageextension 71707026 "Salespersons/Purchasers Exten" extends "Salespersons/Purchasers"
{
    trigger OnOpenPage()
    begin
        UpdateROs();
    end;

    local procedure UpdateROs()
    begin
        dimvalues.Reset();
        dimvalues.SetRange("Dimension Code", 'RLSHIP_OFFICER');
        if dimvalues.FindSet() then begin
            repeat
                SalsPur.SetRange("Code", dimvalues.Code);
                if NOT (SalsPur.FindFirst()) then begin
                    SalsPur.Init();
                    SalsPur.Code := dimvalues.Code;
                    SalsPur.Name := dimvalues.Name;
                    SalsPur.Insert();
                end;
            until dimvalues.Next() = 0;
        end;
    end;

    var
        SalsPur: Record "Salesperson/Purchaser";
        dimvalues: Record "Dimension Value";
}
