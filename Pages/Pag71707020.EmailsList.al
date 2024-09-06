page 71707020 "Emails List"
{
    ApplicationArea = All;
    Caption = 'Emails List';
    PageType = List;
    SourceTable = "Email Reassignment";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Account Id"; Rec."Account Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Address field.', Comment = '%';
                }
                field(Connector; Rec.Connector)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Connector field.', Comment = '%';
                }
                field(Logo; Rec.Logo)
                {
                    ApplicationArea = All;
                }
                field(LogoBlob; Rec.LogoBlob)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
       // DeptReassignment.EmailReassignment();
    end;

    var
        DeptReassignment: Codeunit SendEmail;
        EmailAccount: Record "Email Account";
        EmailLists: Record "Email Reassignment";

}
