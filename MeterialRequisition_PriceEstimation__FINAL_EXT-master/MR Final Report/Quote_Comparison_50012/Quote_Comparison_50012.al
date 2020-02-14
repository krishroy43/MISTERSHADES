report 50012 "Quote Comparison Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'MeterialRequisition_PriceEstimation__FINAL_EXT-master\MR Final Report\Quote_Comparison_50012\Quote_Comparison_50012.rdl';//'QuoteComparison.rdl';

    dataset
    {
        dataitem("Material Requisition Header"; "Material Requisition Header")
        {
            RequestFilterFields = "Requisition No.";
            column(Requisition_No_; "Requisition No.") { }
            column(Req__Creation_Date; "Req. Creation Date") { }
            column(CompanyNAme; CompanyInfoRecG.Name) { }
            column(UserId_; UserId) { }
            column(Total; Total)
            {
            }
            column(Today_; Today) { }
            dataitem("Purchase Header"; "Purchase Header")
            {
                RequestFilterFields = "No.";
                DataItemTableView = WHERE("Document Type" = CONST(Quote));
                DataItemLink = "Requisition No." = field("Requisition No.");
                column(VendorName; VendorName[1]) { }
                column(ShipmentTerms; ShipmentTerms[1]) { }
                column(PaymentTerms; PaymentTerms[1]) { }
                column(OrderDate; OrderDate[1]) { }
                column(ReqNo1; ReqNo[1]) { }
                column(Amount1; HeeaderAmount[1])//"Amount Including VAT")
                {
                }

                column(TermConditionTextG1; TermConditionTextG[1]) { }
                column(VendorName2; VendorName[2]) { }
                column(ShipmentTerms2; ShipmentTerms[2]) { }
                column(PaymentTerms2; PaymentTerms[2]) { }
                column(OrderDate2; OrderDate[2]) { }
                column(ReqNo2; ReqNo[2]) { }
                column(TermConditionTextG2; TermConditionTextG[2]) { }
                column(Amount2; HeeaderAmount[2])//"Amount Including VAT")
                {
                }

                column(VendorName3; VendorName[3]) { }
                column(ShipmentTerms3; ShipmentTerms[3]) { }
                column(PaymentTerms3; PaymentTerms[3]) { }
                column(OrderDate3; OrderDate[3]) { }
                column(ReqNo3; ReqNo[3]) { }
                column(Amount3; HeeaderAmount[3])//"Amount Including VAT")
                {
                }

                column(TermConditionTextG3; TermConditionTextG[3]) { }
                column(VendorName4; VendorName[4]) { }
                column(ShipmentTerms4; ShipmentTerms[4]) { }
                column(PaymentTerms4; PaymentTerms[4]) { }
                column(OrderDate4; OrderDate[4]) { }
                column(ReqNo4; ReqNo[4]) { }
                column(TermConditionTextG4; TermConditionTextG[4]) { }
                column(Amount4; HeeaderAmount[4])//"Amount Including VAT")
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemTableView = WHere("Document Type" = Const(Quote));
                    DataItemLink = "Document No." = field("No.");

                    column(Document_No_; "Document No.") { }
                    column(No_; "No.") { }
                    column(Description; Description) { }
                    column(Qty; Qty[1]) { }
                    column(Price; Price[1]) { }
                    column(Qty2; Qty[2]) { }

                    column(Price2; Price[2]) { }
                    column(Qty3; Qty[3]) { }
                    column(Price3; Price[3]) { }
                    column(Qty4; Qty[4]) { }
                    column(Price4; Price[4]) { }

                    trigger OnPreDataItem()
                    var
                        myInt: Integer;
                    begin
                        //I := 1;
                    end;

                    trigger OnAfterGetRecord()
                    var
                    begin
                        Clear(Qty);
                        Clear(Price);
                        if DocNo <> "Purchase Line"."Document No." then begin
                            I += 1;
                            // Message('%1', DocNo);
                        end;
                        Total += "Purchase Line".Quantity * "Purchase Line"."Unit Cost";

                        Qty[I] := "Purchase Line".Quantity;

                        Price[I] := "Purchase Line"."Unit Cost";
                        DocNo := "Purchase Line"."Document No.";
                    end;
                }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                end;

                trigger OnAfterGetRecord()
                var
                    ShipMethodRecL: Record "Shipment Method";
                    PaymentRecL: Record "Payment Terms";
                    PurchCommentLineRecL: Record "Purch. Comment Line";
                    Pheader: Record "Purchase Header";
                begin
                    if DocNo1 <> "Purchase Header"."No." then begin
                        J += 1;
                        VendorName[J] := "Purchase Header"."Buy-from Vendor Name";
                        ReqNo[J] := "Purchase Header"."No.";

                        PaymentRecL.Reset();
                        if PaymentRecL.Get("Purchase Header"."Payment Terms Code") then
                            PaymentTerms[J] := PaymentRecL.Description;

                        ShipMethodRecL.Reset();
                        if ShipMethodRecL.Get("Purchase Header"."Shipment Method Code") then
                            ShipmentTerms[J] := ShipMethodRecL.Description;
                        OrderDate[J] := "Purchase Header"."Order Date";
                        Docno1 := "Purchase Header"."No.";
                        // Start 26-07-2019
                        PurchCommentLineRecL.Reset();
                        PurchCommentLineRecL.SetCurrentKey("Term/Condition", "No.");
                        PurchCommentLineRecL.SetRange("No.", "Purchase Header"."No.");
                        if PurchCommentLineRecL.FindSet() then begin
                            repeat
                                TermConditionTextG[J] += (PurchCommentLineRecL.Comment + ', _');
                            until PurchCommentLineRecL.Next() = 0;
                        end;
                        // Stop 26-07-2019
                    end;
                end;

                trigger
                OnPostDataItem()
                begin
                    // Message('1-   %1', TermConditionTextG[1]);
                    // Message('2-   %1', TermConditionTextG[2]);
                    // Message('3-   %1', TermConditionTextG[3]);
                    // Message('4-   %1', TermConditionTextG[4]);
                end;
            }
            trigger
            OnPreDataItem()
            begin
                CompanyInfoRecG.Get();
            end;

            trigger OnAfterGetRecord()
            var
                Pheader: Record "Purchase Header";
            begin
                Pheader.Reset();
                Pheader.SetRange("Document Type", Pheader."Document Type"::Quote);
                Pheader.SetRange("Requisition No.", "Material Requisition Header"."Requisition No.");
                if Pheader.FindSet() then begin
                    repeat
                        K += 1;
                        Pheader.CalcFields(Amount);
                        HeeaderAmount[K] := Pheader.Amount;
                    until Pheader.Next() = 0;
                end;


            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

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
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        I := 0;
        J := 0;
        K := 0;
        Clear(DocNo);
        Clear(DocNo1);
    end;

    var
        I: Integer;
        J: Integer;
        DocNo1: Code[30];
        DocNo: Code[20];
        K: Integer;
        Qty: array[15] of Decimal;
        Price: array[15] of Decimal;
        VendorName: array[15] of Text;
        PaymentTerms: array[15] of Text;
        ShipmentTerms: array[15] of Text;
        OrderDate: array[15] of Date;
        ReqNo: array[15] of Code[20];
        CompanyInfoRecG: Record "Company Information";
        TermConditionTextG: array[550] of Text;
        Total: Decimal;
        HeeaderAmount: array[15] of Decimal;

}