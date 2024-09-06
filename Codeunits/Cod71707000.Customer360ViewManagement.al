codeunit 71707000 "Customer 360 View Management"
{
    procedure ActiveGuarantorsCount(CustNo: Code[100]): Integer
    begin
        GuarantorCount := 0;
        /* CollRegister.Reset();
         CollRegister.SetRange("Customer No.", CustNo);
         CollRegister.SetRange("Collateral Status", CollRegister."Collateral Status"::Active);
         CollRegister.SetRange("Is Owner?", CollRegister."Is Owner?"::No);
         CollRegister.SetRange(Status, CollRegister.Status::Approved);
         IF CollRegister.FindSet() then begin
             repeat
                 LoanGuarantors.Reset();
                 LoanGuarantors.SetRange("Collateral Reg. No.", CollRegister."No.");
                 if LoanGuarantors.FindSet() then begin
                     repeat
                         LoanGuarantors.CalcFields("Outstanding Balance");
                         if (LoanGuarantors."Outstanding Balance" > 0) then begin
                             GuarantorCount += 1;
                             Guarantors := GuarantorCount;
                         end;
                     until LoanGuarantors.Next() = 0;
                 end;
             until CollRegister.Next() = 0;
         end;*/
        CollRegister.Reset();
        CollRegister.SetRange("Customer No.", CustNo);
        CollRegister.SetRange("Is Owner?", CollRegister."Is Owner?"::No);
        CollRegister.SetRange(Status, CollRegister.Status::Approved);
        if CollRegister.FindSet() then begin
            repeat
                GuarantorCount += 1;
                Guarantors := GuarantorCount;
            until CollRegister.Next() = 0;
        end;
        exit(GuarantorCount); // Return the total count
    end;

    procedure CalculateSurcharge(CustNo: Code[100]): Decimal
    var
    Today:Date;
    begin
        Today:=WorkDate();
        LoansR.Reset();
        LoansR.SetRange("Customer No.", CustNo);
        Surcharge := 0;
        if LoansR.FindSet() then begin
            repeat
                //Calculate surcharge

                LoansR.CalcFields("Outstanding Balance");
                LoanAmount := LoansR."Approved Amount";
                InterestRate := LoansR.Interest;
                RepayPeriod := LoansR.Installments;
                Lbalance := LoansR."Outstanding Balance";
                HalfThePeriod := LoansR.Installments;
                PayOffPeriodFlat := 6;
                MinPayOffPeriodAmortised := 3;
                // Calculate the loan's service period
                RepStartDate := LoansR."Repayment Start Date"; // Assuming "Repayment Start Date" is available in LoansR
                CurrentDate := Today;
                StartMonth := Date2DMY(RepStartDate, 2);
                StartYear := Date2DMY(RepStartDate, 3);
                CurrentMonth := Date2DMY(CurrentDate, 2);
                CurrentYear := Date2DMY(CurrentDate, 3);

                // Calculate the difference in months between the repayment start date and the current month
                MonthsDifference := (CurrentYear - StartYear) * 12 + (CurrentMonth - StartMonth);
                "Loan's Service Period" := MonthsDifference;
                Message('MonthsDifference:%1', MonthsDifference);

                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Straight Line" then begin
                    LInterest := (InterestRate / 12 / 100) * LoanAmount;
                    InterestDue := LInterest;
                    //Calculate Surchage
                    SurchagePeriod := PayOffPeriodFlat - "Loan's Service Period";
                    //Message('SurchagePeriod:%1', SurchagePeriod);
                    if "Loan's Service Period" >= PayOffPeriodFlat then begin
                        Surcharge := 0;
                    end;
                    if "Loan's Service Period" < PayOffPeriodFlat then begin
                        SurchargeFee := InterestDue * SurchagePeriod;
                        //exit(SurchargeFee);
                        //Message('SurchargeFee:%1', SurchargeFee);
                        Surcharge += SurchargeFee;

                    end;

                end;
                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::Amortised then begin
                    LInterest := (InterestRate / 12 / 100) * LBalance;
                    InterestDue := LInterest;
                    //Calculate Surcharge
                    HalfThePeriod := HalfThePeriod / 2;
                    if "Loan's Service Period" >= HalfThePeriod then begin
                        Surcharge := 0;
                        //Message('SurchargeFee:%1', "Additional Fees");
                    end;
                    if (("Loan's Service Period" < MinPayOffPeriodAmortised) and ("Loan's Service Period" < HalfThePeriod)) then begin
                        SurchargeFee := InterestDue * 2;
                        //Message('SurchargeFee:%1', SurchargeFee);
                        //exit(SurchargeFee);
                        Surcharge += SurchargeFee;
                    end;
                    if (("Loan's Service Period" >= MinPayOffPeriodAmortised) and ("Loan's Service Period" < HalfThePeriod)) then begin
                        SurchargeFee := InterestDue;
                        //Message('SurchargeFee:%1', SurchargeFee);
                        //exit(SurchargeFee);
                        Surcharge += SurchargeFee;
                    end;
                end;
                if (LoansR."Interest Calculation Method" in [LoansR."Interest Calculation Method"::"Reducing Balance",
                                                         LoansR."Interest Calculation Method"::Constants]) then begin
                    LPrincipal := OutstandingBal / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LBalance;
                    InterestDue := LInterest;
                end;
            until LoansR.Next() = 0;
        end;
    end;

    var
        Cust: Record Customer;
        LoansR: Record Loans;
        CollRegister: Record "Collateral Register";
        Insurance: Record "Insurance Policy";
        LoanGuarantors: Record "Loan Guarantors and Security";
        Opprt: Record Opportunity;
        Camp: Record Campaign;
        segment: Record "Segment Line";
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
        "Closed Cases": Integer;
        "Approved Loan Application": Integer;
        "Declined Loan Application": Integer;
        Surcharge: Integer;
        "Additional Interest": Decimal;
        Surchargecount: Integer;
        AdditionalInterestCount: decimal;
        CaseCount: Integer;
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
        RepaymentCount: Integer;
        PreviousPostingMonth: Integer;
        CurrentPostingMonth: Integer;
        RepStartDate: Date;
        CurrentMonthStart: Date;
        CurrentDate: Date;
        StartMonth: Integer;
        StartYear: Integer;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        YearsDifference: Integer;
        MonthsDifference: Integer;
        "Loan's Service Period": integer;
        PayOffPeriodFlat: Integer;
        MinPayOffPeriodAmortised: Integer;
        PayOffPeriod: Integer;
        HalfThePeriod: Integer;
        InterestDue: Decimal;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LInterest: Decimal;
        LPrincipal: Decimal;
        TotalMRepay: Decimal;
        Lbalance: Decimal;
        GenSetup: Record "General Setup";
        OutstandingBal: Decimal;
        SurchargeFee: Decimal;
        SurchagePeriod: Integer;
}
