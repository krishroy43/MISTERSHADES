codeunit 50000 "User Management ext"

{
    procedure LookupUserId(VAR UserName: Code[50]): Boolean
    var
        SID: Guid;
    Begin
        EXIT(LookupUser(UserName, SID));
    End;

    procedure LookupUser(VAR UserName: Code[50]; VAR SID: GUID): Boolean
    var
        User: Record User;
    begin
        User.RESET;
        User.SETCURRENTKEY("User Name");
        User."User Name" := UserName;
        IF User.FIND('=><') THEN;
        IF PAGE.RUNMODAL(PAGE::Users, User) = ACTION::LookupOK THEN BEGIN
            UserName := User."User Name";
            SID := User."User Security ID";
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    procedure ConfirmProcess(ConfirmQuestion: Text; DefaultButton: Boolean): Boolean
    begin
        IF NOT GUIALLOWED THEN
            EXIT(DefaultButton);
        EXIT(CONFIRM(ConfirmQuestion, DefaultButton));
    end;
}


