pageextension 71707036 "CreditManagementRoleCenter Ex" extends "Credit Management Role Center"
{
    actions
    {
        addafter("Credit Setup")
        {
            group("Lead Management")
            {
                Caption = 'Lead Management';
                action("Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'Contacts';
                    RunObject = page "Contact List";
                    Visible = true;
                }
                action("Leads")
                {
                    ApplicationArea = All;
                    Caption = 'Leads';
                    RunObject = page "Opportunity List";
                    Visible = true;
                }
            }
            group("Case Management")
            {
                Caption = 'Case Management';
                action("Customer Service List")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List';
                    RunObject = page "Customer Service List";
                    Visible = true;
                }
                action("Customer Service List(Credit)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(Credit)';
                    RunObject = page "Customer Service List(Credit)";
                }
                action("Customer Service List(Closed)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(Closed)';
                    RunObject = page "Customer Service List(Closed)";
                }
            }
        }
    }
}
