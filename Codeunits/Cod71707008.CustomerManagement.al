codeunit 71707008 "Customer Management"
{
    procedure LeadManagement()
    begin
        //Entry No
        LastCustNo := '';
        AddNo := '1';
        MemberApplication.Init();
        MemberApplication.Reset();
        if MemberApplication.FindSet() then begin
            repeat
                if Cust.FindLast() then
                    LastCustNo := Cust."No.";
                Cust.Next();
                Cust.Init();
                Cust."Campaign No." := MemberApplication."Campaign No.";
                Cust."Campaign Name" := MemberApplication."Campaign Name";
                Cust."Segment No." := MemberApplication."Segment No.";
                Cust."Segment Name" := MemberApplication."Segment Name";
                Cust.Insert();
            until MemberApplication.Next() = 0;
        end;
    end;

    var
        MemberApplication: Record "Member Application";
        Cust: Record Customer;
        MemberEditable: record "Member Editable";
        LastCustNo: Text[200];
        AddNo: Text[200];
}
