pageextension 50102 TimeSheetExt extends "Time Sheet List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Resource No.")
        {
            field("Resource Name"; "Resource Name")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}