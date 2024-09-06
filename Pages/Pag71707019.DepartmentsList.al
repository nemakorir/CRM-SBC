page 71707019 "Departments List"
{
    ApplicationArea = All;
    Caption = 'Departments List';
    PageType = List;
    SourceTable = "Departments Re-Assignment";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(DimensionCode; Rec.DimensionCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DimensionCode field.', Comment = '%';
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
            }
        }
    }
    trigger OnOpenPage()
    begin
      DeptReassignment.DeptRessignment();  
    end;

    var
        dept: Record "Departments Re-Assignment";
        dimvalues: Record "Dimension Value";
        LastEntryNo: Integer;
        DeptReassignment:Codeunit SendEmail;

}
