page 71707010 "Service Statistics Factbox"
{
    Caption = 'Customer Info';
    PageType = CardPart;
    SourceTable = "Case";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Service No."; Rec."Service No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service No. field.', Comment = '%';
                    trigger OnDrillDown()
                    begin
                        ShowDetails;
                    end;
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
            }
            group("Loan Details")
            {
                field("Applied Loans"; "No of Applied Loans")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        LoansR.SetFilter("Customer No.", Rec."Customer No.");
                        LoansR.SetRange(Status, LoansR.Status::Open);
                        Page.Run(Page::"Loan List", LoansR);
                    end;
                }
                field("Approved Loans"; "No of Approved Loans")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        LoansR.SetFilter("Customer No.", Rec."Customer No.");
                        LoansR.SetRange(Status, LoansR.Status::Approved);

                        Page.Run(Page::"Loans List", LoansR);
                    end;
                }
                field("Declined Loans"; "No of Declined Loans")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        LoansR.SetFilter("Customer No.", Rec."Customer No.");
                        LoansR.SetRange(Status, LoansR.Status::Rejected);
                        Page.Run(Page::"Loan List", LoansR);
                    end;
                }
                field("Disbursed Loans"; "No of Disbursed Loans")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        LoansR.SetFilter("Customer No.", Rec."Customer No.");
                        LoansR.SetRange(Posted, true);
                        Page.Run(Page::"Loan Posted List", LoansR);
                    end;
                }
            }
            group("Collateral Details")
            {
                field("Open Collaterals"; "No of Open Collaterals")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CollRegister.SetRange("Customer No.", Rec."Customer No.");
                        CollRegister.SetRange(Status, CollRegister.Status::Open);
                        Page.Run(Page::"Collateral Register - List");
                    end;
                }
                field("Approved Collaterals"; "No of Approved Collaterals")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CollRegister.SetRange("Customer No.", Rec."Customer No.");
                        CollRegister.SetRange(Status, CollRegister.Status::Approved);
                        Page.Run(Page::"Collateral Register - List");
                    end;
                }
                field("Rejected Collaterals"; "No of Declined Collaterals")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CollRegister.SetRange("Customer No.", Rec."Customer No.");
                        CollRegister.SetRange(Status, CollRegister.Status::Rejected);
                        Page.Run(Page::"Collateral Register - List");
                    end;
                }
                field("Active Collaterals"; "No of Active Collaterals")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CollRegister.SetRange("Customer No.", Rec."Customer No.");
                        CollRegister.SetRange(Status, CollRegister."Collateral Status"::Active);
                        Page.Run(Page::"Collateral Register - List");
                    end;
                }
                field("Inactive Collaterals"; "No of Inactive Collaterals")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CollRegister.SetRange("Customer No.", Rec."Customer No.");
                        CollRegister.SetRange(Status, CollRegister."Collateral Status"::Inactive);
                        Page.Run(Page::"Collateral Register - List");
                    end;
                }
                field("Withdrawn Collaterals"; "No of Withdrawn Collaterals")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CollRegister.SetRange("Customer No.", Rec."Customer No.");
                        CollRegister.SetRange(Status, CollRegister."Collateral Status"::Withdrawn);
                        Page.Run(Page::"Collateral Register - List");
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        CalculateLoanStatistics;
        CalculateCollateralStatistics;
    end;

    local procedure CalculateLoanStatistics()
    begin
        "No of Applied Loans" := CountLoansByStatus(LoansR.Status::Open, false);
        "No of Approved Loans" := CountLoansByStatus(LoansR.Status::Approved, false);
        "No of Declined Loans" := CountLoansByStatus(LoansR.Status::Rejected, false);
        "No of Disbursed Loans" := CountDisbursedLoans;
    end;

    local procedure CalculateCollateralStatistics()
    begin
        "No of Open Collaterals" := CountCollateralsByStatus(CollRegister.Status::Open);
        "No of Approved Collaterals" := CountCollateralsByStatus(CollRegister.Status::Approved);
        "No of Declined Collaterals" := CountCollateralsByStatus(CollRegister.Status::Rejected);
        "No of Active Collaterals" := CountCollateralsByStatus(CollRegister."Collateral Status"::Active);
        "No of Inactive Collaterals" := CountCollateralsByStatus(CollRegister."Collateral Status"::Inactive);
        "No of Withdrawn Collaterals" := CountCollateralsByStatus(CollRegister."Collateral Status"::Withdrawn);
    end;

    local procedure CountLoansByStatus(StatusFilter: Option; IncludePosted: Boolean): Integer
    var
        LoanRec: Record Loans;
    begin
        IncludePosted := true;
        LoanRec.SetRange("Customer No.", Rec."Customer No.");
        LoanRec.SetRange(Status, StatusFilter);

        if not IncludePosted then
            LoanRec.SetRange(Posted, false);
        exit(LoanRec.Count());
    end;

    local procedure CountDisbursedLoans(): Integer
    var
        LoanRec: Record Loans;
    begin
        LoanRec.SetRange("Customer No.", Rec."Customer No.");
        LoanRec.SetRange(Posted, true);
        exit(LoanRec.Count());
    end;

    local procedure CountCollateralsByStatus(StatusFilter: Option): Integer
    var
        CollateralRec: Record "Collateral Register";
    begin
        CollateralRec.SetRange("Customer No.", Rec."Customer No.");
        CollateralRec.SetRange(Status, StatusFilter);
        exit(CollateralRec.Count());
    end;

    /*trigger OnAfterGetRecord()
    begin
        //Open Loans
        LoansR.Reset();
        LoansR.SetRange("Customer No.", Rec."Customer No.");
        LoansR.SetRange(Status, LoansR.Status::Open);
        if LoansR.FindSet() then begin
            repeat
                LoanCount += 1;
                "No of Applied Loans" := LoanCount;
            until LoansR.next = 0;
        end;
        //Approved Loans
         LoansR.Reset();
        LoansR.SetRange("Customer No.", Rec."Customer No.");
        LoansR.SetRange(Status, LoansR.Status::Approved);
        if LoansR.FindSet() then begin
            repeat
                ApprovedLoans += 1;
                "No of Approved Loans" := ApprovedLoans;
            until LoansR.next = 0;
        end;
        //Declined Loans
         LoansR.Reset();
        LoansR.SetRange("Customer No.", Rec."Customer No.");
        LoansR.SetRange(Status, LoansR.Status::Rejected);
        if LoansR.FindSet() then begin
            repeat
                RejectedLoans += 1;
                "No of Declined Loans" := RejectedLoans;
            until LoansR.next = 0;
        end;

        //Disbursed Loans
         LoansR.Reset();
        LoansR.SetRange("Customer No.", Rec."Customer No.");
        LoansR.SetRange(Posted, true);
        if LoansR.FindSet() then begin
            repeat
                DisbursedLoans += 1;
                "No of Disbursed Loans" := DisbursedLoans;
            until LoansR.next = 0;
        end;
        //Open collaterals
      CollRegister.Reset();
        CollRegister.SetRange("Customer No.", Rec."Customer No.");
        CollRegister.SetRange(Status, CollRegister.Status::Open);
        if CollRegister.FindSet() then begin
            repeat
                CollateralCount += 1;
                "No of Open Collaterals" := CollateralCount;
            until CollRegister.Next() = 0;
        end;
        //Approved collaterals
         CollRegister.Reset();
        CollRegister.SetRange("Customer No.", Rec."Customer No.");
        CollRegister.SetRange(Status, CollRegister.Status::Approved);
        if CollRegister.FindSet() then begin
            repeat
                CollateralCount += 1;
                "No of Approved Collaterals" := CollateralCount;
            until CollRegister.Next() = 0;
        end;
        //Rejected collaterals
         CollRegister.Reset();
        CollRegister.SetRange("Customer No.", Rec."Customer No.");
        CollRegister.SetRange(Status, CollRegister.Status::Rejected);
        if CollRegister.FindSet() then begin
            repeat
                CollateralCount += 1;
                "No of Declined Collaterals" := CollateralCount;
            until CollRegister.Next() = 0;
        end;
        //Active collaterals
         CollRegister.Reset();
        CollRegister.SetRange("Customer No.", Rec."Customer No.");
        CollRegister.SetRange(Status, CollRegister."Collateral Status"::Active);
        if CollRegister.FindSet() then begin
            repeat
                CollateralCount += 1;
                "No of Active Collaterals" := CollateralCount;
            until CollRegister.Next() = 0;
        end;
        //Inactive collaterals
         CollRegister.Reset();
        CollRegister.SetRange("Customer No.", Rec."Customer No.");
        CollRegister.SetRange(Status, CollRegister."Collateral Status"::Inactive);
        if CollRegister.FindSet() then begin
            repeat
                CollateralCount += 1;
                "No of Inactive Collaterals" := CollateralCount;
            until CollRegister.Next() = 0;
        end;
        //Withdrawn collaterals
         CollRegister.Reset();
        CollRegister.SetRange("Customer No.", Rec."Customer No.");
        CollRegister.SetRange(Status, CollRegister."Collateral Status"::Withdrawn);
        if CollRegister.FindSet() then begin
            repeat
                CollateralCount += 1;
                "No of Withdrawn Collaterals" := CollateralCount;
            until CollRegister.Next() = 0;
        end;
    end;
*/
    local procedure ShowDetails()
    var
        Cust: Record Customer;

    begin

    end;

    var
        SvrHeader: Record "Case";
        SvrRelHeaderLine: Record "Case Lines";
        Cust: Record Customer;
        LoansR: Record Loans;
        CollRegister: Record "Collateral Register";
        LoanGuarantors: Record "Loan Guarantors and Security";
        LoanCount: Integer;
        RejectedLoans: Integer;
        ApprovedLoans: Integer;
        DisbursedLoans: Integer;
        CollateralCount: Integer;
        "No of Applied Loans": Integer;
        "No of Declined Loans": Integer;
        "No of Approved Loans": Integer;
        "No of Disbursed Loans": Integer;
        "No of Open Collaterals": Integer;
        "No of Approved Collaterals": Integer;
        "No of Declined Collaterals": Integer;
        "No of Active Collaterals": Integer;
        "No of Inactive Collaterals": Integer;
        "No of Withdrawn Collaterals": Integer;
        "Loan No.": code[100];
        "Loan Product Type": code[100];
        "Loan Product Name": text[100];
        "Applied Amount": Decimal;
        "Approved Amount": Decimal;
        "Installments": Integer;
        "Interest": Decimal;
        "Outstanding Balance": Decimal;
        "Outstanding Interest": Decimal;
        "Outstanding Penalty": Decimal;
        "Application Date": Date;
        "Disbursement Date": Date;
        "Next Repayment Date": Date;
        "Expected Date of Completion": Date;
        LoansPage: Page "Loan List";
        LoansPosted: page "Loan Posted List";


}
