pageextension 71707011 "Member Statistic FactBox ext" extends "Member Statistic FactBox"
{
    layout
    {
        addafter(Name)
        {
            field("Member Status"; Rec."Member Status")
            {
                ApplicationArea = All;
            }
            field("Type of Customer"; Rec."Type of Customer")
            {
                ApplicationArea = All;
            }
            field("Customer Category"; Rec."Customer Category")
            {
                ApplicationArea = All;
            }
            field("Customer Sector"; Rec."Customer Sector")
            {
                ApplicationArea = All;
            }
        }
        addafter("Mobile Phone No")
        {
            field("P.I.N Code"; Rec."P.I.N Code")
            {
                ApplicationArea = All;
                visible = false;
            }
            field("Date of Birth"; Rec."Date of Birth")
            {
                ApplicationArea = All;
                visible = true;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = All;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
            field("Pref. Mode Of Communication"; Rec."Pref. Mode Of Communication")
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
            field(Nationality; Rec.Nationality)
            {
                ApplicationArea = All;
            }

        }
        addafter("Total Loan Balance")
        {
            field("Additional Interest"; "Additional Interest")
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    LoansR.Reset();
                    LoansR.SetRange("Customer No.", Rec."No.");
                    LoansR.SetFilter("Additional Interest", '>0');
                    Page.Run(Page::"Loan Posted List", LoansR);
                end;
            }
            field(Surcharge; Surcharge)
            {
                ApplicationArea = All;

            }

        }
        addbefore("Outstanding Balance")
        {
            group("Member Credit Information")
            {
                Caption = 'Member Credit Information';

            }
        }
        modify("No. of Loans")
        {
            Visible = false;
        }
        addafter("No. of Loans")
        {
            field("Active Loans"; "Active Loans")
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    LoansR.Reset();
                    LoansR.SetRange("Customer No.", Rec."No.");
                    LoansR.SetFilter("Outstanding Balance", '>0');
                    Page.Run(Page::"Loan List P", LoansR);
                end;
            }
            field("Completed Loans"; "Completed Loans")
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    LoansR.Reset();
                    LoansR.SetRange("Customer No.", Rec."No.");
                    LoansR.SetRange(Posted, true);
                    LoansR.SetFilter("Outstanding Balance", '=0');
                    Page.Run(Page::"Loan Posted List", LoansR);
                end;
            }
        }
        addafter("Unbanked Cheques")
        {
            group(Collaterals)
            {
                field("Active Collaterals"; "No of Active Collaterals")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        TempCollRegister.DeleteAll();

                        CollRegister.Reset();
                        CollRegister.SetRange("Customer No.", Rec."No.");
                        CollRegister.SetRange("Collateral Status", CollRegister."Collateral Status"::Active);
                        // CollRegister.SetRange("Is Owner?", CollRegister."Is Owner?"::Yes);
                        CollRegister.SetRange(Status, CollRegister.Status::Approved);

                        if CollRegister.FindSet() then begin
                            repeat
                                LoanGuarantors.Reset();
                                LoanGuarantors.SetRange("Collateral Reg. No.", CollRegister."No.");
                                LoanGuarantors.SetFilter("Outstanding Balance", '>0');

                                if LoanGuarantors.FindSet() then begin
                                    // Store filtered records in a temprary table
                                    TempCollRegister := CollRegister;
                                    TempCollRegister.Insert();
                                end;
                            until CollRegister.Next() = 0;
                        end;
                        Page.Run(Page::"Collateral Register - List", TempCollRegister);
                    end;

                }
                field("Inactive Collaterals"; "No of Inactive Collaterals")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        TempCollRegister.DeleteAll();

                        CollRegister.Reset();
                        CollRegister.SetRange("Customer No.", Rec."No.");
                        CollRegister.SetRange("Collateral Status", CollRegister."Collateral Status"::Inactive);
                        CollRegister.SetRange(Status, CollRegister.Status::Approved);

                        if CollRegister.FindSet() then begin
                            repeat
                                LoanGuarantors.Reset();
                                LoanGuarantors.SetRange("Collateral Reg. No.", CollRegister."No.");
                                LoanGuarantors.SetFilter("Outstanding Balance", '=0');

                                if LoanGuarantors.FindSet() then begin
                                    // Store filtered records in a temprary table
                                    TempCollRegister := CollRegister;
                                    TempCollRegister.Insert();
                                end
                                else begin
                                    TempCollRegister := CollRegister;
                                    TempCollRegister.Insert();
                                end;
                            until CollRegister.Next() = 0;
                        end;
                        Page.Run(Page::"Collateral Register - List", TempCollRegister);
                    end;
                }
                field("Withdrawn Collaterals"; "No of Withdrawn Collaterals")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CollRegister.Reset();
                        CollRegister.SetRange("Customer No.", Rec."No.");
                        CollRegister.SetRange("Collateral Status", CollRegister."Collateral Status"::Withdrawn);
                        Page.Run(Page::"Collateral Register - List", CollRegister);
                    end;
                }
                field("Active Insurance Policy"; "Active Insurance Policy")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        Insurance.SetRange("Customer No.", Rec."No.");
                        Insurance.SetFilter("Expiry date", '>%', Today);
                        //Insurance.SetFilter("Expiry date", '<>%1', 0D);
                        Page.Run(Page::"Insurance Policy List", Insurance);
                    end;
                }
                field("Expired Insurance Policy"; "Expired Insurance Policy")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        Insurance.SetRange("Customer No.", Rec."No.");
                        Insurance.SetFilter("Expiry date", '<%', Today);
                        //Insurance.SetFilter("Expiry date", '<>%1', 0D);
                        Page.Run(Page::"Insurance Policy List", Insurance);
                    end;
                }
                field(Guarantors; Guarantors)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CustNo := rec."No.";
                        CollRegister.SetRange("Customer No.", CustNo);
                        CollRegister.SetRange("Is Owner?", CollRegister."Is Owner?"::No);
                        CollRegister.SetRange(Status, CollRegister.Status::Approved);
                        Page.Run(Page::"Collateral Register - List", CollRegister);
                    end;
                }
            }
            group("Interactions")
            {

                field("Customer Interactions"; "Customer Interactions")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        segmentRec: Record "Interaction Log Entry";
                    begin
                        segmentRec.SetFilter("Contact Name", Rec.Name);
                        Page.Run(Page::"Interaction Log Entries", segmentRec);
                    end;
                }
                field("Open Cases"; "Open Cases")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        SVRHeader.SetFilter("Customer No.", Rec."No.");
                        SVRHeader.SetRange("Stage", SVRHeader.Stage::Open);
                        Page.Run(Page::"Customer Service List", SVRHeader);
                    end;
                }
                field("Cases In Progress"; "Cases In Progress")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        SVRHeader.SetFilter("Customer No.", Rec."No.");
                        SVRHeader.SetRange(Stage, SVRHeader.Stage::"In Progress");
                        Page.Run(Page::"Customer Service List", SVRHeader);
                    end;
                }
                field("Closed Cases"; "Closed Cases")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        SVRHeader.SetFilter("Customer No.", Rec."No.");
                        SVRHeader.SetRange(Stage, SVRHeader.Stage::Closed);
                        Page.Run(Page::"Customer Service List", SVRHeader);
                    end;
                }
                field("Open Customer Requests"; "Open Customer Reguest")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CustomeReguest.SetRange("Customer No", Rec."No.");
                        CustomeReguest.SetRange(Status, CustomeReguest.Status::Applied);
                        Page.Run(Page::"Customer Request List", CustomeReguest);
                    end;
                }
                field("Closed Customer Requests"; "Closed Customer Request")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        CustomeReguest.SetRange("Customer No", Rec."No.");
                        CustomeReguest.SetRange(Status, CustomeReguest.Status::Approved);
                        Page.Run(Page::"Customer Request List", CustomeReguest);
                    end;

                }
                group("Opportunities List")
                {

                    field(Opportunities; Opportunities)
                    {
                        ApplicationArea = All;

                        trigger OnDrillDown()
                        var
                            OpprtRec: Record "Opportunity";
                        begin
                            OpprtRec.SetFilter("Contact Name", Rec.Name);
                            Page.Run(Page::"Opportunity List", OpprtRec);
                        end;
                    }
                    field("Approved Loan Application"; "Approved Loan Application")
                    {
                        ApplicationArea = All;
                        trigger OnDrillDown()
                        begin
                            LoansR.SetRange("Customer No.", Rec."No.");
                            LoansR.SetRange(Status, LoansR.Status::Approved);
                            LoansR.SetRange(Posted, true);
                            Page.Run(Page::"Loan Posted List", LoansR);
                        end;
                    }
                    field("Declined Loan Application"; "Declined Loan Application")
                    {
                        ApplicationArea = All;
                        trigger OnDrillDown()
                        begin
                            LoansR.SetRange("Customer No.", Rec."No.");
                            LoansR.SetRange(Status, LoansR.Status::Rejected);
                            Page.Run(Page::"Loan Posted List", LoansR);
                        end;
                    }
                    field(Headroom; Headroom)
                    {
                        ApplicationArea = All;
                    }
                }
                field(Campaigns; Campaigns)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        segment.SetFilter("Contact Name", Rec.Name);
                        Page.Run(Page::"Segment Subform", segment);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        // Reset counters
        "No of Active Collaterals" := 0;
        "No of Inactive Collaterals" := 0;
        "No of Withdrawn Collaterals" := 0;
        "Active Insurance Policy" := 0;
        "Expired Insurance Policy" := 0;
        "Open Cases" := 0;
        "Cases In Progress" := 0;
        "Closed Cases" := 0;
        "Guarantors" := 0;
        "Inactive Guarantors" := 0;
        "Customer Interactions" := 0;
        Opportunities := 0;
        Campaigns := 0;
        "Active Loans" := 0;
        "Completed Loans" := 0;
        CollateralCount := 0;
        InactiveCollateralCount := 0;
        WithdrawnCollateralCount := 0;
        //ActiveInsuranceCount := 0;
        ExpiredInsuranceCount := 0;
        GuarantorCount := 0;
        InactiveGuarantorCount := 0;
        OpportunityCount := 0;
        CustomerInteractionCount := 0;
        CampaignCount := 0;
        CaseCount := 0;
        InprogressCaseCount := 0;
        ClosedCaseCount := 0;
        LoanCount := 0;
        ActiveLoanCount := 0;
        CompletedLoanCount := 0;
        "Approved Loan Application" := 0;
        "Declined Loan Application" := 0;
        "Additional Interest" := 0;
        AdditionalInterestCount := 0;
        Surcharge := 0;
        Surchargecount := 0;
        "Open Customer Reguest" := 0;
        CustomerReguestCount := 0;
        "Closed Customer Request" := 0;
        ClosedCustomerReguestCount := 0;
        TotalApprovedAmountCount := 0;
        Headroom := 0;
        TotalLoanBal := 0;

        //*******************************************Active and Complete Loans
        LoansR.Reset();
        LoansR.CalcFields("Outstanding Balance");
        LoansR.SetRange("Customer No.", Rec."No.");
        LoansR.SetFilter("Outstanding Balance", '>0');
        if LoansR.FindSet() then begin
            repeat
                ActiveLoanCount += 1;
                "Active Loans" := ActiveLoanCount;
            until LoansR.Next() = 0;
        end;

        LoansR.Reset();
        LoansR.CalcFields("Outstanding Balance");
        LoansR.SetRange("Customer No.", Rec."No.");
        LoansR.SetRange(Posted, true);
        LoansR.SetFilter("Outstanding Balance", '=0');
        if LoansR.FindSet() then begin
            repeat
                CompletedLoanCount += 1;
                "Completed Loans" := CompletedLoanCount;
            until LoansR.Next() = 0;
        end;
        //*******************************************approved and declined loan applications
        LoansR.Reset();
        LoansR.SetRange("Customer No.", Rec."No.");
        LoansR.SetRange(Status, LoansR.Status::Approved);
        LoansR.SetRange(Posted, true);
        if LoansR.FindSet() then begin
            repeat
                LoanCount += 1;
                "Approved Loan Application" := LoanCount;
            until LoansR.Next() = 0
        end;
        LoansR.Reset();
        LoansR.SetRange("Customer No.", Rec."No.");
        LoansR.SetRange(Status, LoansR.Status::Rejected);
        if LoansR.FindSet() then begin
            LoanCount += 1;
            "Declined Loan Application" := LoanCount;
            repeat until LoansR.Next() = 0;
        end;

        LoansR.Reset();
        LoansR.SetRange("Customer No.", Rec."No.");
        if LoansR.FindSet() then begin
            repeat
                AdditionalInterestCount += LoansR."Additional Interest";
            until LoansR.Next() = 0;
            "Additional Interest" := AdditionalInterestCount;
            //MESSAGE('Total Additional Interest: %1', AdditionalInterestCount);
        end;
        //HeadRoom Count
        LoansR.Reset();
        LoansR.SetRange("Customer No.", Rec."No.");
        LoansR.SetRange(Posted, true);
        loansR.SetFilter("Outstanding Balance", '>0');
        if LoansR.FindSet() then begin
            repeat
                LoansR.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Penalty");
                TotalApprovedAmountCount += LoansR."Approved Amount";
                TotalLoanBal += LoansR."Outstanding Balance" + LoansR."Outstanding Interest" + LoansR."Outstanding Penalty";
            until LoansR.Next() = 0;
            //Message('TotalLoanBal:%1',TotalLoanBal);
            Headroom := TotalApprovedAmountCount - TotalLoanBal;

        end;
        //*****************************Collaterals*****************************
        // Active Collaterals
        CollRegister.Reset();
        CollRegister.SetRange("Customer No.", Rec."No.");
        CollRegister.SetRange("Collateral Status", CollRegister."Collateral Status"::Active);
        //CollRegister.SetRange("Is Owner?", CollRegister."Is Owner?"::Yes);
        CollRegister.SetRange(Status, CollRegister.Status::Approved);
        IF CollRegister.FindSet() then begin
            repeat
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange("Collateral Reg. No.", CollRegister."No.");
                if LoanGuarantors.FindSet() then begin
                    repeat
                        LoanGuarantors.CalcFields("Outstanding Balance");
                        if (LoanGuarantors."Outstanding Balance" > 0) then begin
                            CollateralCount += 1;
                            "No of Active Collaterals" := CollateralCount;
                        end;
                    until LoanGuarantors.Next() = 0;
                end;
            until CollRegister.Next() = 0;
        end;
        // Inactive Collaterals
        CollRegister.Reset();
        CollRegister.SetRange("Customer No.", ReC."No.");
        CollRegister.SetRange("Collateral Status", CollRegister."Collateral Status"::Inactive);
        CollRegister.SetRange(Status, CollRegister.Status::Approved);
        IF CollRegister.FindSet() then begin
            repeat
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange("Collateral Reg. No.", CollRegister."No.");
                if LoanGuarantors.FindSet() then begin
                    repeat
                        LoanGuarantors.CalcFields("Outstanding Balance");
                        if (LoanGuarantors."Outstanding Balance" = 0) then begin
                            InactiveCollateralCount += 1;
                            "No of Inactive Collaterals" := InactiveCollateralCount;
                        end;
                    until LoanGuarantors.Next() = 0;
                end
                else begin
                    InactiveCollateralCount += 1;
                    "No of Inactive Collaterals" := InactiveCollateralCount;
                end;
            until CollRegister.Next() = 0;
        end;

        CollRegister.Reset();
        CollRegister.SetRange("Customer No.", ReC."No.");
        CollRegister.SetRange("Collateral Status", CollRegister."Collateral Status"::Withdrawn);
        IF CollRegister.FindSet() then begin
            repeat
                WithdrawnCollateralCount += 1;
                "No of withdrawn Collaterals" := WithdrawnCollateralCount;
            until CollRegister.Next() = 0;
        end;
        //*********************************************Insurance Policy
        // Active Insurance Policy
        ActiveInsuranceCount := 0;
        Insurance.Reset();
        Insurance.SetRange("Customer No.", Rec."No.");
        Insurance.SetFilter("Expiry date", '>%1', Today);
        if Insurance.FindSet() then begin
            repeat
                ActiveInsuranceCount += 1;
                "Active Insurance Policy" := ActiveInsuranceCount;
            until Insurance.Next() = 0;
        end;

        // Expired Insurance Policy
        ExpiredInsuranceCount := 0;
        Insurance.Reset();
        Insurance.SetRange("Customer No.", Rec."No.");
        Insurance.SetFilter("Expiry date", '<%1', Today);
        //Insurance.SetFilter("Expiry date", '<>%1', 0D);
        if Insurance.FindSet() then begin
            repeat
                ExpiredInsuranceCount += 1;
                "Expired Insurance Policy" := ExpiredInsuranceCount;
            until Insurance.Next() = 0;
        end;
        //Guarantors
        CollRegister.Reset();
        CustNo := Rec."No.";
        //Guarantors := CustViewManagement.ActiveGuarantorsCount(CustNo);
        CollRegister.Reset();
        CollRegister.SetRange("Customer No.", Rec."No.");
        CollRegister.SetRange("Is Owner?", CollRegister."Is Owner?"::No);
        CollRegister.SetRange(Status, CollRegister.Status::Approved);
        if CollRegister.FindSet() then begin
            repeat
                GuarantorCount += 1;
                Guarantors := GuarantorCount;
            until CollRegister.Next() = 0;

        end;

        //CustomerInteractions
        segmentRec.Reset();
        segmentRec.SetFilter("Contact Name", Rec.Name);
        if segmentRec.FindSet() then begin
            repeat
                CustomerInteractionCount += 1;
                "Customer Interactions" := CustomerInteractionCount;
            until segmentRec.Next() = 0;
        end;

        //Customer Interactions
        /*Contact.Reset();
        Contact.SetRange("Customer No.", Rec."No.");
        if Contact.FindFirst() then begin

        end;*/
        //Opportunities
        Opprt.Reset();
        Opprt.SetFilter("Contact Name", Rec.Name);
        if Opprt.FindSet() then begin
            repeat
                OpportunityCount += 1;
                Opportunities := OpportunityCount;
            until Opprt.Next() = 0;
        end;
        //Campigns
        segment.Reset();
        segment.SetFilter("Contact Name", Rec.Name);
        if segment.FindSet() then begin
            repeat
                CampaignCount += 1;
                Campaigns := CampaignCount;
            until segment.Next() = 0;
        end;
        //Cases
        SVRHeader.Reset();
        SVRHeader.SetRange("Customer No.", Rec."No.");
        SVRHeader.SetRange("Stage", SVRHeader.Stage::Open);
        if SVRHeader.FindSet() then begin
            repeat
                CaseCount += 1;
                "Open Cases" := CaseCount;
            until SVRHeader.Next() = 0;

        end;

        SVRHeader.Reset();
        SVRHeader.SetRange("Customer No.", Rec."No.");
        SVRHeader.SetRange(Status, SVRHeader.Status::Closed);
        if SVRHeader.FindSet() then begin
            repeat
                ClosedCaseCount += 1;
                "Closed Cases" := ClosedCaseCount;
            until SVRHeader.Next() = 0;

        end;
        SVRHeader.Reset();
        SVRHeader.SetRange("Customer No.", Rec."No.");
        SVRHeader.SetRange("Stage", SVRHeader.Stage::"In Progress");
        if SVRHeader.FindSet() then begin
            repeat
                InprogressCaseCount += 1;
                "Cases In Progress" := InprogressCaseCount;
            until SVRHeader.Next() = 0;

        end;
        //Calulate Surcharge
        //Surcharge := CustViewManagement.CalculateSurcharge(Rec."No.");

        //Open Customer Reguest

        CustomeReguest.SetRange("Customer No", Rec."No.");
        CustomeReguest.SetRange(Status, CustomeReguest.Status::Applied);
        if CustomeReguest.FindSet() then begin
            repeat
                CustomerReguestCount += 1;
                "Open Customer Reguest" := CustomerReguestCount;
            until CustomeReguest.Next() = 0;
        end;
        //Closed Custmer Reguest

        CustomeReguest.SetRange("Customer No", Rec."No.");
        CustomeReguest.SetRange(Status, CustomeReguest.Status::Approved);
        if CustomeReguest.FindSet() then begin
            repeat
                ClosedCustomerReguestCount += 1;
                "Closed Customer Request" := ClosedCustomerReguestCount;
            until CustomeReguest.Next() = 0;
        end;
    end;

    var
        Cust: Record Customer;
        CustViewManagement: Codeunit "Customer 360 View Management";
        CustNo: Code[100];
        LoansR: Record Loans;
        CollRegister: Record "Collateral Register";
        Insurance: Record "Insurance Policy";
        LoanGuarantors: Record "Loan Guarantors and Security";
        Opprt: Record Opportunity;
        Camp: Record Campaign;
        segment: Record "Segment Line";
        Contact: Record Contact;
        segmentRec: Record "Interaction Log Entry";
        SVRHeader: Record "Svr Rel.Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        "No of Active Collaterals": Integer;
        "No of Inactive Collaterals": Integer;
        "No of Withdrawn Collaterals": Integer;
        "Active Insurance Policy": Integer;
        "Expired Insurance Policy": Integer;
        "Active Loans": Integer;
        "Completed Loans": Integer;
        "Open Cases": Integer;
        "Cases In Progress": Integer;
        "Closed Cases": Integer;
        "Approved Loan Application": Integer;
        "Declined Loan Application": Integer;
        Surcharge: Integer;
        "Additional Interest": Decimal;
        Surchargecount: Integer;
        AdditionalInterestCount: decimal;
        CaseCount: Integer;
        InprogressCaseCount: Integer;
        ClosedCaseCount: Integer;
        Guarantors: Integer;
        "Inactive Guarantors": Integer;
        InactiveGuarantorCount: integer;
        "Customer Interactions": integer;
        "Opportunities": Integer;
        "Campaigns": Integer;
        CollateralCount: Integer;
        InactiveCollateralCount: Integer;
        WithdrawnCollateralCount: Integer;
        ActiveInsuranceCount: Integer;
        ExpiredInsuranceCount: Integer;
        GuarantorCount: Integer;
        OpportunityCount: Integer;
        CustomerInteractionCount: Integer;
        CampaignCount: Integer;
        LoanCount: Integer;
        ActiveLoanCount: Integer;
        CompletedLoanCount: Integer;
        TempCollRegister: Record "Collateral Register" temporary;
        "Open Customer Reguest": Integer;
        "Closed Customer Request": Integer;
        CustomerReguestCount: integer;
        ClosedCustomerReguestCount: Integer;
        CustomeReguest: record "Customer Request";
        Headroom: Decimal;
        HeadroomCount: integer;
        TotalApprovedAmountCount: Decimal;
        TotalLoanBal: Decimal;
        "Preferred Mode of Communication": Text[100];

}
