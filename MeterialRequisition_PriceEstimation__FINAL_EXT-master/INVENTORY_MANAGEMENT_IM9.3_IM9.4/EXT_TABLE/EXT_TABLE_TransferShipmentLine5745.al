tableextension 50010 "Ext. Transfer Shipment Line" extends "Transfer Shipment Line"
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
                    Modify();
                end;
            end;
        }
        field(50002; "Job description"; Text[150])
        {

        }
        field(50003; "Job Task No"; Code[20])
        {
            //TableRelation = "Job Task"."Job Task No." where ("Job No." = field ("Job No."));
            TableRelation = "Job Task"."Job Task No." where ("Job No." = field ("Job No."), "Job Task Type" = const (Posting));
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
        field(50005; "Requisition No."; Code[30])
        {
            TableRelation = "Material Requisition Header";
        }
    }
    procedure ClearVarialbe()
    begin
        clear("Job description");
        //clear("Job No.");
        Clear("Job Task No");
        Clear("Job Task Description");

    end;

}