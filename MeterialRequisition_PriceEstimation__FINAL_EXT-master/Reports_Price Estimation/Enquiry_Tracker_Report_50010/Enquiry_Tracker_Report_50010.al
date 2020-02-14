report 50010 "Enquiry Tracker"
{
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'Enquiry Tracker';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "Document Date", "Posting Date", "Opportunity No.";
            DataItemTableView = sorting("No.") order(ascending)
             where("Document Type" = CONST(Quote));
            column(No_; "No.") { }
            column(Document_Date; Format("Document Date")) { }
            column(Name; Customer_Rec.Name) { }
            column(Contact; Customer_Rec.Contact) { }
            column(EMail; Customer_Rec."E-Mail") { }
            column(PhoneNo; Customer_Rec."Phone No.") { }
            column(SrNo; SrNo) { }
            column(AmountF; AmountF) { }
            column(Job_No; JobNo) { }
            column(Description; Job_Rec.Description) { }
            column(Scope1; Job_Rec."Scope Of Work 1") { }
            column(Scope2; Job_Rec."Scope Of Work 2") { }
            column(Opportunity_No_; "Opportunity No.") { }

            trigger OnPreDataItem();
            begin
                SrNo := 0;
                IF No <> '' THEN BEGIN
                    // IF SelectionFilterManagement.GetSelectionFilterForSalesHeader(SalesHeaderRec2G) <> '' THEN
                    // "Sales Header".SETFILTER("No.", SelectionFilterManagement.GetSelectionFilterForSalesHeader(SalesHeaderRec2G));
                    //"Sales Header".SetFilter("No.", '%1', No);
                    "Sales Header".SETFILTER("No.", STRSUBSTNO('%1', No));
                    //ELSE
                    //CurrReport.SKIP;                    
                END;

            end;

            trigger OnAfterGetRecord();
            begin
                SrNo += 1;

                Clear(AmountF);

                Customer_Rec.Reset;
                if Customer_Rec.Get("Sell-to Customer No.") then;

                SalesLine_Rec.Reset;
                SalesLine_Rec.SetRange("Document No.", "Sales Header"."No.");
                if SalesLine_Rec.FindSet then
                    repeat
                        AmountF += SalesLine_Rec.Amount;
                    until SalesLine_Rec.Next = 0;

                Clear(JobNo);
                Clear(ScopeOfWork);
                Clear(ScopeOfWork1);

                Job_Rec.Reset();
                Job_Rec.SetRange("Sales Quote", "Sales Header"."No.");
                if Job_Rec.FindFirst() then begin
                    JobNo := Job_Rec."No.";
                    ScopeOfWork := "Scope Of Work 1";
                    ScopeOfWork1 := "Scope Of Work 2";
                end;




            end;

        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(No; No)
                    {
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            SalesHeaderRecL: Record "Sales Header";
                        begin

                            CLEAR(SalesList);
                            SalesHeaderRecL.Reset();
                            SalesHeaderRecL.SetRange("Document Type", "Sales Header"."Document Type"::Quote);
                            SalesList.SetTableView(SalesHeaderRecL);
                            SalesList.LOOKUPMODE(TRUE);
                            IF NOT (SalesList.RUNMODAL = ACTION::LookupOK) THEN
                                EXIT(FALSE);
                            IF SalesList.GetSelectionFilter <> '' THEN
                                Text := SalesList.GetSelectionFilter
                            ELSE
                                No := Text;

                            EXIT(TRUE);


                        end;
                    }

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        myInt: Integer;
        Customer_Rec: Record Customer;
        SalesLine_Rec: Record "Sales Line";
        AmountF: Decimal;
        SrNo: Integer;
        Job_Rec: Record Job;

        JobNo: Code[20];
        ScopeOfWork: Text[250];
        ScopeOfWork1: Text[250];
        No: Text[250];
        SalesList: Page "Sales List";
        SalesHeaderRec2G: Record "Sales Header";
        SelectionFilterManagement: Codeunit SelectionFilterManagement_1;


}