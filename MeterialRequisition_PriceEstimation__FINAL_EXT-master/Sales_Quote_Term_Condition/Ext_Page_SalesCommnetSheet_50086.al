pageextension 50086 "Ext Sales Comment Sheet" extends "Sales Comment Sheet"
{
    Caption = 'Terms & Condition';
    layout
    {
        //addafter(Comment)
        addbefore(Date)
        {
            field("Term/Condition"; "Term/Condition")
            {
                ApplicationArea = All;
            }
        }
        modify(Comment)
        {
            Caption = 'Description';
        }
        addafter(Comment)
        {
            field(Description; Description)
            {
                ApplicationArea = All;
                Caption = 'Description 2';
            }
        }
    }
    actions
    {
        addfirst(Navigation)
        {
            action("Upload Standard Term & Condition")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                Caption = 'Upload Standard Term';
                trigger
                OnAction()
                var
                    StdTermConditionDescRecL: Record "Std Term & Condition Descp";
                    SalesCommnetLineRecL: Record "Sales Comment Line";
                    SalesCommnetLineRec2L: Record "Sales Comment Line";
                    SalesQuoteRecL: Record "Sales Header";
                    NewLineNoL: Integer;
                begin
                    SalesQuoteRecL.Reset();
                    if SalesQuoteRecL.Get("Document Type", "No.") then begin
                        if (SalesQuoteRecL.Status = SalesQuoteRecL.Status::Released) then
                            Error('Sales Quote Status Should be Open');
                    end;



                    SalesCommnetLineRec2L.Reset();
                    if SalesCommnetLineRec2L.FindLast() then
                        if SalesCommnetLineRec2L."Line No." > 0 then
                            NewLineNoL := SalesCommnetLineRec2L."Line No." + 10000
                        else
                            NewLineNoL := 10000;

                    // Message('inside loop 1');
                    StdTermConditionDescRecL.Reset();
                    StdTermConditionDescRecL.SetRange("Document Type", StdTermConditionDescRecL."Document Type"::"Sales Quote");
                    if StdTermConditionDescRecL.FindSet() then begin
                        // Message('inside loop 2');
                        repeat
                            SalesCommnetLineRecL.Validate("Document Type", "Document Type");
                            SalesCommnetLineRecL.Validate("No.", "No.");
                            SalesCommnetLineRecL.Validate("Line No.", NewLineNoL);
                            SalesCommnetLineRecL.Date := SalesQuoteRecL."Document Date"; //Today();
                            SalesCommnetLineRecL.Validate("Term/Condition", StdTermConditionDescRecL."Term/Condition");
                            SalesCommnetLineRecL.Validate(Comment, StdTermConditionDescRecL.Description);
                            SalesCommnetLineRecL.Insert();
                            NewLineNoL += 10000;
                        until StdTermConditionDescRecL.Next() = 0;
                    end;
                end;

            }
        }
    }
}

