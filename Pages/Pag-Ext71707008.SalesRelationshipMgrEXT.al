pageextension 71707008 "Sales & Relationship Mgr.  EXT" extends "Sales & Relationship Mgr. RC"
{
    layout
    {

    }
    actions
    {
        moveafter(Opportunities; Campaigns)
        modify(Opportunities)
        {
            Caption = 'Leads';
        }
        addafter(Contacts)
        {
            //action("C")
        }
        addafter("Posted Documents")
        {
            group("Service Management")
            {
                Caption = 'Service Management';
                action("Customer Service List")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List';
                    RunObject = page "Customer Service List";
                    Visible = false;
                }
                action("Customer Service List(New)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(CX)';
                    RunObject = page "Customer Service List(New)";
                }
                action("Customer Service List(BD)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(BD)';
                    RunObject = page "Customer Service List(BD)";
                }
                action("Customer Service List(Credit)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(Credit)';
                    RunObject = page "Customer Service List(Credit)";
                }
                action("Customer Service List(Finance)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(Finance)';
                    RunObject = page "Customer Service List(Finance)";
                }
                action("Customer Service List(ICT)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(ICT)';
                    RunObject = page "Customer Service List(ICT)";
                }
                /* action("Customer Service List(CX)")
                 {
                     ApplicationArea = All;
                     Caption = 'Customer Service List(CX)';
                     RunObject = page "Customer Service List(CX)";
                     Visible = false;
                 }*/
                action("Customer Service List(HR)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(HR)';
                    RunObject = page "Customer Service List(HR)";
                }
                action("Customer Service List(Closed)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(Closed)';
                    RunObject = page "Customer Service List(Closed)";
                }
            }
            group("Customer 360 View")
            {
                Caption = 'Customer 360 View';
                action("Customer List")
                {
                    ApplicationArea = All;
                    Caption = 'Customer List';
                    RunObject = page "Member List";
                }

            }
            group("CRM Setup")
            {
                action("CRM No Series")
                {
                    ApplicationArea = All;
                    Caption = 'CRM Setup';
                    RunObject = page "CRM No Series";
                }
            }
        }
    }
}
