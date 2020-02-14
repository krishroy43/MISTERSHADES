pageextension 50025 "Ext. Sales Order List" extends "Sales order List"
{
    //Caption = 'Dispatch notes';
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addbefore("Request Approval")
        {
            action("Completly Shipped")
            {
                ApplicationArea = All;
                Image = ListPage;
                RunObject = page "Sales Order List CompShipped";
            }
            action("POP-msg")
            {
                ApplicationArea = All;
                Image = Post;
                trigger
                OnAction()
                begin
                    Message('%1', "Document Type");
                    Codeunit.Run(50005, Rec);
                end;
            }
        }

        modify(Post)
        {
            Visible = false;
        }


        modify(PostAndSend)
        {
            Visible = false;
        }
        modify("Post &Batch")
        {
            Visible = false;
        }
        modify("Preview Posting")
        {
            Visible = false;
        }

    }

    var
        myInt: Integer;

    trigger
    OnOpenPage()
    begin
        FILTERGROUP(2);
        ///SETRANGE("Completely Shipped", false);
        SetRange("Dispatch Note", false);
        FILTERGROUP(0);

    end;


}

