page 50049 "Job Task Master"
{
    PageType = List;
    SourceTable = "Job Task Master";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Job Task Type"; "Job Task Type")
                {
                    ApplicationArea = All;
                }
                field(Billable; Billable)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

