pageextension 50004 "Ext. Opportunity List" extends "Opportunity List"
{
    Caption = 'Sales Enquiry';


    layout
    {
        addafter("No.")
        {
            field("Days of Conversion in Proposal"; "Date of Conversion in Proposal")
            {
                ApplicationArea = All;
                StyleExpr = StyleExprBoolG;
                Style = Unfavorable;
                Caption = 'Proposal conversion Date';


            }
            field("Enquiry Registered by"; "Enquiry Registered by")
            {
                ApplicationArea = All;
                StyleExpr = StyleExprBoolG;
                Style = Unfavorable;
            }

            field("Customer Name"; "Customer Name")
            {
                ApplicationArea = All;
                StyleExpr = StyleExprBoolG;
                Style = Unfavorable;
            }
        }
        addbefore("Contact No.")
        {
            field("Customer No."; "Customer No.")
            {
                ApplicationArea = All;
                StyleExpr = StyleExprBoolG;
                Style = Unfavorable;
            }
        }
        modify("No.")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify(Closed)
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }

        modify("Creation Date")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify(Description)
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Contact No.")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Contact Company No.")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify(Status)
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Sales Cycle Code")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify(CurrSalesCycleStage)
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Campaign No.")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Campaign Description")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Sales Document Type")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Sales Document No.")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Estimated Closing Date")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }

        modify("Estimated Value (LCY)")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }
        modify("Calcd. Current Value (LCY)")
        {
            ApplicationArea = All;
            StyleExpr = StyleExprBoolG;
            Style = Unfavorable;
        }


    }


    trigger
    OnAfterGetRecord()
    begin
        UpdateDayConversionProposalStyle("No.");
    end;

    trigger
    OnOpenPage()
    begin
        CurrPage.Caption('Sales Enquiry');
    end;

    var
        StyleExprBoolG: Boolean;
        StyleVarG: Integer;

    procedure UpdateDayConversionProposalStyle(OpprNo: Code[30])
    var
        OpportunityRecL: Record Opportunity;
        SalesHeaderRecL: Record "Sales Header";

    begin
        OpportunityRecL.Reset();
        if OpportunityRecL.Get(OpprNo) then begin
            SalesHeaderRecL.Reset();
            SalesHeaderRecL.SetCurrentKey("No.", "Opportunity No.");
            SalesHeaderRecL.SetRange("Document Type", SalesHeaderRecL."Document Type"::Quote);
            SalesHeaderRecL.SetRange("Opportunity No.", "No.");
            SalesHeaderRecL.SetFilter(Status, '<>%1', SalesHeaderRecL.Status::Released);
            if SalesHeaderRecL.FindFirst() OR ((OpportunityRecL."Date of Conversion in Proposal" < Today())) then
                StyleExprBoolG := true
            // if (OpportunityRecL."Date of Conversion in Proposal" <= Today()) AND (NOT ((Status = Status::Lost) OR (Status = Status::Won))) AND ("Date of Conversion in Proposal" <> 0D) then
            else
                StyleExprBoolG := false;
        end;
    end;


}

