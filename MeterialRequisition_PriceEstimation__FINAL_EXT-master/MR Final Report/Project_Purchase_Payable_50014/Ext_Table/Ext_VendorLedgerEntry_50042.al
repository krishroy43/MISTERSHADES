tableextension 50042 "Ext Vendor Ledger Entry" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger
            OnValidate()
            begin
                IF "Job No." = xRec."Job No." THEN
                    Clear("Job Task No.");
            end;
        }
        field(50001; "Job Task No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."));
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."), "Job Task Type" = const (Posting));
        }

    }
}