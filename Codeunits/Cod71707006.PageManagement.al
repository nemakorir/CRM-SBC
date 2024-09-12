codeunit 71707006 "Page Management Extee"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer);
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageID(RecordRef);
    end;

    procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin
        case RecordRef.number of
            database::Campaign:
                exit(Page::"Campaign List");
        end;
    end;
}
