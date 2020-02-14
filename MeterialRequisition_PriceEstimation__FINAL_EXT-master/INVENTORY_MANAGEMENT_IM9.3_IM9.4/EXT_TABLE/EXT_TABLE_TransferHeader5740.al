tableextension 50007 "Ext. Transfer Header" extends "Transfer Header"
{

    fields
    {
        field(50001; "Job No."; Code[20])
        {
            TableRelation = Job;
            trigger
            OnValidate()
            var
                JobsRecL: Record Job;
            begin
                if "Job No." <> xRec."Job No." then
                    ClearVarialbe();

                JobsRecL.Reset();
                if JobsRecL.Get("Job No.") then begin
                    "Job description" := JobsRecL.Description;
                    Validate("Dimension Set ID", CopyFromJobDimensionToReleaseProductionOrder("Job No."));
                    Modify();
                end;
            end;
        }
        field(50002; "Job description"; Text[150])
        {

        }
        field(50003; "Job Task No"; Code[20])
        {
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."), "Job Task Type" = const(Posting));
            trigger
            OnValidate()
            var
                JobTaskRecL: Record "Job Task";
            begin
                JobTaskRecL.Reset();
                if JobTaskRecL.Get("Job No.", "Job Task No") then begin
                    "Job Task Description" := JobTaskRecL.Description;
                    Modify();

                end;

                if "Job Task No" = '' then
                    Clear("Job Task Description");
            end;

        }
        field(50004; "Job Task Description"; Text[150])
        {

        }
        field(50005; Creator; Code[50])
        {
            TableRelation = User."Full Name";
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management ext";
            begin
                UserMgt.LookupUserID(Creator)
            end;
        }
        field(50006; Receiver; Code[50])
        {
            TableRelation = User."Full Name";
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management ext";
            begin
                UserMgt.LookupUserID(Receiver);
            end;
        }

    }

    procedure ClearVarialbe()
    begin
        clear("Job description");
        //clear("Job No.");
        Clear("Job Task No");
        Clear("Job Task Description");
        "Dimension Set ID" := 0;
        Modify();

    end;

    procedure CopyFromJobDimensionToReleaseProductionOrder(JobNoP: Code[20]): Integer
    var
        DefaultDimensionRecL: Record "Default Dimension";
        DimensionSetEntryRecL: Record "Dimension Set Entry" temporary;
        DimensionValueRecL: Record "Dimension Value";
        DimensionManagementCU: Codeunit DimensionManagement;
    begin
        DefaultDimensionRecL.Reset();
        DefaultDimensionRecL.SetCurrentKey("Table ID", "No.", "Dimension Code");
        DefaultDimensionRecL.SetRange("Table ID", Database::Job);
        DefaultDimensionRecL.SetRange("No.", JobNoP);
        if DefaultDimensionRecL.FindSet() then begin
            repeat
                DimensionSetEntryRecL.Init();
                DimensionSetEntryRecL.Validate("Dimension Code", DefaultDimensionRecL."Dimension Code");
                DimensionSetEntryRecL.Validate("Dimension Value Code", DefaultDimensionRecL."Dimension Value Code");

                DimensionValueRecL.Reset();
                DimensionValueRecL.SetRange("Dimension Code", DefaultDimensionRecL."Dimension Code");
                DimensionValueRecL.SetRange(Code, DefaultDimensionRecL."Dimension Value Code");
                if DimensionValueRecL.FindFirst() then
                    DimensionSetEntryRecL.Validate("Dimension Value ID", DimensionValueRecL."Dimension Value ID");

                if DimensionSetEntryRecL.Insert() then;
            until DefaultDimensionRecL.Next() = 0;
        end;

        exit(DimensionManagementCU.GetDimensionSetID(DimensionSetEntryRecL));


    end;
}