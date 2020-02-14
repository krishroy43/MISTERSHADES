tableextension 50057 "Ext Dimension" extends Dimension
{
    fields
    {
        field(50000; "Sales Person Dimension"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            begin

            end;
        }
    }
}



pageextension 50097 "Ext Dimension" extends Dimensions
{
    layout
    {
        addafter(Blocked)
        {
            field("Sales Person Dimension"; "Sales Person Dimension")
            {
                ApplicationArea = All;
            }
        }
    }
}