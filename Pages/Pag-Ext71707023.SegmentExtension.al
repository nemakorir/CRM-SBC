pageextension 71707023 "Segment Extension" extends Segment
{
    Caption = 'Marketing Card';
    layout
    {
        modify(General)
        {
            Editable = EditPage;
        }
        
    }
    actions
    {
        addafter(AddContacts)
        {
            action(AddCustomers)
            {
                ApplicationArea = RelationshipMgmt;
                Ellipsis = true;
                Image = AddContacts;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Select which Customers to add to the marketing list.';
                trigger OnAction()
                var
                    SelectedCustomerList: Page "Customer List";
                    Customer: Record Customer;
                begin
                    if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then begin
                        AddCustomerToSegment(Customer);
                    end;
                end;
            }
        }
    }
    procedure AddCustomerToSegment(Customer: Record Customer);
    var
        NewLineNo: Integer;
    begin
        SegmentHeader.Get(Rec."No.");
        NewLineNo := GetNextLineNo(SegmentHeader."No.");

        SegmentLine.Init();
        SegmentLine."Line No." := NewLineNo;
        SegmentLine."Segment No." := SegmentHeader."No.";
        SegmentLine."Contact No." := Customer."No.";
        SegmentLine."Contact Name" := Customer.Name;
        SegmentLine.Description := Customer."Search Name";
        SegmentLine."Salesperson Code" := Customer."Relationship Officer";
        SegmentLine.Insert(true);
        CurrPage.Update();
    end;

    procedure GetNextLineNo(SegmentNo: Code[20]): Integer;
    var
        MaxLineNo: Integer;
    begin
        MaxLineNo := 0;

        SegmentLine.SetRange("Segment No.", SegmentNo);
        if SegmentLine.FindLast() then
            MaxLineNo := SegmentLine."Line No.";

        exit(MaxLineNo + 1);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    var
        CampaignRec: Record Campaign;
    begin
        EditPage := false;
        if CampaignRec.Get(Rec."Campaign No.") then begin
            if (CampaignRec.Status = CampaignRec.Status::"Pending Approval") or
               (CampaignRec.Status = CampaignRec.Status::Approved) then begin
                EditPage := false;
            end else
                EditPage := true;
        end;
    end;

    var
        SegmentHeader: Record "Segment Header";
        SegmentLine: Record "Segment Line";
        CustomerListPage: Page "Member List";
        Cust: Record Customer;
        EditPage: Boolean;
        CustomerNo: Code[20];
        CustomerList: Page "Customer List";
        NewLineNo: Integer;
        SelectedCustomerList: Page "Customer List";
        Customer: Record Customer;
        GenderOption: Option "All","Male","Female";
        MaritalStatusOption: Option "All","Single","Married";
        ConfirmSelectAll: Boolean;
        GenderFilter: Text;
        MaritalStatusFilter: Text;
        GenderList: List of [Text];
        MaritalStatusList: List of [Text];
        SelectedGender: Text;
        SelectedMaritalStatus: Text;
        IsAllCustomers: Boolean;
}
