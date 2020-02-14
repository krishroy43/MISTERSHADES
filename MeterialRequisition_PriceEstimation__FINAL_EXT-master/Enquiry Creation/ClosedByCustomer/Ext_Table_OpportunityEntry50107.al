tableextension 50107 OppEntryExtends extends "Opportunity Entry"
{
    fields
    {
        field(50000; CustomerNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

        }
        field(50101; LeadType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Customer","Contact";//OptionMembers = " ",Contact,Customer; 
        }
        // Start 27-06-2019
        field(50102; "Sales Cycle Stage Name"; text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50103; "Assign to"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger
            OnValidate()
            var
                EmployeeRecL: Record Employee;
            begin
                EmployeeRecL.Reset();
                if EmployeeRecL.Get("Assign to") then
                    "Assign to Name" := EmployeeRecL."First Name";

                if "Assign to" = ' ' then
                    Clear("Assign to Name");

            end;
        }
        field(50104; "Assign to Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // Stop 27-06-2019
        // Start 14-08-2019
        field(50105; "Updated By"; Code[90])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // Stop 14-08-2019
    }



    var
        myInt: Integer;




    var
        Customer: Record Customer;
        Opp: Record Opportunity;
        SalesCycleStage: Record "Sales Cycle Stage";

    procedure TestCust();
    begin

    end;


    procedure OnAfterInsert_OppEntry();
    begin
        Opp.GET("Opportunity No.");
        CASE "Action Taken" OF
            "Action Taken"::" ",
            "Action Taken"::Next,
            "Action Taken"::Previous,
            "Action Taken"::Updated,
            "Action Taken"::Jumped:
                BEGIN
                    IF SalesCycleStage.GET("Sales Cycle Code", "Sales Cycle Stage") THEN
                        "Sales Cycle Stage Description" := SalesCycleStage.Description;
                    IF Opp.Status <> Opp.Status::"In Progress" THEN BEGIN
                        Opp.Status := Opp.Status::"In Progress";
                        Opp.MODIFY;
                    END;
                END;
            "Action Taken"::Won:
                BEGIN
                    //TestCust;
                    IF Opp.Status <> Opp.Status::Won THEN BEGIN
                        Opp.Status := Opp.Status::Won;
                        Opp.Closed := TRUE;
                        Opp."Date Closed" := "Date of Change";
                        "Date Closed" := "Date of Change";
                        "Estimated Close Date" := "Date of Change";
                        Opp.MODIFY;
                    END;
                END;
            "Action Taken"::Lost:
                IF Opp.Status <> Opp.Status::Lost THEN BEGIN
                    Opp.Status := Opp.Status::Lost;
                    Opp.Closed := TRUE;
                    Opp."Date Closed" := "Date of Change";
                    "Date Closed" := "Date of Change";
                    "Estimated Close Date" := "Date of Change";
                    Opp.MODIFY;
                END;
        END;

    end;



    procedure InsertEntry_(VAR OppEntry: Record "Opportunity Entry"; CancelOldTask: Boolean; CreateNewTask: Boolean)
    var
        OppEntry2: Record "Opportunity Entry";
        EntryNo: Integer;
    begin
        OppEntry2.RESET;
        IF OppEntry2.FINDLAST THEN
            EntryNo := OppEntry2."Entry No."
        ELSE
            EntryNo := 0;
        OppEntry2.SETCURRENTKEY(Active, "Opportunity No.");
        OppEntry2.SETRANGE(Active, TRUE);
        OppEntry2.SETRANGE("Opportunity No.", OppEntry."Opportunity No.");
        IF OppEntry2.FINDFIRST THEN BEGIN
            OppEntry2.Active := FALSE;
            OppEntry2."Days Open" := OppEntry."Date of Change" - OppEntry2."Date of Change";
            OppEntry2.MODIFY;
        END;
        OppEntry2 := OppEntry;
        OppEntry2."Entry No." := EntryNo + 1;

        OppEntry2.Active := TRUE;
        OppEntry2.CreateTask_CUS(CancelOldTask, CreateNewTask);
        OppEntry2.INSERT();
        OppEntry2.OnAfterInsert_OppEntry();
        OppEntry := OppEntry2;
    end;

    procedure CheckStatus_Cust()
    begin
        IF NOT ("Action Taken" IN ["Action Taken"::Won, "Action Taken"::Lost]) THEN
            ERROR('You must select either Won or Lost.');
        IF "Close Opportunity Code" = '' THEN
            Error('Close Opportunity Code must not blank');
        //ErrorMessage(FIELDCAPTION("Close Opportunity Code"));
        IF "Date of Change" = 0D THEN
            Error('Date of Change Must not Blank');
        // ErrorMessage(FIELDCAPTION("Date of Change"));
        IF "Action Taken" = "Action Taken"::Won THEN
            IF "Calcd. Current Value (LCY)" <= 0 THEN
                ERROR('Sales (LCY) must be greater than 0.');
    end;


    procedure FinishWizard_CUS()
    var
        OppEntry: Record "Opportunity Entry";
    begin
        UpdateEstimates;
        OppEntry := Rec;
        InsertEntry_(OppEntry, "Cancel Old To Do", FALSE);
        DELETE;
    end;

    procedure CreateTask_CUS(CancelOldTask: Boolean; CreateNewTask: Boolean)
    var
        SalesCycleStage: Record "Sales Cycle Stage";
        Task: Record "To-do";

    begin
        IF CancelOldTask THEN
            Task.CancelOpenTasks("Opportunity No.");

        IF CreateNewTask THEN
            IF SalesCycleStage.GET("Sales Cycle Code", "Sales Cycle Stage") THEN
                IF SalesCycleStage."Activity Code" <> '' THEN BEGIN
                    Opp.GET("Opportunity No.");
                    Task."No." := '';
                    Task."Campaign No." := "Campaign No.";
                    Task."Segment No." := Opp."Segment No.";
                    Task."Salesperson Code" := "Salesperson Code";
                    Task.VALIDATE("Contact No.", "Contact No.");
                    Task."Opportunity No." := "Opportunity No.";
                    Task."Opportunity Entry No." := "Entry No.";
                    Task.Date := "Date of Change";
                    Task.Duration := 1440 * 1000 * 60;
                    Task.Modify;
                    //Task.InsertTask(
                    // Task, TempRMCommentLine, TempAttendee,
                    //TempTaskInteractionLanguage, TempAttachment,
                    //SalesCycleStage."Activity Code", FALSE);
                END;
    end;

    procedure UpdateEstimates_()
    var
        SalesCycle: Record "Sales Cycle";
        SalesHeader: Record "Sales Header";

    begin
        IF SalesCycleStage.GET("Sales Cycle Code", "Sales Cycle Stage") THEN BEGIN
            SalesCycle.GET("Sales Cycle Code");
            IF ("Chances of Success %" = 0) AND (SalesCycleStage."Chances of Success %" <> 0) THEN
                "Chances of Success %" := SalesCycleStage."Chances of Success %";
            "Completed %" := SalesCycleStage."Completed %";
            CASE SalesCycle."Probability Calculation" OF
                SalesCycle."Probability Calculation"::Multiply:
                    "Probability %" := "Chances of Success %" * "Completed %" / 100;
                SalesCycle."Probability Calculation"::Add:
                    "Probability %" := ("Chances of Success %" + "Completed %") / 2;
                SalesCycle."Probability Calculation"::"Chances of Success %":
                    "Probability %" := "Chances of Success %";
                SalesCycle."Probability Calculation"::"Completed %":
                    "Probability %" := "Completed %";
            END;
            "Calcd. Current Value (LCY)" := "Estimated Value (LCY)" * "Probability %" / 100;
            IF ("Estimated Close Date" = "Date of Change") OR ("Estimated Close Date" = 0D) THEN
                "Estimated Close Date" := CALCDATE(SalesCycleStage."Date Formula", "Date of Change");
        END;

        CASE "Action Taken" OF
            "Action Taken"::Won:
                BEGIN
                    Opp.GET("Opportunity No.");
                    IF SalesHeader.GET(SalesHeader."Document Type"::Quote, Opp."Sales Document No.") THEN
                        "Calcd. Current Value (LCY)" := GetSalesDocValue(SalesHeader);

                    "Completed %" := 100;
                    "Chances of Success %" := 100;
                    "Probability %" := 100;
                END;
            "Action Taken"::Lost:
                BEGIN
                    "Calcd. Current Value (LCY)" := 0;
                    "Completed %" := 100;
                    "Chances of Success %" := 0;
                    "Probability %" := 0;
                END;
        END;
        MODIFY;
    end;

    procedure StartWizard_CUS()
    begin
        INSERT;
        IF PAGE.RUNMODAL(PAGE::"Close Opportunity For Customer", Rec) = ACTION::OK THEN;
    end;

    procedure CloseOppFromOpp_CUS(VAR Opp: Record Opportunity)
    begin
        Opp.TESTFIELD(Closed, FALSE);
        DELETEALL;
        INIT;
        VALIDATE("Opportunity No.", Opp."No.");
        "Sales Cycle Code" := Opp."Sales Cycle Code";
        "Contact No." := Opp."Contact No.";
        "Contact Company No." := Opp."Contact Company No.";
        "Salesperson Code" := Opp."Salesperson Code";
        "Campaign No." := Opp."Campaign No.";
        // Code Added
        CustomerNo := opp."Customer No.";
        LeadType := Opp."Lead Type";
        // Code Added
        StartWizard_CUS;
    end;

    trigger
    OnAfterInsert()
    begin
        Validate("Updated By", UserId);
        Modify();
    end;
}