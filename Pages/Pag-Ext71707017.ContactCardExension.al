pageextension 71707017 "Contact Card Exension" extends "Contact Card"
{
    layout
    {
        modify("Search Name")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }
        modify("Organizational Level Code")
        {
            Visible = false;
        }
        modify("Contact Business Relation")
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = false;
        }
        modify("Parental Consent Received")
        {
            Caption = 'Consent Received';
        }
        modify("Phone No.")
        {
            Visible = false;
        }

        modify(Address)
        {
            Visible = false;
        }
        modify("Address 2")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }
        modify("Post Code")
        {
            Visible = false;
        }
        modify(City)
        {
            Visible = false;
        }
        modify("Home Page")
        {
            Visible = false;
        }
        modify(ShowMap)
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Territory Code")
        {
            Visible = false;
        }
        modify("VAT Registration No.")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Mobile Phone No.")
        {
            ShowMandatory = true;
            trigger OnBeforeValidate()
            begin
                /*if StrLen(Rec."Mobile Phone No.") <> 10 then begin
                    Error('The mobile phone number must contain exactly 10 characters.');
                end;*/
                if not TypeHelper.IsPhoneNumber(Rec."Mobile Phone No.") then
                    Error(Rec."Mobile Phone No.", PhoneNoCannotContainLettersErr);
            end;
        }
        modify("E-Mail")
        {

            trigger OnBeforeValidate()
            begin
                MailManagement.CheckValidEmailAddress(Rec."E-Mail");
            end;
        }

        addafter(Type)
        {
            field("Contact Name"; Rec."Contact Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Contact Type"; Rec."Contact Type")
            {
                ApplicationArea = All;

            }
            field("Campaign No."; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
            field("Campaign Name"; Rec."Campaign Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            /* field(IsCustomer; Rec.IsCustomer)
             {
                 ApplicationArea = All;

                 trigger OnValidate()
                 begin
                     if Rec.IsCustomer = true then begin
                         IsEditable := false;

                     end;
                 end;
             }
             field("Customer No."; Rec."Customer No.")
             {
                 ApplicationArea = All;
             }*/
        }
        addbefore("Company No.")
        {
            field("Source Of Business"; Rec."Source Of Business")
            {
                ApplicationArea = All;
            }
            field("Recruited By"; Rec."Recruited By")
            {
                ApplicationArea = All;
            }
            field("SalesPerson Name"; Rec."SalesPerson Name")
            {
                ApplicationArea = All;
            }
            field("Relationship Officer Code"; Rec."Relationship Officer Code")
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
        }

    }
    actions
    {
        modify("Create Opportunity")
        {
            trigger OnAfterAction()
            begin
                /*Rec.TestField(Name);
                Rec.TestField("Mobile Phone No.");
                Rec.TestField("Source Of Business");
                Rec.TestField("Salesperson Code");
                Rec.TestField("Relationship Officer Name");*/
                if Rec.Name = '' then begin
                    Error('Name must have a value in Contact: ' + Rec."No." + '. It cannot be zero or empty.');
                end;
                if Rec."Mobile Phone No." = '' then begin
                    Error('Mobile Phone No. must have a value in Contact: ' + Rec."No." + '. It cannot be zero or empty.');
                end;
                if Format(Rec."Source Of Business") = '' then begin
                    Error('Source Of Business must have a value in Contact: ' + Rec."No." + '. It cannot be zero or empty.');
                end;
                if Format(Rec."Relationship Officer Name") = '' then begin
                    Error('Relationship Officer Name must have a value in Contact: ' + Rec."No." + '. It cannot be zero or empty.');
                end else begin
                    Opprt.Init();
                    Opprt."Contact No." := Rec."No.";
                    Opprt."Contact Company No." := Rec."Company No.";
                    Opprt."Contact Company Name" := rec."Company Name";
                    Opprt."Contact Name" := Rec.Name;
                    Opprt."Lead Name" := Rec.Name;
                    Opprt."Campaign No." := Rec."Campaign No.";
                    Opprt."Campaign Name" := Rec."Campaign Name";
                    Opprt.CampNo := rec."Campaign No.";
                    Opprt.CampName := rec."Campaign Name";
                    Opprt."Recruited By" := Rec."Recruited By";
                    Opprt."Sales Person" := Rec."SalesPerson Name";
                    Opprt."Relationship Officer Code" := Rec."Relationship Officer Code";
                    Opprt."Relationship Officer Name" := Rec."Relationship Officer Name";
                    Opprt."Phone No." := Rec."Mobile Phone No.";
                    Opprt."Source Of Business" := Rec."Source Of Business";
                    Opprt."Lead Type" := Opprt."Lead Type"::"Interested Lead";
                    Opprt."Sales Cycle Code" := 'HOT';
                    Opprt."Lead Email" := Rec."E-Mail";
                    Opprt."Contact Type" := Rec."Contact Type";
                    Opprt."Branch Code" := Rec."Branch Code";
                    Opprt.Insert(true);
                    Page.Run(Page::"Opportunity Card", Opprt);
                end;
            end;
        }
    }
    local procedure CreateLead()
    begin
        Opprt.Init();
        Opprt."Contact No." := Rec."No.";
        Opprt."Campaign No." := Rec."Company No.";
        Opprt."Contact Name" := Rec.Name;
        Opprt."Campaign Name" := Rec."Company Name";
        Opprt."Source Of Business" := Rec."Source Of Business";
        Opprt."Salesperson Code" := Rec."Salesperson Code";
        Opprt."Relationship Officer Name" := Rec."Relationship Officer Name";
        Opprt."Phone No." := Rec."Mobile Phone No.";

        Opprt.Insert(true);
        Page.Run(Page::"Opportunity Card", Opprt);
    end;



    var
        Cust: Record Customer;
        SegLine: Record "Segment Line";
        IsEditable: Boolean;
        IsVisible: Boolean;
        IsCompanyContact: Boolean;
        Opprt: Record Opportunity;
        MailManagement: Codeunit "Mail Management";
        TypeHelper: Codeunit "Type Helper";
        PhoneNoCannotContainLettersErr: Label 'Must not Contain Letters';


}
