page 71707008 "Hold Comment Dialog"
{
    Caption = 'Comment Dialog';
    PageType = StandardDialog;


    layout
    {
        area(Content)
        {
            group(group)
            {
                field("Enter Comment"; Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        Comment: Text[250];

    procedure GetComment(): Text[250]
    begin
        exit(Comment);
    end;
}
