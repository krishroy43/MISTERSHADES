tableextension 50046 "Ext Pur. Cre. Memo Header" extends "Purch. Cr. Memo Hdr."
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
            //TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."));
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."), "Job Task Type" = const (Posting));
        }
        field(50900; Narration; text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
}