page 71707027 "CRM SMS Messages"
{
    ApplicationArea = All;
    Caption = 'CRM SMS Messages';
    PageType = List;
    SourceTable = "CRM SMS Messages";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Entry No"; rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field(Source; rec.Source)
                {
                    ApplicationArea = All;
                }
                field("Entered By"; rec."Entered By")
                {
                    ApplicationArea = All;
                }
                field("Account No"; rec."Account No")
                {
                    ApplicationArea = All;
                }
                field("Date Entered"; rec."Date Entered")
                {
                    ApplicationArea = All;
                }
                field("SMS Message"; rec."SMS Message")
                {
                    ApplicationArea = All;
                }
                field("Date Sent to Server"; rec."Date Sent to Server")
                {
                    ApplicationArea = All;
                }
                field("Sent To Server"; rec."Sent To Server")
                {
                    ApplicationArea = All;
                }
                field("Telephone No"; rec."Telephone No")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
