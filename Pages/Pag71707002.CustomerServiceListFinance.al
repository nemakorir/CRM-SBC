page 71707002 "Customer Service List(Finance)"
{
    ApplicationArea = All;
    Caption = 'Customer Service List(Finance)';
    PageType = List;
    SourceTable = "Svr Rel.Header";
    UsageCategory = Lists;
    CardPageId = "SVR Header Card";
    SourceTableView=where(Status=const(Finance));
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Service No."; Rec."Service No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service No. field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.', Comment = '%';
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Name field.', Comment = '%';
                }
                field("Resource Code"; Rec."Resource Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource Code field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
}
