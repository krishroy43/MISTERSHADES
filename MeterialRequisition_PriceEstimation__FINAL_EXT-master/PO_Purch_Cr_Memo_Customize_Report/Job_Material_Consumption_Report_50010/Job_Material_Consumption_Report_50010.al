report 50011 "Job Material Consumption"
{
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'Job Material Consumption';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Job Planning Line"; "Job Planning Line")
        {
            DataItemTableView = sorting ("No.") order(ascending)
                               where ("Type" = CONST (Item));
            RequestFilterFields = "Job No.";
            column(JobRec_No; Job_rec."No.") { }
            column(JobRec_Description; Job_rec.Description) { }
            column(JobRec_Status; Job_rec.Status) { }
            column(No_; "No.") { }
            column(Description; Description) { }
            //column(Quantity_Acual; Quantity) { }
            column(Quantity_Acual; ActualQtyDec1G) { }
            column(UOMRecG_Description; UOMDesc) { }

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field ("No."),
                    //"Job Task No." = field ("Job Task No."),
                    "Job No." = field ("Job No."),
                    "Unit of Measure Code" = field ("Unit of Measure Code");

                DataItemTableView = sorting ("Item No.");
                RequestFilterFields = "Posting Date";

                column(PurchaseIssueDecG; PurchaseIssueDecG) { }
                column(ReturnQuantity2; ReturnQuantity2) { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }

                trigger
                OnAfterGetRecord()
                begin
                    Clear(PurchaseIssueDecG);
                    Clear(ReturnQuantity2);
                    Clear(ActualQtyDecG);


                    ItemLedEntry_Rec.Reset;
                    ItemLedEntry_Rec.SetCurrentKey("Entry No.");
                    ItemLedEntry_Rec.SetRange("Job No.", "Job No.");
                    // ItemLedEntry_Rec.SetRange("Job Task No.", "Job Planning Line"."Job Task No.");
                    //ItemLedEntry_Rec.SetRange("Item No.", "Job Planning Line"."No.");
                    ItemLedEntry_Rec.SetRange("Item No.", "Item No.");
                    ItemLedEntry_Rec.SetRange("Unit of Measure Code", "Unit of Measure Code");

                    ItemLedEntry_Rec.SetFilter(ItemLedEntry_Rec."Entry Type", '%1|%2|%3',
                                                ItemLedEntry_Rec."Entry Type"::"Positive Adjmt.",
                                                ItemLedEntry_Rec."Entry Type"::Output,
                                                ItemLedEntry_Rec."Entry Type"::Purchase);

                    ItemLedEntry_Rec.SetFilter(ItemLedEntry_Rec."Document Type", '%1|%2|%3|%4|%5|%6|%7',
                                            ItemLedEntry_Rec."Document Type"::" ",
                                            ItemLedEntry_Rec."Document Type"::"Purchase Receipt",
                                            ItemLedEntry_Rec."Document Type"::"Purchase Invoice",
                                            ItemLedEntry_Rec."Document Type"::"Transfer Receipt",
                                            ItemLedEntry_Rec."Document Type"::"Posted Assembly",
                                            ItemLedEntry_Rec."Document Type"::"Sales Return Receipt",
                                            ItemLedEntry_Rec."Document Type"::"Sales Credit Memo");
                    if ItemLedEntry_Rec.FindSet then
                        repeat
                            PurchaseIssueDecG += ItemLedEntry_Rec.Quantity;
                        until ItemLedEntry_Rec.Next = 0;

                    //////////-========================-
                    // if (PreItemCode <> "Job Planning Line"."No.") AND (PreUOM <> "Job Planning Line"."Unit of Measure Code") then begin
                    // if ("Item No." <> "Job Planning Line"."No.") AND ("Unit of Measure Code" <> "Job Planning Line"."Unit of Measure Code") then begin
                    //Message('sec');
                    ItemLedEntry_Rec.Reset;
                    ItemLedEntry_Rec.SetCurrentKey("Entry No.");
                    ItemLedEntry_Rec.SetRange("Job No.", "Job No.");
                    // ItemLedEntry_Rec.SetRange("Job Task No.", "Job Planning Line"."Job Task No.");
                    ItemLedEntry_Rec.SetRange("Item No.", "Item No.");
                    ItemLedEntry_Rec.SetRange("Unit of Measure Code", "Unit of Measure Code");
                    ItemLedEntry_Rec.SetFilter(ItemLedEntry_Rec."Entry Type", '%1',
                                                ItemLedEntry_Rec."Entry Type"::"Negative Adjmt.");
                    ItemLedEntry_Rec.SetFilter(ItemLedEntry_Rec."Document Type", '%1|%2|%3|%4|%5',
                                            ItemLedEntry_Rec."Document Type"::"Purchase Return Shipment",
                                            ItemLedEntry_Rec."Document Type"::"Purchase Credit Memo",
                                            ItemLedEntry_Rec."Document Type"::"Transfer Shipment",
                                            ItemLedEntry_Rec."Document Type"::"Purchase Receipt",
                                            ItemLedEntry_Rec."Document Type"::" ");
                    if ItemLedEntry_Rec.FindSet then
                        repeat
                            ReturnQuantity2 += ItemLedEntry_Rec.Quantity;
                        until ItemLedEntry_Rec.Next = 0;
                    //  PreItemCode := "Job Planning Line"."No.";
                    //PreUOM := "Job Planning Line"."Unit of Measure Code";
                    //   end;
                    //PreItemCode := "Job Planning Line"."No.";
                    // PreUOM := "Job Planning Line"."Unit of Measure Code";




                end;
            }

            trigger OnAfterGetRecord();
            begin
                Clear(UOMDesc);
                Clear(ActualQtyDec1G);

                Job_rec.Reset();
                Job_rec.SetRange("No.", "Job Planning Line"."Job No.");
                if Job_rec.FindFirst() then;


                UOMRecG.Reset();
                if UOMRecG.Get("Job Planning Line"."Unit of Measure Code") then
                    UOMDesc := UOMRecG.Description;

                CounterG += 1;

                //Message('%5 outside   %1 =====  %2 <-----> %3   === %4', ItemCodeG, UOMCodeG, "Job Planning Line"."No.", "Job Planning Line"."Unit of Measure Code", CounterG);

                if ((ItemCodeG <> "Job Planning Line"."No.") AND (UOMCodeG <> "Job Planning Line"."Unit of Measure Code")) then begin                    // Message('JPL It %1  Qty %2', "No.", Quantity);
                    CheckBoolG := true;
                    ItemCodeG := "Job Planning Line"."No.";
                    UOMCodeG := "Job Planning Line"."Unit of Measure Code";

                    // Message('inside  %1 ===== %2', ItemCodeG, UOMCodeG);
                end else
                    if ((ItemCodeG <> "Job Planning Line"."No.") OR (UOMCodeG <> "Job Planning Line"."Unit of Measure Code")) then begin
                        CheckBoolG := true;
                        ItemCodeG := "Job Planning Line"."No.";
                        UOMCodeG := "Job Planning Line"."Unit of Measure Code";
                    end else
                        CheckBoolG := true;

                if CheckBoolG then begin

                    JobPlanningLineRecG.Reset();
                    JobPlanningLineRecG.SetRange("No.", "Job Planning Line"."No.");
                    JobPlanningLineRecG.SetRange("Job No.", "Job Planning Line"."Job No.");
                    JobPlanningLineRecG.SetRange("Unit of Measure Code", "Job Planning Line"."Unit of Measure Code");
                    if JobPlanningLineRecG.FindSet() then
                        repeat
                            ActualQtyDec1G += JobPlanningLineRecG.Quantity;
                        until JobPlanningLineRecG.Next() = 0;

                    //Clear(ItemCodeG);
                    //Clear(UOMCodeG);
                end;

            end;
        }

    }



    var
        myInt: Integer;

        ItemLedEntry_Rec: Record "Item Ledger Entry";
        PurchaseIssueDecG: Decimal;
        ReturnQuantity2: Decimal;
        Usage1: Text[50];
        Usage2: Text[50];
        Usage3: Text[50];
        Job_rec: Record Job;
        PreItemCode: Code[20];
        PreUOM: Code[20];
        UOMRecG: Record "Unit of Measure";
        UOMDesc: Code[80];
        ActualQtyDecG: Decimal;
        JobPlanningLineRecG: Record "Job Planning Line";
        ItemCodeG: Code[20];
        UOMCodeG: Code[20];
        ActualQtyDec1G: Decimal;
        CounterG: Integer;
        CheckBoolG: Boolean;


}