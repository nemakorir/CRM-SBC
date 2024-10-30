tableextension 71707017 "Interaction Log Entry ext" extends "Interaction Log Entry"
{
    trigger OnInsert()
    begin
        Opport.SetRange("No.", "Opportunity No.");
        if Opport.FindFirst() then begin
            repeat
                Count += 1;
            until Opport.Next() = 0;
            InteractionCount := Count;
              Commit();
               if Count = 1 then begin
                    Opport."Lead Type" := Opport."Lead Type"::"Engaged Lead";
                    Opport.Modify();
                end;
                if Count > 1 then begin
                    Opport."Lead Type" := Opport."Lead Type"::"Marketing Qualified Lead";
                    Opport.Modify();
                end;
        end;
    end;

    var
        Opport: Record Opportunity;
        OpportEntry: Record "Opportunity Entry";
        Count: Integer;
        InteractionCount: Integer;
}
