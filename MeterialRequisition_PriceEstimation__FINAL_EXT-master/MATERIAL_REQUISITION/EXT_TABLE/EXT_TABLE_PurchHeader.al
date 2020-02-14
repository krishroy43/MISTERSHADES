tableextension 50029 PurchaseQuoteTbl extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(50002; "Enquiry No."; Code[20])
        { }
        field(50003; "Requisition No."; Code[20])
        { }
        field(50004; "Purchaser Type"; Option)
        {
            OptionMembers = " ",Import,General,"Raw Material",Branded;
        }
        field(50005; "Job No."; Code[20])
        {

            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger
            OnValidate()
            begin
                IF "Job No." = xRec."Job No." THEN
                    Clear("Job Task No.");

                Validate("Dimension Set ID", CopyFromJobDimensionToReleaseProductionOrder("Job No."));

            end;
        }
        field(50007; "Job Task No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."));
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."), "Job Task Type" = const (Posting));
        }
        field(50008; "Ref. No."; Code[20])
        { }
        field(50009; "Remarks"; Code[20])
        { }
        field(50900; Narration; text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;


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