page 50007 "Material Requisition List Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Material Requisition Header";
    //Caption = 'Material Requisition';
    Caption = 'Requisition Order';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Material Requisition";



    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field("Requisition No."; "Requisition No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;

                }
                field("Req. Creation Date"; "Req. Creation Date")
                {
                    ApplicationArea = All;
                    Caption = 'Requsition Creation Date';
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }
                field("Date of Requisition"; "Date of Requisition")
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }
                field("Job task No."; "Job task No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }
                field("Expected receipt date"; "Expected receipt date")
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }
                field("Supplier name"; "Supplier name")
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }
                field("Origin of Item"; "Origin of Item")
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }
                field("Project Code"; "Project Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StypeExprBool;
                    Style = Unfavorable;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Xmlport")
            {
                ApplicationArea = All;
                Image = XMLFile;
                RunObject = xmlport "Import/Export Xmlport";
                trigger OnAction()
                begin

                end;
            }
            action("Open Dummy Page")
            {
                Image = ListPage;
                ApplicationArea = All;
                RunObject = page "XML Dummy Page";
            }
        }
    }

    trigger
    OnOpenPage()
    var
    begin
        StypeExprBool := false;
    end;

    trigger
    OnAfterGetRecord()
    begin
        AlertReqNotConvertEnqry("Requisition No.");
    end;

    var
        StypeExprBool: Boolean;

    procedure AlertReqNotConvertEnqry(ReqNo: Code[50])
    var

        MateriarReqLineL: Record "Material Requisition Line";
        PurchaseEnquiryHeaderRec: Record "Purch. Enquiry Header";
    begin
        //MateriarReqLineL.Reset();
        //MateriarReqLineL.SetRange("Document No.", ReqNo);
        //MateriarReqLineL.SetRange("Req. To Enqry", false);
        // if MateriarReqLineL.FindSet() OR ("Req. Creation Date" < Today) then begin
        PurchaseEnquiryHeaderRec.Reset();
        PurchaseEnquiryHeaderRec.SetRange("Requisition No.", ReqNo);
        if (NOT PurchaseEnquiryHeaderRec.FindFirst()) AND ("Req. Creation Date" < Today) then
            StypeExprBool := true
        else
            StypeExprBool := false;

    end;


}