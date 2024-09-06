codeunit 71707007 "Lead Priority Management"
{
    trigger OnRun()
    begin
        Opport.Reset();
        if Opport.FindSet() then begin
            repeat
                DaysDifference := Today - Opport."Creation Date";
                if (DaysDifference = 30) then begin
                    Opport."Sales Cycle Code" := 'HOT';
                    Opport.Modify();
                end;
                if (DaysDifference >= 30) and (DaysDifference <= 60) then begin
                    Opport."Sales Cycle Code" := 'WARM';
                    Opport.Modify();
                end;
                if DaysDifference > 60 then begin
                    Opport."Sales Cycle Code" := 'COLD';
                    Opport.Modify();
                end;
            until Opport.Next() = 0;
        end;
    end;

    var
        Opport: Record Opportunity;
        CreatedOn: Date;
        DaysDifference: Integer;
}
