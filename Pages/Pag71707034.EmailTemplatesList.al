page 71707034 "Email Templates List"
{
    ApplicationArea = All;
    Caption = 'Email Templates List';
    PageType = List;
    SourceTable = "Email Templates List";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Type field.', Comment = '%';
                }
                field("Email Message"; Rec."Email Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Message field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.', Comment = '%';
                }
                field("Template Key"; Rec."Template Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Key field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }
}
