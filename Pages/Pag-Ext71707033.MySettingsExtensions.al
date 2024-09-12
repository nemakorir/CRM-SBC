pageextension 71707033 "My Settings Extensions" extends "User Settings"
{
    layout
    {
        modify(UserRoleCenter)
        {
            Visible = AllowChangeRole;
        }
        modify(Company)
        {
            Visible = AllowChangeCompanyName;
        }
        modify("Work Date")
        {
            Visible = AllowChangeWorkDay;
        }
        modify(Region)
        {
            Visible = AllowChangeRegion;
        }
        modify(LanguageName)
        {
            Visible = AllowChangeLanguage;
        }
        modify("Time Zone")
        {
            Visible = AllowChangeTimeZone;
        }
    }
    trigger OnOpenPage();
    begin
        AllowChangeRole := false;
        AllowChangeCompanyName := false;
        AllowChangeWorkDay := false;
        AllowChangeRegion := false;
        AllowChangeLanguage := false;
        AllowChangeTimeZone := false;
        UserSetup.SetRange("User ID", UserId);
        // Message('UserId:%1', UserId);
        if UserSetup.FindFirst() then
            // Message('UsetSetupUserId:%1', UserSetup."User ID");
            if UserSetup."Allow Open My Settings" then begin
                AllowChangeRole := UserSetup."Allow Change Role";
                AllowChangeCompanyName := UserSetup."Allow Change Company";
                AllowChangeWorkDay := UserSetup."Allow Change Work Day";
                AllowChangeRegion := UserSetup."Allow Change Region";
                AllowChangeLanguage := UserSetup."Allow Change Language";
                AllowChangeTimeZone := UserSetup."Allow Change TimeZone";
                exit;
            end;
        Error(NoPermission);
    end;

    var
        AllowChangeRole: Boolean;
        AllowChangeCompanyName: Boolean;
        AllowChangeWorkDay: Boolean;
        AllowChangeRegion: Boolean;
        AllowChangeLanguage: Boolean;
        AllowChangeTimeZone: Boolean;
        UserSetup: Record "User Setup";
        NoPermission: Label 'You do not have permission to open the My Settings page. Please contact your administrator';
}
