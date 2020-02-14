table 50220 "Site Status Report"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Documet No"; code[20])
        {

            trigger OnValidate();
            begin
                if "Documet No" <> xRec."Documet No" then begin
                    GLS.get;
                    "No. Series" := '';
                end;
            end;
        }
        field(3; Description; Text[250])
        { }
        field(4; Description2; Text[250])
        { }
        field(5; "Job No."; Code[20])
        {
            TableRelation = Job;
            trigger OnValidate();
            begin
                //if JobRec.get("Job No.") then
                JobRec.reset;
                JobRec.SetRange("No.", "Job No.");
                if JobRec.FindFirst() then
                    "Job Description" := JobRec.Description;


            end;
        }
        field(6; "Job Description"; text[50])
        {
        }
        field(7; "Job Task No."; Code[20])
        {
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."), "Job Task Type" = FILTER (Posting));
            trigger OnValidate();
            begin
                //if JobTaskRec.Get("Job Task No.") then
                JobTaskRec.Reset();
                JobTaskRec.SetRange("Job No.", "Job No.");
                JobTaskRec.SetRange("Job Task No.", "Job Task No.");
                if JobTaskRec.FindFirst() then
                    "Job task Description" := JobTaskRec.Description;
            end;

        }
        field(8; "Job task Description"; Text[50])
        {

        }
        field(9; User; Code[20])
        {
            Editable = false;
            trigger OnValidate();
            begin
                User := UserId;
            end;
        }
        field(10; Resource; Text[20])
        {

        }
        field(11; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(12; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Open,Released;
            Editable = false;
            /* OptionCaption = ,Open,Released;
             OptionCaptionML = ,Open,Released; */
            trigger OnValidate();
            begin
                if Status = Status::Released then;
                // INITINSERT_R();
            end;
        }
        field(13; "No. Series"; code[20])
        {
            TableRelation = "No. Series";
            Editable = false;
        }
        field(14; "Site Status -Released Doc No."; Code[20])
        {
            trigger OnValidate();
            begin
                if "Site Status -Released Doc No." <> xRec."Site Status -Released Doc No." then begin
                    GLS.get;
                    "No. Series" := '';
                end;
            end;
        }
        field(15; Department; Option)
        {
            OptionMembers = " ","FrontDesk","Back Office Sales",Sales,Design,Project,Production,Store,Management;
        }
        field(16; "Approve"; Boolean)
        {
            Editable = false;
        }
        field(17; "Entry Type"; Option)
        {
            OptionMembers = " ","Site Status","Site Schedule";
        }
        field(18; "Planned Date"; Date)
        {

        }
    }

    keys
    {
        key(PK; "Documet No", "Line No.")
        {
            Clustered = true;
        }

    }

    var
        Rec2: Record "Site Status Report";
        JobRec: Record job;
        JobTaskRec: Record "Job Task";
        GLS: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert();
    var
        USerSetupRecL: Record "User Setup";
    begin
        INITINSERT();
        User := UserId;
        Date := Today;
        if USerSetupRecL.Get(UserId) then
            Validate(Department, USerSetupRecL.Departments);


    END;


    trigger OnModify();
    begin
    end;

    trigger OnDelete();
    begin
    end;

    trigger OnRename();
    begin
    end;

    local procedure INITINSERT()
    begin
        /*rec2.Reset();
        rec2.SetRange("Documet No", xRec."Documet No");
        if rec2.findLast then begin
            if rec2.Status = Rec2.Status::Released then begin*/
        if xRec.Status = Xrec.Status::Open then
            "Documet No" := xrec."Documet No";


        GLS.RESET();
        GLS.GET();
        IF "Documet No" = '' THEN BEGIN
            NoSeriesMgt.InitSeries(GLS."Site Status Doc No.", xRec."Documet No", TODAY(), "Documet No", GLS."Site Status Doc No.")
        END;
    end;

    procedure INITINSERT_R(DocNo: Code[20])
    var
        Rec2: Record "Site Status Report";
    begin
        If xRec."Documet No" = rec."Documet No" then
            "Site Status -Released Doc No." := xRec."Documet No";

        GLS.RESET();
        GLS.GET();
        Rec2.Reset();
        Rec2.SetRange("Documet No", DocNo);
        if Rec2.FindFirst() then
            IF "Site Status -Released Doc No." = '' THEN BEGIN
                //NoSeriesMgt.InitSeries(GLS."Site Status Released Doc No.", xRec."Site Status -Released Doc No.", TODAY(), "Site Status -Released Doc No.", GLS."Site Status Released Doc No.")
                "Site Status -Released Doc No." := NoSeriesMgt.GetNextNo(GLS."Site Status Released Doc No.", Today, false);
                //Message('%1', "Site Status -Released Doc No.");
                Modify();
            END;

    end;

}