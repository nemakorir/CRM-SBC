pageextension 71707030 "Member Card Extensions" extends "Member Card"
{
    layout
    {
        addafter(Nationality)
        {
            field("Campaign No."; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
            field("Campaign Name"; Rec."Campaign Name")
            {
                ApplicationArea = All;
            }
            field("Segment No."; Rec."Segment No.")
            {
                ApplicationArea = All;
            }
            field("Segment Name"; Rec."Segment Name")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
       /* MemberApplication.SetRange("Identification Doc. No.", Rec."Identification Doc. No.");
        if MemberApplication.FindFirst() then begin
            if MemberApplication.Status = MemberApplication.Status::Approved then begin
                Cust.SetRange("Identification Doc. No.", Rec."Identification Doc. No.");
                if Cust.FindFirst() then begin
                    Cust."Campaign No." := MemberApplication."Campaign No.";
                    Cust."Campaign Name" := MemberApplication."Campaign Name";
                    Cust."Segment No." := MemberApplication."Segment No.";
                    Cust."Segment Name" := MemberApplication."Segment Name";
                    Cust.Modify();
                end else begin
                    Error('No Customer found with Identification Doc. No. %1', Rec."Identification Doc. No.");
                end;
            end else begin
                Error('Member Application for Identification Doc. No. %1 is not approved.', Rec."Identification Doc. No.");
            end;
        end else begin
            Error('No Member Application found for Identification Doc. No. %1', Rec."Identification Doc. No.");
        end;*/
    end;

    var
        MemberApplication: Record "Member Application";
        Cust: Record Customer;

}
