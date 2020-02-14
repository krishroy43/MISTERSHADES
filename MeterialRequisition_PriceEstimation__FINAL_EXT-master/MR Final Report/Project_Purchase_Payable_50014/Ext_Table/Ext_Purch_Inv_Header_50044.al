tableextension 50045 "Ext Purchase Invoice Header" extends "Purch. Inv. Header"
{
    fields
    {
        field(50005; "Job No."; Code[20])
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
        field(50007; "Job Task No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."), "Job Task Type" = const (Posting));
        }
    }
}