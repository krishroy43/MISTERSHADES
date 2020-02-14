pageextension 50666 "Ext Item Card" extends "Item Card"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; "No. 2")
            {
                ApplicationArea = All;
            }
        }

    }


}

pageextension 50667 "Ext Item List" extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("No. 2"; "No. 2")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast(navigation)
        {
            action("Replicate No.2")
            {
                ApplicationArea = All;
                Image = Replan;
                trigger OnAction()
                var
                    RecItem: Record Item;
                begin
                    Clear(RecItem);
                    RecItem.SetFilter("No.", '<>%1', '');
                    if RecItem.FindSet() then begin
                        if not Confirm('Are you sure you want to update the No.2 field of all the Items?') then
                            Exit;
                        repeat
                            RecItem."No. 3" := RecItem."No. 2";
                            RecItem.Modify();
                        until RecItem.Next() = 0;
                    end;
                end;
            }
        }
    }
}

pageextension 50668 "Item Cate. Page" extends "Item Categories"
{
    layout
    {
        addafter(Description)
        {
            field("Margin %"; "Margin %")
            {
                ApplicationArea = All;
            }
        }
    }
}

