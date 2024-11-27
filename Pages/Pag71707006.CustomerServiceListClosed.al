page 71707006 "Customer Service List(Closed)"
{
    ApplicationArea = All;
    Caption = 'Customer Service List(Closed/Hold)';
    PageType = List;
    SourceTable = "Case";
    UsageCategory = Lists;
    CardPageId = "Case Card";
    SourceTableView = where(Status = const(Closed));
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,New Document,Case Filters,Request Approval,Navigate,Customer';
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
    actions
    {
        area(navigation)
        {
            action("Case Filters")
            {
                Caption = 'Open Cases Via Filter Page';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    varFilterPageBuilder: FilterPageBuilder;
                    varFilterApplied: Boolean;
                    filterQuery: Text;
                begin
                    varFilterPageBuilder.AddTable('Case', Database::"Case");
                    varFilterPageBuilder.PageCaption := 'Case Filters';
                    varFilterApplied := varFilterPageBuilder.RunModal();
                    /*if varFilterApplied then begin
                        // Retrieve the filters and apply them to the current page
                        filterQuery := varFilterPageBuilder.GetTableView(Database::"Case").GetFilter();
                        Rec.SetView(filterQuery);
                        CurrPage.Update(false); // Refresh the page with new filters
                    end;*/

                end;
            }
        }
    }
}
