page 50012 "Material Requisition Approvals"

{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Approval Entry";
    Editable = false;
    //SourceTableView = SORTING ("Record ID", "Last Date-Time Modified") ORDER(Ascending);




    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(IsOverdue; IsOverdue)
                {
                    ApplicationArea = All;
                }
                field("Limit Type"; "Limit Type")
                {
                    ApplicationArea = All;
                }
                field("Approval Type"; "Approval Type")
                {
                    ApplicationArea = All;
                }

                field("Initiated By User ID"; "Sender ID")
                {
                    ApplicationArea = All;
                    //CaptionML = "Initiated By";
                }


                field("Sequence No."; "Sequence No.")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; "Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                }
                field("To Be Approved By User ID"; "Approver ID")
                {
                    ApplicationArea = All;
                    //CaptionML = "Approver ID";
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Initiated"; "Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                    //CaptionML = "Sent for approval date and time";
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}