table 50416 "Year of Purchase Comp."
{
    fields
    {
        field(1; Years; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; Years)
        {
            Clustered = true;
        }
    }

}


page 50334 "Year List"
{
    SourceTable = "Year of Purchase Comp.";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(Years; Years)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}