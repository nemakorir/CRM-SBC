pageextension 71707035 "FinanceManagerRoleCenter ex" extends "Finance Manager Role Center"
{
    layout
    {
        addfirst(RoleCenter)
        {
            group(Control4)
            {
                part(Control3; "Loan Cues")
                {
                }
                part(control5; RoleCenterHeadline)
                {
                }
                systempart(Control25; Notes)
                {
                }
            }
        }

    }

    actions
    {
        addafter(Group50)
        {
            group("Credit Managament")
            {
                Caption = 'Credit Managament';

                group("New Customer Process")
                {
                    action("Customer Application")
                    {
                        Caption = 'Customer Application';
                        RunObject = page "Member Application List";
                        Visible = false;
                    }
                    action("Customer Application Archive")
                    {
                        Caption = 'Customer Application Archive';
                        RunObject = page "Member Appl List History";
                        Visible = false;
                    }
                }
                group(Customers2)
                {
                    Caption = 'Customers';
                    action("Customer Card")
                    {
                        Caption = 'Customer List';
                        RunObject = page "Member List";
                    }
                    action("Customer Editable")
                    {
                        Caption = 'Customer Editable';
                        RunObject = page "Member Modify List";
                    }
                    action("Customer Editable Archive")
                    {
                        Caption = 'Customer Editable Archive';
                        RunObject = page "Member Modify List Hist";
                    }
                    action(Penalty)
                    {
                        Caption = 'Penalty Accrued';
                        RunObject = page "Penalty Accrued";
                    }
                    action("Customer Rating")
                    {
                        RunObject = page "Customer Rating";
                    }
                    action("Customer Requests")
                    {
                        RunObject = page "Customer Request List";
                    }
                    action(Employers)
                    {
                        Caption = 'Employers List';
                        RunObject = page "Employer List";
                    }
                    action("Loanee Employers")
                    {
                        Visible = false;
                    }
                }
                group("Loan Processing")
                {
                    action("Loan Application List")
                    {
                        Caption = 'Loan Application List';
                        RunObject = page "Loan List";
                    }
                    action("Approved Loans")
                    {
                        RunObject = page "Approved Loans List";

                    }
                    action("Loan Disbursement Batches")
                    {
                        Caption = 'Loan Disbursement List';
                        RunObject = page "Loan Disbursement List";
                    }
                    action("RO Transfer Process")
                    {
                        Caption = 'RO Transfer List';
                        RunObject = page "RO Transfer List";
                    }
                    group("Posted Loans")
                    {
                        action("Posted Loans List")
                        {
                            Caption = 'Loan Posted List';
                            RunObject = page "Loan Posted List";
                        }
                        action("Import Loans")
                        {
                            Caption = 'Import Loans';
                            Visible = false;
                        }
                        action("Update Loans")
                        {
                            Visible = false;
                        }
                        action("Import Journal")
                        {
                            Visible = false;
                        }
                        action("Update Ledgers-Trans Type")
                        {
                            Visible = false;
                        }
                    }
                }
                group("Loan Securities & Payments")
                {
                    action("External Guarantor")
                    {
                        Caption = 'External Guarantor';
                        RunObject = page "Loan Guarantors List";
                    }
                    action("Loan Collaterals")
                    {
                        RunObject = page "Collateral Register - List";
                    }
                    action("Loan Collateral Editable")
                    {
                        RunObject = page "Collateral Editable List";
                    }
                    action("Loan Collateral Editable Archive")
                    {
                        RunObject = page "Collateral Editable  Archive";
                    }
                    action("Insurance Policy")
                    {
                        RunObject = page "Insurance Policy List";
                    }
                    action("Security Discounting")
                    {
                        RunObject = page "Security Discounting List";
                    }
                    action("Paybill Buffer ")
                    {
                        RunObject = page "Paybill Buffer View";
                    }
                    action("Bank Codes")
                    {
                        RunObject = page "Bank Codes List";
                    }
                }
                group("PD Cheques Management")
                {
                    action("PD Cheques - Holding")
                    {
                        RunObject = page "PD Cheques - Holding";

                    }
                    action("PD Cheques-Banking")
                    {
                        RunObject = page "PD Cheques Banking";

                    }
                    action("PD Cheques-Pending")
                    {
                        RunObject = page "PD Cheques Banking";

                    }
                    action("PD Cheques Banked -History ")
                    {
                        RunObject = page "PD Cheques History";

                    }
                }
                group(Reports)
                {
                    action("Member Statement")
                    {
                        Caption = 'Customer Statement';
                        RunObject = report "Customer Statement";
                    }
                    action("Application Register")
                    {
                        Caption = 'Application Register';
                        RunObject = report "Member Application Register";
                    }
                    action("Loan register")
                    {
                        Caption = 'Loan Register';
                        RunObject = report "Loan Register";
                    }
                    action("Collateral Register")
                    {
                        RunObject = report "Collateral Register";
                    }
                    action("Collateral Insurance")
                    {
                        RunObject = report "Loan Insurance";
                    }
                    action("Loan Disbursed Summary")
                    {
                        RunObject = report "Loan Disbursed Report";
                    }
                    action("Loan Disbursed Detailed")
                    {
                        RunObject = report "Loan Disb. Detailed Report";
                    }
                    action("Loan Categorization")
                    {
                        Caption = 'Loan Categorization';
                        RunObject = report "Loan Categorization";
                    }
                    action("Loan Defaulter Aging")
                    {
                        Caption = 'Loan Defaulter Aging';
                        RunObject = report "Loans Defaulter Aging - SASRA";
                    }
                    action("Loan Provisioning")
                    {
                        Caption = 'Loan Provisioning Summary';
                        RunObject = report "Loan Provisioning Summary";
                    }
                    action("loans outstanding")
                    {
                        Caption = 'Loan Outstanding';
                        RunObject = report "Loans Outstanding";
                    }
                    action("Loans Product Summary")
                    {
                        RunObject = report "Loan Product Summary";
                    }
                    action("Loans Insider Lending")
                    {
                        Caption = 'Loans Insider Lending';
                        RunObject = report "Loan Register - Insider";
                    }

                    action("Loan Balance VS Non Performing")
                    {
                        Caption = 'Loan Balance VS Non Performing';
                        RunObject = report "Loan Bal VS Np Loans";
                    }
                    action("Member Loans Register")
                    {
                        Caption = 'Customer Loans Register';
                        RunObject = report "Member Loans Register";
                    }
                    action("Credit Comm - Loan Disburement Report")
                    {
                        Caption = 'Credit Comm - Loan Disburement Report';
                        RunObject = report "Credit Comm - Disbursement";
                    }
                    action("Defaulter Notice 1")
                    {
                        Caption = 'Loan Defaulter Notice 1';
                        RunObject = report "Loan Defaulter Notice1";
                    }
                    action("Defaulter Notice 1 Collateral")
                    {
                        Caption = 'Loan Defaulter Notice1 Collateral';
                        RunObject = report "Loan Defaulter Notice1 Coll";
                    }
                    action("Defaulter Notice 2")
                    {
                        Caption = 'Loan Defaulter Notice 2';
                        RunObject = report "Loan Defaulter Notice2";
                    }
                    action("Defaulter Notice 3")
                    {
                        Caption = 'Loan Defaulter Notice3';
                        RunObject = report "Loan Defaulter Notice3";
                    }
                    action("Generate Repayment Schedule")
                    {
                        RunObject = report "Generate Rep Schedule";
                    }
                    action("Repayment Schedule")
                    {
                        RunObject = report "Loan Repayment Schedule";
                    }
                    action(Statement2)
                    {
                        RunObject = report "Customer Loan Stm";
                    }
                }
            }
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
                action("Customer Service List(Finance)")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Service List(Finance)';
                    RunObject = page "Customer Service List(Finance)";
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
    var
        Control25: Action;
}
