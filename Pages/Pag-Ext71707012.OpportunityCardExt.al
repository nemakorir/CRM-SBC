pageextension 71707012 "Opportunity Card Ext" extends "Opportunity Card"
{
    Caption = 'Lead';
    layout
    {
        modify("Salesperson Code")
        {
            Visible = false;
        }
        addafter("Contact Name")
        {
            field("Lead Name"; Rec."Lead Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Lead Email"; Rec."Lead Email")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(CampNo; Rec.CampNo)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(CampName; Rec.CampName)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Contact Type"; Rec."Contact Type")
            {
                ApplicationArea = All;
            }
            field("Lead Type"; Rec."Lead Type")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = All;
            }
            field("Campaign Name"; Rec."Campaign Name")
            {
                ApplicationArea = All;
            }
            field("Segment Name"; Rec."Segment Name")
            {
                ApplicationArea = All;
            }
            field(SegNo; Rec.SegNo)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(SegName; Rec.SegName)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Source Of Business"; Rec."Source Of Business")
            {
                ApplicationArea = All;
            }
            field("Recruited By"; Rec."Recruited By")
            {
                ApplicationArea = All;
            }
            field("Sales Person"; Rec."Sales Person")
            {
                ApplicationArea = All;
            }
            field("Relationship Officer Code"; Rec."Relationship Officer Code")
            {
                ApplicationArea = All;
            }
            field("Relationship Officer Name"; Rec."Relationship Officer Name")
            {
                ApplicationArea = All;
            }
            field("Branch Code"; Rec."Branch Code")
            {
                ApplicationArea = All;
            }
            field("Loan Type"; Rec."Loan Type")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Security Type"; Rec."Security Type")
            {
                ApplicationArea = All;
            }
        }

        movebefore("Campaign Name"; "Campaign No.")
        movebefore("Segment Name"; "Segment No.")
        movebefore("Relationship Officer Name"; "Salesperson Code")
        addafter(Status)
        {
            field("No. of Interactions"; Rec."No. of Interactions")
            {
                ApplicationArea = All;
            }
            field("Estimated Value (LCY)"; Rec."Estimated Value (LCY)")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        modify("Sales Document Type")
        {
            visible = false;
        }
        modify("Sales Document No.")
        {
            visible = false;
        }
        modify(ContactPhoneNo)
        {
            Editable = true;
            Visible = false;
        }
        modify("Sales Cycle Code")
        {
            Editable = false;
        }
        modify("Contact Company Name")
        {
            Visible = false;
        }
    }

    actions
    {
        modify(CreateSalesQuote)
        {
            Visible = false;
        }
        addafter("Activate the First Stage")
        {
            action("Create Customer")
            {
                ApplicationArea = All;
                Caption = 'Create Customer';
                Image = Continue;
                Promoted = true;
                PromotedCategory = Process;
                //Enabled = Rec.Status = Rec.Status::Won;
                trigger OnAction()
                begin
                    Rec.TestField("ID No.");
                    Rec.TestField("Source Of Business");
                    Cust.SetFilter("Identification Doc. No.", Rec."ID No.");
                    if Cust.FindFirst() then begin
                        Error('There is an existing customer with the same ID No., please check the customer card for accuracy before proceeding to loan application.');
                    end;
                    CustomerApplication.Init();
                    CustomerApplication."Identification Doc. No." := Rec."ID No.";
                    CustomerApplication."Source Of Customer" := Rec."Source Of Business";
                    CustomerApplication."Recruited By" := Rec."Recruited By";
                    CustomerApplication."Recruiter Name" := Rec."Sales Person";
                    CustomerApplication."Global Dimension 2 Code" := Rec."Relationship Officer Code";
                    CustomerApplication."Relationship Officer Name" := Rec."Relationship Officer Name";
                    CustomerApplication."Product Code" := Format(Rec."Loan Type");
                    CustomerApplication."Loan Amount" := rec.Amount;
                    CustomerApplication.Security := rec."Security Type";
                    CustomerApplication."Mobile Phone No" := Rec."Phone No.";
                    CustomerApplication.Name := Rec."Lead Name";
                    CustomerApplication."E-Mail" := Rec."Lead Email";
                    //CustomerApplication."Campaign No." := Rec."Campaign No.";
                    //CustomerApplication."Campaign Name" := Rec."Campaign Name";
                    CustomerApplication."Campaign No." := Rec.CampNo;
                    CustomerApplication."Campaign Name" := Rec.CampName;
                    //CustomerApplication."Segment No." := Rec."Segment No.";
                    //CustomerApplication."Segment Name" := Rec."Segment Name";
                    CustomerApplication."Segment No." := Rec.SegNo;
                    CustomerApplication."Segment Name" := Rec.SegName;
                    CustomerApplication."Posting Group" := 'LOANS';
                    CustomerApplication."Global Dimension 1 Code" := Rec."Branch Code";
                    if Rec."Contact Type" = Rec."Contact Type"::Individual then begin
                        CustomerApplication."Type of Customer" := CustomerApplication."Type of Customer"::Individual;
                    end;
                    if Rec."Contact Type" = Rec."Contact Type"::Groups then begin
                        CustomerApplication."Type of Customer" := CustomerApplication."Type of Customer"::Groups;
                    end;
                    if Rec."Contact Type" = Rec."Contact Type"::"Business/Company" then begin
                        CustomerApplication."Type of Customer" := CustomerApplication."Type of Customer"::"Business/Company";
                    end;
                    if Rec."Contact Type" = Rec."Contact Type"::"Co-Borrowing" then begin
                        CustomerApplication."Type of Customer" := CustomerApplication."Type of Customer"::"Co-Borrowing";
                    end;
                    //security
                    if rec."Security Type" = Rec."Security Type"::"Log Book" then begin
                        CustomerApplication.Security := CustomerApplication.Security::"Log Book";
                    end;
                    if rec."Security Type" = Rec."Security Type"::"Share Guarantee" then begin
                        CustomerApplication.Security := CustomerApplication.Security::"Share Guarantee";
                    end;
                    if rec."Security Type" = Rec."Security Type"::"Staff Guarantee" then begin
                        CustomerApplication.Security := CustomerApplication.Security::"Staff Guarantee";
                    end;
                    if rec."Security Type" = Rec."Security Type"::"Land and Building" then begin
                        CustomerApplication.Security := CustomerApplication.Security::"Land and Building";
                    end;
                    if rec."Security Type" = Rec."Security Type"::HASL then begin
                        CustomerApplication.Security := CustomerApplication.Security::HASL;
                    end;
                    if rec."Security Type" = Rec."Security Type"::Guarantor then begin
                        CustomerApplication.Security := CustomerApplication.Security::Guarantor;
                    end;
                    if rec."Security Type" = Rec."Security Type"::CheckOff then begin
                        CustomerApplication.Security := CustomerApplication.Security::Checkoff;
                    end;
                    CustomerApplication.Insert(true);
                    Page.Run(Page::"Member Application Card", CustomerApplication);
                end;
            }
            /*action(Close)
            {
                ApplicationArea = All;
                Caption = 'Close';
                Image = Continue;
                Promoted = true;
                trigger OnAction()
                begin

                end;
            }*/
        }
        modify(CloseOpportunity)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin

            end;
        }
    }
    trigger OnOpenPage()
    begin
        LeadTypes();
    end;

    trigger OnAfterGetRecord()
    begin
        //LeadTypes();
    end;

    local procedure LeadTypes()
    var
        InteractionCount: Integer;
    begin
        Count := 0;
        if Opport.Get(Rec."No.") then begin
            InteractionLogEntry.SetRange("Opportunity No.", Rec."No.");
            if InteractionLogEntry.FindFirst() then begin
                repeat
                    Count += 1;
                until InteractionLogEntry.Next() = 0;
                InteractionCount := Count;
                // Message('Total No of interactions: %1', Count);
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
    end;

    var
        Opport: Record Opportunity;
        OpportEntry: Record "Opportunity Entry";
        Count: Integer;
        Cust: Record Customer;
        CustomerApplication: Record "Member Application";
        InteractionLogEntry: Record "Interaction Log Entry";
}
