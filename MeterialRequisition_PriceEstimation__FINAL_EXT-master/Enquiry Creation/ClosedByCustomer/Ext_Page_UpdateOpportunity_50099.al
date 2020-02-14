pageextension 50099 "Ext Update Opportunity" extends "Update Opportunity"
{
    layout
    {
        addafter("Sales Cycle Stage")
        {
            field("Sales Cycle Stage Description"; "Sales Cycle Stage Description")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Assign to"; "Assign to")
            {
                ApplicationArea = All;

            }
            field("Assign to Name"; "Assign to Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    trigger
    OnOpenPage()
    var
        SalesCycleStageRecL: Record "Sales Cycle Stage";
    begin
        SalesCycleStageRecL.Reset();
        if SalesCycleStageRecL.Get("Sales Cycle Code", "Sales Cycle Stage") then begin
            "Sales Cycle Stage Description" := SalesCycleStageRecL.Description;
            Modify();
        end;

    end;

    trigger
   OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // IF (CurrPage.RUNMODAL = ACTION::OK) THEN BEGIN
        //     Validate("Updated By", UserId);
        //     Modify();
        // end;
    end;
}

