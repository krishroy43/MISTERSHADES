page 50033 "Payment Milestone List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payment Milestone";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            // group(Groupname)
            //{
            repeater("Payment Milestone")
            {
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                    // Visible = false;
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    Editable = false;
                    // Visible = false;
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    //  Visible = false;
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Type"; "Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Milestone %"; "Milestone %")
                {
                    ApplicationArea = All;
                    trigger
                    OnValidate()
                    begin
                        if "Document Type" = "Document Type"::"Credit Memo" then begin
                            //UpdateValueForSalesCreditMemo("Document No.");
                        end;

                    end;
                }
                field("Currency Factor"; "Currency Factor")
                {
                    ApplicationArea = all;
                }
                field("Milestone Description"; "Milestone Description")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms"; "Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("Total Value"; "Total Value")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    Editable = false;
                    ApplicationArea = all;

                }
                field("Total Value(LCY)"; "Total Value(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
            }
            //}
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Value")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    paymentMileStoneRecL: Record "Payment Milestone";
                    JobPlanningLineL: Record "Job Planning Line";
                begin
                    // Start 29-09-2019
                    UpdateValueForSalesCreditMemo("Document No.");
                    // Stop 29-09-2019
                    IF NOT ("Document Type" = "Document Type"::Job) THEN BEGIN
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", Rec."Document Type");
                        SalesHeader.SetRange("No.", Rec."Document No.");
                        IF SalesHeader.FindFirst THEN BEGIN
                            SalesHeader.CalcFields(Amount);
                            ModifyAll("Total Value", SalesHeader.Amount);
                            if SalesHeader."Currency Code" = '' then begin
                                paymentMileStoneRecL.Reset();
                                paymentMileStoneRecL.SetRange("Document No.", "Document No.");
                                if paymentMileStoneRecL.FindSet() then begin
                                    repeat
                                        paymentMileStoneRecL."Currency Factor" := SalesHeader."Currency Factor";
                                        paymentMileStoneRecL.Validate(Amount, ((SalesHeader.Amount * paymentMileStoneRecL."Milestone %") / 100));
                                        paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value");
                                        paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL."Amount");
                                        paymentMileStoneRecL.Modify();
                                    until paymentMileStoneRecL.Next() = 0;
                                end;
                            end else begin
                                paymentMileStoneRecL.Reset();
                                paymentMileStoneRecL.SetRange("Document No.", "Document No.");
                                if paymentMileStoneRecL.FindSet() then begin
                                    repeat
                                        paymentMileStoneRecL."Currency Factor" := SalesHeader."Currency Factor";

                                        //paymentMileStoneRecL.Validate("Total Value", SalesHeader.Amount);
                                        paymentMileStoneRecL.Validate(Amount, ((SalesHeader.Amount * paymentMileStoneRecL."Milestone %") / 100));

                                        paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value" / Round(SalesHeader."Currency Factor", 0.0001, '='));
                                        paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL."Amount" / Round(SalesHeader."Currency Factor", 0.0001, '='));
                                        paymentMileStoneRecL.Modify();
                                    // Message('TM %1     AMT  %2  CF %3', paymentMileStoneRecL."Total Value", paymentMileStoneRecL."Amount", SalesHeader."Currency Factor");
                                    until paymentMileStoneRecL.Next() = 0;
                                    //Message('Not blank');
                                end;
                            end;
                        END;
                    END
                    ELSE BEGIN
                        Job.Reset();
                        Job.SetRange("No.", Rec."Document No.");
                        IF Job.FindFirst() THEN BEGIN
                            "Document Date" := Job."Starting Date";
                            Job.CalcFields("Project Amount (Planned)");
                            ModifyAll("Total Value", Job."Project Amount (Planned)");
                            // Message('2');
                            JobPlanningLineL.Reset();
                            JobPlanningLineL.SetRange("Job No.", Job."No.");
                            if JobPlanningLineL.FindFirst() then;
                            if Job."Currency Code" = '' then begin
                                paymentMileStoneRecL.Reset();
                                paymentMileStoneRecL.SetRange("Document No.", "Document No.");
                                if paymentMileStoneRecL.FindSet() then begin
                                    repeat
                                        paymentMileStoneRecL."Currency Factor" := JobPlanningLineL."Currency Factor";
                                        paymentMileStoneRecL.Validate(Amount, ((Job."Project Amount (Planned)" * paymentMileStoneRecL."Milestone %") / 100));
                                        paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value");
                                        paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL."Amount");
                                        paymentMileStoneRecL.Modify();
                                    until paymentMileStoneRecL.Next() = 0;
                                end;
                            end else begin
                                paymentMileStoneRecL.Reset();
                                paymentMileStoneRecL.SetRange("Document No.", "Document No.");
                                if paymentMileStoneRecL.FindSet() then begin
                                    repeat
                                        paymentMileStoneRecL."Currency Factor" := JobPlanningLineL."Currency Factor";
                                        paymentMileStoneRecL.Validate(Amount, ((Job."Project Amount (Planned)" * paymentMileStoneRecL."Milestone %") / 100));
                                        paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL.Amount / JobPlanningLineL."Currency Factor");
                                        paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value" / JobPlanningLineL."Currency Factor");
                                        paymentMileStoneRecL.Modify();
                                    until paymentMileStoneRecL.Next() = 0;
                                end;
                            end;
                        END;
                    END;
                    // Start 
                    //Amount := Round(("Total Value" * "Milestone %") / 100, 0.01, '=');
                    // Stop
                    IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                        PaymentTerms.Get("Payment Terms");
                        "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
                    END;
                    // Start
                    paymentMileStoneRecL.Reset();
                    paymentMileStoneRecL.SetRange("Document No.", "Document No.");
                    paymentMileStoneRecL.SetRange("Document Type", "Document Type");
                    if paymentMileStoneRecL.FindSet() then
                        repeat
                            paymentMileStoneRecL.Amount := ((paymentMileStoneRecL."Total Value" * paymentMileStoneRecL."Milestone %") / 100);
                            paymentMileStoneRecL.Modify();
                        until paymentMileStoneRecL.Next() = 0;
                    // Stop
                end;
            }
        }
    }

    var

        SalesHeader: Record "Sales Header";
        PaymentTerms: Record "Payment Terms";
        Job: Record Job;
        CurrFactGbl: Decimal;

    trigger

    OnQueryClosePage(CloseAction: Action): Boolean
    var
        paymentMileStoneRecL: Record "Payment Milestone";
        PerDecL: Decimal;
    begin
        // Start
        Clear(PerDecL);
        paymentMileStoneRecL.Reset();
        paymentMileStoneRecL.SetRange("Document No.", "Document No.");
        paymentMileStoneRecL.SetRange("Document Type", "Document Type");
        if paymentMileStoneRecL.FindSet() then
            repeat
                //paymentMileStoneRecL.Amount := Round((paymentMileStoneRecL."Total Value" * paymentMileStoneRecL."Milestone %") / 100, 0.01, '=');
                //paymentMileStoneRecL.Modify();
                PerDecL += paymentMileStoneRecL."Milestone %";
            until paymentMileStoneRecL.Next() = 0;

        if PerDecL <> 0 then
            if PerDecL <> 100 then
                error('Milestone percentage should be equal to 100%');

        // Stop

        if "Document Type" = "Document Type"::"Credit Memo" then begin
            UpdateValueForSalesCreditMemo("Document No.");
        end;



    end;

    trigger OnOpenPage()
    begin
        "Currency Factor" := CurrFactGbl;
        UpdateValueForSalesCreditMemo("Document No.");

    End;

    procedure SetValues(Currfact: Decimal)
    var
        myInt: Integer;
    begin
        CurrFactGbl := Currfact;
    end;

    procedure UpdateValueForSalesCreditMemo(DocNo: Code[20])
    var
        paymentMileStoneRecL: Record "Payment Milestone";
        JobPlanningLineL: Record "Job Planning Line";
    begin
        IF NOT ("Document Type" = "Document Type"::Job) THEN BEGIN
            SalesHeader.Reset();
            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Credit Memo");
            SalesHeader.SetRange("No.", DocNo);
            IF SalesHeader.FindFirst THEN BEGIN
                //SalesHeader.CalcFields(Amount);
                ModifyAll("Total Value", SalesLineSumOfVATBaseAmount(SalesHeader."No."));
                if SalesHeader."Currency Code" = '' then begin
                    paymentMileStoneRecL.Reset();
                    paymentMileStoneRecL.SetRange("Document No.", "Document No.");
                    if paymentMileStoneRecL.FindSet() then begin
                        repeat
                            paymentMileStoneRecL."Currency Factor" := SalesHeader."Currency Factor";
                            paymentMileStoneRecL.Validate(Amount, ((SalesLineSumOfVATBaseAmount(SalesHeader."No.") * paymentMileStoneRecL."Milestone %") / 100));
                            paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value");
                            paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL."Amount");
                            paymentMileStoneRecL.Modify();
                        until paymentMileStoneRecL.Next() = 0;
                    end;
                end else begin
                    paymentMileStoneRecL.Reset();
                    paymentMileStoneRecL.SetRange("Document No.", "Document No.");
                    if paymentMileStoneRecL.FindSet() then begin
                        repeat
                            paymentMileStoneRecL."Currency Factor" := SalesHeader."Currency Factor";
                            paymentMileStoneRecL.Validate(Amount, ((SalesLineSumOfVATBaseAmount(SalesHeader."No.") * paymentMileStoneRecL."Milestone %") / 100));
                            paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL.Amount / SalesHeader."Currency Factor");
                            paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value" / SalesHeader."Currency Factor");
                            paymentMileStoneRecL.Modify();
                        until paymentMileStoneRecL.Next() = 0;
                    end;
                end;
            end;
        end;
    end;
}




// // page 50033 "Payment Milestone List"
// // {
// //     PageType = List;
// //     ApplicationArea = All;
// //     UsageCategory = Administration;
// //     SourceTable = "Payment Milestone";
// //     AutoSplitKey = true;
// //     DelayedInsert = true;

// //     layout
// //     {
// //         area(Content)
// //         {
// //             // group(Groupname)
// //             //{
// //             repeater("Payment Milestone")
// //             {
// //                 field("Document Type"; "Document Type")
// //                 {
// //                     Editable = false;
// //                     // Visible = false;
// //                     ApplicationArea = All;
// //                 }
// //                 field("Line No."; "Line No.")
// //                 {
// //                     Editable = false;
// //                     // Visible = false;
// //                     ApplicationArea = All;
// //                 }
// //                 field("Document No."; "Document No.")
// //                 {
// //                     Editable = false;
// //                     //  Visible = false;
// //                     ApplicationArea = All;
// //                 }
// //                 field("Document Date"; "Document Date")
// //                 {
// //                     Editable = false;
// //                     ApplicationArea = All;
// //                 }
// //                 field("Posting Type"; "Posting Type")
// //                 {
// //                     ApplicationArea = All;
// //                 }
// //                 field("Milestone %"; "Milestone %")
// //                 {
// //                     ApplicationArea = All;
// //                 }
// //                 field("Currency Factor"; "Currency Factor")
// //                 { }
// //                 field("Milestone Description"; "Milestone Description")
// //                 {
// //                     ApplicationArea = All;
// //                 }
// //                 field("Payment Terms"; "Payment Terms")
// //                 {
// //                     ApplicationArea = All;
// //                 }
// //                 field("Total Value"; "Total Value")
// //                 {
// //                     ApplicationArea = All;
// //                 }
// //                 field(Amount; Amount)
// //                 {
// //                     Editable = false;
// //                     ApplicationArea = All;
// //                 }
// //                 field("Amount(LCY)"; "Amount(LCY)")
// //                 {
// //                     Editable = false;
// //                     ApplicationArea = all;

// //                 }
// //                 field("Total Value(LCY)"; "Total Value(LCY)")
// //                 {
// //                     ApplicationArea = All;
// //                 }
// //                 field("Due Date"; "Due Date")
// //                 {
// //                     ApplicationArea = All;
// //                 }
// //             }
// //             //}
// //         }
// //     }

// //     actions
// //     {
// //         area(Processing)
// //         {
// //             action("Update Value")
// //             {
// //                 ApplicationArea = All;

// //                 trigger OnAction()
// //                 var
// //                     paymentMileStoneRecL: Record "Payment Milestone";
// //                     JobPlanningLineL: Record "Job Planning Line";
// //                 begin
// //                     IF NOT ("Document Type" = "Document Type"::Job) THEN BEGIN
// //                         SalesHeader.Reset();
// //                         SalesHeader.SetRange("Document Type", Rec."Document Type");
// //                         SalesHeader.SetRange("No.", Rec."Document No.");
// //                         IF SalesHeader.FindFirst THEN BEGIN
// //                             // "Document Date" := SalesHeader."Document Date";
// //                             // "Currency Factor" := SalesHeader."Currency Factor";
// //                             SalesHeader.CalcFields(Amount);
// //                             // // Start
// //                             ModifyAll("Total Value", SalesHeader.Amount);
// //                             // Stop
// //                             if SalesHeader."Currency Code" = '' then begin
// //                                 paymentMileStoneRecL.Reset();
// //                                 paymentMileStoneRecL.SetRange("Document No.", "Document No.");
// //                                 if paymentMileStoneRecL.FindSet() then begin
// //                                     repeat
// //                                         paymentMileStoneRecL."Currency Factor" := SalesHeader."Currency Factor";
// //                                         //paymentMileStoneRecL.Validate("Total Value", SalesHeader.Amount);
// //                                         paymentMileStoneRecL.Validate(Amount, ((SalesHeader.Amount * paymentMileStoneRecL."Milestone %") / 100));
// //                                         paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value");
// //                                         paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL."Amount");
// //                                         paymentMileStoneRecL.Modify();
// //                                     until paymentMileStoneRecL.Next() = 0;
// //                                     //Message('blank');
// //                                 end;
// //                             end else begin
// //                                 paymentMileStoneRecL.Reset();
// //                                 paymentMileStoneRecL.SetRange("Document No.", "Document No.");
// //                                 if paymentMileStoneRecL.FindSet() then begin
// //                                     repeat
// //                                         paymentMileStoneRecL."Currency Factor" := SalesHeader."Currency Factor";

// //                                         //paymentMileStoneRecL.Validate("Total Value", SalesHeader.Amount);
// //                                         paymentMileStoneRecL.Validate(Amount, ((SalesHeader.Amount * paymentMileStoneRecL."Milestone %") / 100));

// //                                         paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value" / Round(SalesHeader."Currency Factor", 0.0001, '='));
// //                                         paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL."Amount" / Round(SalesHeader."Currency Factor", 0.0001, '='));
// //                                         paymentMileStoneRecL.Modify();
// //                                         // Message('TM %1     AMT  %2  CF %3', paymentMileStoneRecL."Total Value", paymentMileStoneRecL."Amount", SalesHeader."Currency Factor");
// //                                     until paymentMileStoneRecL.Next() = 0;
// //                                     //Message('Not blank');
// //                                 end;
// //                             end;
// //                         END;
// //                     END
// //                     ELSE BEGIN
// //                         Job.Reset();
// //                         Job.SetRange("No.", Rec."Document No.");
// //                         IF Job.FindFirst() THEN BEGIN
// //                             "Document Date" := Job."Starting Date";
// //                             Job.CalcFields("Project Amount (Planned)");
// //                             ModifyAll("Total Value", Job."Project Amount (Planned)");
// //                             // Message('2');
// //                             JobPlanningLineL.Reset();
// //                             JobPlanningLineL.SetRange("Job No.", Job."No.");
// //                             if JobPlanningLineL.FindFirst() then;
// //                             if Job."Currency Code" = '' then begin
// //                                 paymentMileStoneRecL.Reset();
// //                                 paymentMileStoneRecL.SetRange("Document No.", "Document No.");
// //                                 if paymentMileStoneRecL.FindSet() then begin
// //                                     repeat
// //                                         paymentMileStoneRecL."Currency Factor" := JobPlanningLineL."Currency Factor";
// //                                         paymentMileStoneRecL.Validate(Amount, ((Job."Project Amount (Planned)" * paymentMileStoneRecL."Milestone %") / 100));
// //                                         paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value");
// //                                         paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL."Amount");
// //                                         paymentMileStoneRecL.Modify();
// //                                     until paymentMileStoneRecL.Next() = 0;
// //                                 end;
// //                             end else begin
// //                                 paymentMileStoneRecL.Reset();
// //                                 paymentMileStoneRecL.SetRange("Document No.", "Document No.");
// //                                 if paymentMileStoneRecL.FindSet() then begin
// //                                     repeat
// //                                         paymentMileStoneRecL."Currency Factor" := JobPlanningLineL."Currency Factor";
// //                                         paymentMileStoneRecL.Validate(Amount, ((Job."Project Amount (Planned)" * paymentMileStoneRecL."Milestone %") / 100));
// //                                         paymentMileStoneRecL.Validate("Amount(LCY)", paymentMileStoneRecL.Amount / JobPlanningLineL."Currency Factor");
// //                                         paymentMileStoneRecL.Validate("Total Value(LCY)", paymentMileStoneRecL."Total Value" / JobPlanningLineL."Currency Factor");
// //                                         paymentMileStoneRecL.Modify();
// //                                     until paymentMileStoneRecL.Next() = 0;
// //                                 end;
// //                             end;
// //                         END;
// //                     END;
// //                     // Start 
// //                     //Amount := Round(("Total Value" * "Milestone %") / 100, 0.01, '=');
// //                     // Stop
// //                     IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
// //                         PaymentTerms.Get("Payment Terms");
// //                         "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
// //                     END;
// //                     // Start
// //                     paymentMileStoneRecL.Reset();
// //                     paymentMileStoneRecL.SetRange("Document No.", "Document No.");
// //                     paymentMileStoneRecL.SetRange("Document Type", "Document Type");
// //                     if paymentMileStoneRecL.FindSet() then
// //                         repeat
// //                             paymentMileStoneRecL.Amount := ((paymentMileStoneRecL."Total Value" * paymentMileStoneRecL."Milestone %") / 100);
// //                             paymentMileStoneRecL.Modify();
// //                         until paymentMileStoneRecL.Next() = 0;
// //                     // Stop
// //                 end;
// //             }
// //         }
// //     }

// //     var

// //         SalesHeader: Record "Sales Header";
// //         PaymentTerms: Record "Payment Terms";
// //         Job: Record Job;
// //         CurrFactGbl: Decimal;

// //     trigger

// //     OnQueryClosePage(CloseAction: Action): Boolean
// //     var
// //         paymentMileStoneRecL: Record "Payment Milestone";
// //         PerDecL: Decimal;
// //     begin
// //         // Start
// //         Clear(PerDecL);
// //         paymentMileStoneRecL.Reset();
// //         paymentMileStoneRecL.SetRange("Document No.", "Document No.");
// //         paymentMileStoneRecL.SetRange("Document Type", "Document Type");
// //         if paymentMileStoneRecL.FindSet() then
// //             repeat
// //                 //paymentMileStoneRecL.Amount := Round((paymentMileStoneRecL."Total Value" * paymentMileStoneRecL."Milestone %") / 100, 0.01, '=');
// //                 //paymentMileStoneRecL.Modify();
// //                 PerDecL += paymentMileStoneRecL."Milestone %";
// //             until paymentMileStoneRecL.Next() = 0;

// //         if PerDecL <> 0 then
// //             if PerDecL <> 100 then
// //                 error('Milestone percentage should be equal to 100%');

// //         // Stop

// //     end;

// //     trigger OnOpenPage()
// //     begin
// //         "Currency Factor" := CurrFactGbl;

// //     End;

// //     procedure SetValues(Currfact: Decimal)
// //     var
// //         myInt: Integer;
// //     begin
// //         CurrFactGbl := Currfact;
// //     end;
// // }

