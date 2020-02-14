tableextension 50041 "Ext Cust. Ledger Entry" extends "Cust. Ledger Entry"
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
        field(50050; "Posting Type"; Option)
        {
            OptionMembers = " ",Advance,Running,Retention;
        }
        field(50001; "Job Task No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."));
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."), "Job Task Type" = const (Posting));
        }
        field(50051; "Retention Reversal"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        // Start 05-09-2019
        field(50052; "Do Not Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // Stop 05-09-2019

    }
}