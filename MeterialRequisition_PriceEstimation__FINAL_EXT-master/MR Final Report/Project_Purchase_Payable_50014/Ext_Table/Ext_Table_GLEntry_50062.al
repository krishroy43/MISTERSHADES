tableextension 50062 "Ext G/L Entry" extends "G/L Entry"
{
    fields
    {
        // Start 09-07-2019
        field(50052; "Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        // Stop 09-07-2019
    }
}