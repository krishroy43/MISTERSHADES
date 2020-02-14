tableextension 50017 "Ext. Sale Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "Dispatch Type"; Option)
        {
            OptionMembers = "Partial","Final";
        }
        field(50101; "Job No."; Code[20])
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
        field(50102; "Job description"; Text[150])
        {

        }
        field(50103; "Job Task No"; Code[20])
        {
            //  TableRelation = "Job Task"."Job Task No." where ("Job No." = field ("Job No."));
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
        field(50104; "Job Task Description"; Text[150])
        {

        }
        field(50109; "Delivery Location"; Text[250])
        {

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

pageextension 50505 "Exp Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Quote No.")
        {
            field("Delivery Location"; "Delivery Location")
            {
                ApplicationArea = All;
            }
        }
    }
}