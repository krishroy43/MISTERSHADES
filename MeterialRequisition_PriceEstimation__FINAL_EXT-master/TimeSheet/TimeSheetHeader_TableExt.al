tableextension 50101 TimeSheet extends "Time Sheet Header"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Resource Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Resource.Name where("No." = field("Resource No.")));
        }
    }

    var
        myInt: Integer;
}