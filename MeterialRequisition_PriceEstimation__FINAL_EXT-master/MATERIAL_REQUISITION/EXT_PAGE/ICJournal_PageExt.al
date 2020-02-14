pageextension 50105 ICJournal extends "IC General Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter(Comment)
        {
            field("IC Partner Code"; "IC Partner Code")
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