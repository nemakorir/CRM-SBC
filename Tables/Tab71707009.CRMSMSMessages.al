table 71707009 "CRM SMS Messages"
{
    Caption = 'CRM SMS Messages';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; Source; Option)
        {
            OptionMembers = "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","Birthday wishes"," ATM Application Failed","ATM Collection","Mobile Banking","Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Dormancy;
        }
        field(3; "Telephone No"; Code[20])
        {
        }
        field(4; "Date Entered"; Date)
        {
        }
        field(5; "Time Entered"; Time)
        {
        }
        field(6; "Entered By"; Code[150])
        {
        }
        field(7; "SMS Message"; Text[300])
        {
        }
        field(8; "Sent To Server"; Option)
        {
            OptionMembers = No,Yes,Failed;
        }
        field(9; "Date Sent to Server"; Date)
        {
        }
        field(13; "Account No"; Code[30])
        {
        }
        field(15; "Document No"; Code[30])
        {
        }
        field(16; "System Created Entry"; Boolean)
        {
        }
        field(17; "Bulk SMS Balance"; Decimal)
        {
        }
        field(21; IsChargeable; Boolean)
        {
        }
        field(22; Posted; Boolean)
        {
        }
        field(23; Source2; Code[20])
        {
        }
        field(24; "Scheduled Date"; Date)
        {
        }
        field(25; "Scheduled Time"; Time)
        {
        }
        field(26; Remarks; Text[100])
        {
        }
    }
    keys
    {
        key(Key1; "Entry No")
        {
        }
    }
}
