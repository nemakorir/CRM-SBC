page 71707009 "CRM No Series"
{
    Caption = 'CRM Setup';
    PageType = Card;
    SourceTable = "CRM No Series Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Svr Rel.Header"; Rec."Svr Rel.Header")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Svr Rel.Header field.', Comment = '%';
                }
                field("Marketing G/L Account"; Rec."Marketing G/L Account")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not CRMNoseries.Get('') then begin
            CRMNoseries.No := '';
            CRMNoseries.Insert();

        end;
    end;

    var
        CRMNoseries: Record "CRM No Series Setup";
}
