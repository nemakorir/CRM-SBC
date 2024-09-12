page 71707011 "Approved Loans List"
{
    ApplicationArea = All;
    Caption = 'Approved Loans List';
    PageType = List;
    SourceTable = Loans;
    UsageCategory = Lists;
    CardPageId = "Loan Card";
    SourceTableView = where(Status = const("Approved"));
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Loan No."; rec."Loan No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Type"; rec."Loan Product Type")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Requested Amount"; rec."Requested Amount")
                {
                    ApplicationArea = All;
                }
                field("Recommended Amount"; rec."Recommended Amount")
                {
                    ApplicationArea = All;
                }
                field("Approved Amount"; rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field("Amount To Disburse"; rec."Amount To Disburse")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Balance"; rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Interest"; rec."Outstanding Interest")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Bills"; rec."Outstanding Bills")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control18; Notes)
            {
            }
            systempart(Control19; MyNotes)
            {
            }
            systempart(Control20; Links)
            {
            }
        }
    }
}
