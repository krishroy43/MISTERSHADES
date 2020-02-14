table 50015 "Payment Milestone"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            //OptionMembers = Quote,Order,Invoice,Job,"Posted Invoice";
            // Start 28-09-2019
            OptionMembers = Quote,Order,Invoice,Job,"Posted Invoice","Credit Memo","Posted Credit Memo";
            // Stop 28-09-2019
        }
        field(2; "Document No."; Code[20])
        {

        }
        field(3; "Line No."; Integer)
        {
            // AutoIncrement = true;
        }
        field(4; "Document Date"; Date)
        {

        }
        field(5; "Posting Type"; Option)
        {
            OptionMembers = Advance,Running,Retention;
        }
        field(6; "Milestone %"; Decimal)
        {
            trigger OnValidate()
            var

            begin
                Clear(CurrFact);
                // Amount := Round(("Total Value" * "Milestone %") / 100, 0.01, '=');
                // "Amount(LCY)" := Round(("Total Value" * "Milestone %") / 100, 0.01, '=');
                // CalcCreditMemoLineValue("Document No.");
            end;
        }
        field(7; "Milestone Description"; Text[100])
        {

        }
        field(8; "Payment Terms"; Code[20])
        {
            TableRelation = "Payment Terms";
            trigger OnValidate()
            begin
                IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                    PaymentTerms.Get("Payment Terms");
                    "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
                END;
            end;
        }

        field(9; "Total Value"; Decimal)
        {

        }
        field(10; Amount; Decimal)
        {
            Editable = false;
        }
        field(11; "Due Date"; Date) { }
        field(12; "Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(13; "Currency Factor"; Decimal)
        {
            DecimalPlaces = 1 : 4;

        }
        field(14; "Total Value(LCY)"; Decimal)
        {

        }

    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(PostingType; "Document Type", "Document No.", "Posting Type")
        {
            SumIndexFields = Amount, "Amount(LCY)";
        }
    }

    var
        SalesHeader: Record "Sales Header";
        PaymentTerms: Record "Payment Terms";
        Job: Record Job;
        CurrFact: Decimal;
        SalesHeaderRec: Record "Sales Header";
        AmountLcy: Decimal;

    trigger OnInsert()
    var
        JobPlanningLineRecL: Record "Job Planning Line";
    begin
        IF NOT ("Document Type" = "Document Type"::Job) THEN BEGIN
            // Message('Not job');
            SalesHeader.Reset();
            SalesHeader.SetRange("Document Type", Rec."Document Type");
            SalesHeader.SetRange("No.", Rec."Document No.");
            IF SalesHeader.FindFirst THEN BEGIN
                "Document Date" := SalesHeader."Document Date";
                SalesHeader.CalcFields(Amount);
                "Total Value" := SalesHeader.Amount;
                "Currency Factor" := Round(SalesHeader."Currency Factor", 0.0001, '=');
                // Start Date : 25-06-2019
                if SalesHeader."Currency Factor" <> 0 then
                    "Total Value(LCY)" := SalesHeader.Amount / Round(SalesHeader."Currency Factor", 0.0001, '=')
                else
                    "Total Value(LCY)" := SalesHeader.Amount;// / Round(SalesHeader."Currency Factor", 0.01, '=')
                // Stop Date : 25-06-2019
            END;
        END
        ELSE BEGIN
            //Message(' job');
            Job.Reset();
            Job.SetRange("No.", Rec."Document No.");
            IF Job.FindFirst() THEN BEGIN
                //"Document Date" := Job."Starting Date";
                "Document Date" := Job."Creation Date";
                Job.CalcFields("Project Amount (Planned)");
                "Total Value" := Job."Project Amount (Planned)";

                JobPlanningLineRecL.Reset();
                JobPlanningLineRecL.SetRange("Job No.", Rec."Document No.");
                if JobPlanningLineRecL.FindFirst() then begin
                    if JobPlanningLineRecL."Currency Factor" <> 0 then
                        "Total Value(LCY)" := Job."Project Amount (Planned)" / Round(JobPlanningLineRecL."Currency Factor", 0.0001, '=')
                    else
                        "Total Value(LCY)" := Job."Project Amount (Planned)";

                    "Currency Factor" := Round(JobPlanningLineRecL."Currency Factor", 0.0001, '=');
                end;
            END;
        END;

        Amount := Round(("Total Value" * "Milestone %") / 100, 0.0001, '=');
        "Amount(LCY)" := Round(("Total Value(LCY)" * "Milestone %") / 100, 0.0001, '=');

        IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
            PaymentTerms.Get("Payment Terms");
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
        END;

        CalcCreditMemoLineValue("Document No.");

    end;





    trigger OnModify()
    begin
        Amount := Round(("Total Value" * "Milestone %") / 100, 0.0001, '=');
        "Amount(LCY)" := Round(("Total Value(LCY)" * "Milestone %") / 100, 0.0001, '=');
        IF (("Payment Terms" <> '') AND ("Document Date" <> 0D)) OR ("Payment Terms" <> xRec."Payment Terms") THEN BEGIN
            PaymentTerms.Get("Payment Terms");
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
        END;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


    procedure CalcCreditMemoLineValue(DocNo: Code[20])
    var
        Amnt: Decimal;
    begin
        Clear(Amnt);
        //Message('here');
        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
            //Message('doc %1', DocNo);
            SalesHeader.Reset();
            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Credit Memo");
            SalesHeader.SetRange("No.", DocNo);
            IF SalesHeader.FindFirst THEN BEGIN
                // Message('inside doc %1', DocNo);
                "Document Date" := SalesHeader."Document Date";
                //SalesHeader.CalcFields(Amount);
                Amnt := SalesLineSumOfVATBaseAmount(SalesHeader."No.");
                "Total Value" := SalesLineSumOfVATBaseAmount(SalesHeader."No.");
                "Currency Factor" := Round(SalesHeader."Currency Factor", 0.0001, '=');
                if SalesHeader."Currency Factor" <> 0 then
                    "Total Value(LCY)" := Amnt / Round(SalesHeader."Currency Factor", 0.0001, '=')
                else
                    "Total Value(LCY)" := Amnt;
                // Message('on insert %1 ', Amnt);
            END;
        END;

        IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
            PaymentTerms.Get("Payment Terms");
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
        END;
        Amount := Round(("Total Value" * "Milestone %") / 100, 0.0001, '=');
        // Message('Amount doc %1', Amount);
        "Amount(LCY)" := Round(("Total Value(LCY)" * "Milestone %") / 100, 0.0001, '=');
        // Message(' "Amount(LCY)" doc %1', "Amount(LCY)");
    end;

    procedure SalesLineSumOfVATBaseAmount(DocNo: Code[20]): Decimal
    var
        SalesLineRecL: Record "Sales Line";
        SalesAmountSum: Decimal;
    begin
        // Message('insidr line fun %1', DocNo);
        Clear(SalesAmountSum);
        SalesLineRecL.Reset();
        SalesLineRecL.SetRange("Document No.", DocNo);
        SalesLineRecL.SetRange("Document Type", SalesLineRecL."Document Type"::"Credit Memo");
        SalesLineRecL.SetFilter(Type, '<>%1', SalesLineRecL.Type::" ");
        SalesLineRecL.SetFilter("No.", '<>%1', '');
        if SalesLineRecL.FindSet() then begin
            repeat
                //Message('inside funcation %1', SalesLineRecL."VAT Base Amount");
                SalesAmountSum += SalesLineRecL."VAT Base Amount";
            until SalesLineRecL.Next() = 0;
        end;
        exit(SalesAmountSum);
    end;
}



// // table 50015 "Payment Milestone"
// // {

// //     fields
// //     {
// //         field(1; "Document Type"; Option)
// //         {
// //             OptionMembers = Quote,Order,Invoice,Job,"Posted Invoice";
// //         }
// //         field(2; "Document No."; Code[20])
// //         {

// //         }
// //         field(3; "Line No."; Integer)
// //         {
// //             // AutoIncrement = true;
// //         }
// //         field(4; "Document Date"; Date)
// //         {

// //         }
// //         field(5; "Posting Type"; Option)
// //         {
// //             OptionMembers = Advance,Running,Retention;
// //         }
// //         field(6; "Milestone %"; Decimal)
// //         {
// //             trigger OnValidate()
// //             var

// //             begin
// //                 Clear(CurrFact);
// //                 Amount := Round(("Total Value" * "Milestone %") / 100, 0.01, '=');
// //                 "Amount(LCY)" := Round(("Total Value" * "Milestone %") / 100, 0.01, '=');
// //             end;
// //         }
// //         field(7; "Milestone Description"; Text[100])
// //         {

// //         }
// //         field(8; "Payment Terms"; Code[20])
// //         {
// //             TableRelation = "Payment Terms";
// //             trigger OnValidate()
// //             begin
// //                 IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
// //                     PaymentTerms.Get("Payment Terms");
// //                     "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
// //                 END;
// //             end;
// //         }

// //         field(9; "Total Value"; Decimal)
// //         {

// //         }
// //         field(10; Amount; Decimal)
// //         {
// //             Editable = false;
// //         }
// //         field(11; "Due Date"; Date) { }
// //         field(12; "Amount(LCY)"; Decimal)
// //         {
// //             Editable = false;
// //         }
// //         field(13; "Currency Factor"; Decimal)
// //         {
// //             DecimalPlaces = 1 : 4;

// //         }
// //         field(14; "Total Value(LCY)"; Decimal)
// //         {

// //         }

// //     }

// //     keys
// //     {
// //         key(PK; "Document Type", "Document No.", "Line No.")
// //         {
// //             Clustered = true;
// //         }
// //         key(PostingType; "Document Type", "Document No.", "Posting Type")
// //         {
// //             SumIndexFields = Amount, "Amount(LCY)";
// //         }
// //     }

// //     var
// //         SalesHeader: Record "Sales Header";
// //         PaymentTerms: Record "Payment Terms";
// //         Job: Record Job;
// //         CurrFact: Decimal;
// //         SalesHeaderRec: Record "Sales Header";
// //         AmountLcy: Decimal;

// //     trigger OnInsert()
// //     var
// //         JobPlanningLineRecL: Record "Job Planning Line";
// //     begin
// //         IF NOT ("Document Type" = "Document Type"::Job) THEN BEGIN
// //             // Message('Not job');
// //             SalesHeader.Reset();
// //             SalesHeader.SetRange("Document Type", Rec."Document Type");
// //             SalesHeader.SetRange("No.", Rec."Document No.");
// //             IF SalesHeader.FindFirst THEN BEGIN
// //                 "Document Date" := SalesHeader."Document Date";
// //                 SalesHeader.CalcFields(Amount);
// //                 "Total Value" := SalesHeader.Amount;
// //                 "Currency Factor" := Round(SalesHeader."Currency Factor", 0.0001, '=');
// //                 // Start Date : 25-06-2019
// //                 if SalesHeader."Currency Factor" <> 0 then
// //                     "Total Value(LCY)" := SalesHeader.Amount / Round(SalesHeader."Currency Factor", 0.0001, '=')
// //                 else
// //                     "Total Value(LCY)" := SalesHeader.Amount;// / Round(SalesHeader."Currency Factor", 0.01, '=')
// //                 // Stop Date : 25-06-2019
// //             END;
// //         END
// //         ELSE BEGIN
// //             //Message(' job');
// //             Job.Reset();
// //             Job.SetRange("No.", Rec."Document No.");
// //             IF Job.FindFirst() THEN BEGIN
// //                 //"Document Date" := Job."Starting Date";
// //                 "Document Date" := Job."Creation Date";
// //                 Job.CalcFields("Project Amount (Planned)");
// //                 "Total Value" := Job."Project Amount (Planned)";

// //                 JobPlanningLineRecL.Reset();
// //                 JobPlanningLineRecL.SetRange("Job No.", Rec."Document No.");
// //                 if JobPlanningLineRecL.FindFirst() then begin
// //                     if JobPlanningLineRecL."Currency Factor" <> 0 then
// //                         "Total Value(LCY)" := Job."Project Amount (Planned)" / Round(JobPlanningLineRecL."Currency Factor", 0.0001, '=')
// //                     else
// //                         "Total Value(LCY)" := Job."Project Amount (Planned)";

// //                     "Currency Factor" := Round(JobPlanningLineRecL."Currency Factor", 0.0001, '=');
// //                 end;
// //             END;


// //         END;
// //         Amount := Round(("Total Value" * "Milestone %") / 100, 0.0001, '=');
// //         "Amount(LCY)" := Round(("Total Value(LCY)" * "Milestone %") / 100, 0.0001, '=');

// //         IF ("Payment Terms" <> '') AND ("Document Date" <> 0D) THEN BEGIN
// //             PaymentTerms.Get("Payment Terms");
// //             "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
// //         END;
// //     end;

// //     trigger OnModify()
// //     begin
// //         Amount := Round(("Total Value" * "Milestone %") / 100, 0.0001, '=');
// //         "Amount(LCY)" := Round(("Total Value(LCY)" * "Milestone %") / 100, 0.0001, '=');
// //         IF (("Payment Terms" <> '') AND ("Document Date" <> 0D)) OR ("Payment Terms" <> xRec."Payment Terms") THEN BEGIN
// //             PaymentTerms.Get("Payment Terms");
// //             "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
// //         END;
// //     end;

// //     trigger OnDelete()
// //     begin

// //     end;

// //     trigger OnRename()
// //     begin

// //     end;

// // }