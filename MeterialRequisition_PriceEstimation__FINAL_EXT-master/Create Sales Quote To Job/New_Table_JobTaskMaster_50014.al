table 50014 "Job Task Master"
{
    Caption = 'Job Task Master';
    //DrillDownPageID = 1002;
    //LookupPageID = 1002;

    fields
    {
        field(1; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Job Task Type"; Option)
        {
            Caption = 'Job Task Type';
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";
        }
        field(4; "Billable"; Boolean)
        {
            trigger
            OnValidate()
            begin
                if "Job Task Type" <> "Job Task Type"::Posting then
                    Error('Job Task Type must be Posting.');
            end;
        }

    }
}
