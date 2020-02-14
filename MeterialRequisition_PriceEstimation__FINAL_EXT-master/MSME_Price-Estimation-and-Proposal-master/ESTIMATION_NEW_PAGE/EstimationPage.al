page 50015 "Estimation Sheet"
{
    PageType = ListPart;
    AutoSplitKey = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Estimation Line Tbl";
    DelayedInsert = true;
    //MultipleNewLines = true;



    layout
    {

        area(Content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    //Visible = true;
                    Editable = false;

                }
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;

                }

                field("Version No. Disp"; "Version No. Disp")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;

                }
                field("Version No."; "Version No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Drawing Number"; "Drawing Number")
                {
                    ApplicationArea = All;
                    Editable = true;

                }
                field("Row Type"; "Row Type")
                {
                    ApplicationArea = All;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        CheckReleaseStatusValidation();
                    end;
                    // Stop 02-07-2019

                }
                field("Item Type"; "Item Type")
                {
                    ApplicationArea = All;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        CheckReleaseStatusValidation();

                    end;
                    // Stop 02-07-2019

                }
                field("Item Code"; "Item Code")
                {
                    ApplicationArea = All;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        CheckReleaseStatusValidation();
                        if ("Item Code" = '') then begin
                            Clear(Description);
                            Clear("Description 2");
                            Clear("Unit Price");
                            Clear("Unit Of Measure");
                        end;
                    end;
                    // Stop 02-07-2019

                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        CheckReleaseStatusValidation();
                    end;
                    // Stop 02-07-2019

                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        CheckReleaseStatusValidation();
                    end;
                    // Stop 02-07-2019

                }
                field("Length Type"; "Length Type")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Unit Of Measure"; "Unit Of Measure")
                {
                    ApplicationArea = all;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        CheckReleaseStatusValidation();
                    end;
                    // Stop 02-07-2019
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        CheckReleaseStatusValidation();
                    end;
                    // Stop 02-07-2019

                }
                // Start 02-07-2019
                field("Estimated Qty."; "Estimated Qty.")
                {
                    ApplicationArea = All;
                    ////Editable = false;
                }
                field("Total Qty."; "Total Qty.")
                {
                    ApplicationArea = All;
                    ///Editable = false;
                }
                // Stop 02-07-2019
                field("Company Item Code"; "Company Item Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Company Item Description"; "Company Item Description")
                {
                    ApplicationArea = All;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        CheckReleaseStatusValidation();
                    end;
                    // Stop 02-07-2019

                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CheckReleaseStatusValidation();
                        if "Row Type" = "Row Type"::Total then
                            Error('You cannot update unit price with Row Type Total');
                        // Srart 15-09-2019
                        // Remove from table and keeped here.
                        if "Unit Price" <> xRec."Unit Price" then
                            "Price updated" := true;
                    end;

                }
                field("Total Price"; "Total Price")
                {
                    ApplicationArea = All;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        CheckReleaseStatusValidation();
                    end;
                    // Stop 02-07-2019

                }
                field("Job Task"; "Job Task")
                {
                    ApplicationArea = All;
                    // Start 02-07-2019
                    trigger
                    OnValidate()
                    begin
                        // CheckReleaseStatusValidation();
                    end;
                    // Stop 02-07-2019
                }
                field("Price updated"; "Price updated")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import BOQ")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    EstimationHeaderRecL: Record "Estimation Header";
                begin
                    // Start 02-07-2019
                    EstimationHeaderRecL.Reset();
                    EstimationHeaderRecL.SetRange("Quote No.", "Quote No.");
                    if EstimationHeaderRecL.FindFirst() then begin
                        BOQImport.SetValue("Quote No.", "Version No.");
                        BOQImport.Run();
                        EstimationProcess.Run();
                        Message('Import Successfully');
                    end;
                    // Stop 02-07-2019
                end;
            }

            /*
            action("BOQ Details")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Message("Quote No.");
                    BOQPage.Run();

                end;
            }
            action("Create SQ Lines")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    EstimHdrRec: Record "Estimation Header";
                    //Text001: Text 'Record should be released for creating sale squote lines';
                begin

                    //Message("Quote No.");
                    EstimHdrRec.Reset();
                    EstimHdrRec.SetRange("Quote No.", Rec."Quote No.");
                    If EstimHdrRec.FindFirst() then begin
                        if EstimHdrRec.Status = EstimHdrRec.Status::Released then
                            EstimationProcess.SalesQuoteLineCreate(Rec."Quote No.", rec."Version No. Disp")
                        else
                            Error('Record should be released for creating sale squote lines');
                    End;

                end;
            }
            */
        }
    }
    // Start 04-09-2019
    trigger
    OnNewRecord(BelowxRec: Boolean)
    var
        EstimationLineRec_1: Record "Estimation Line Tbl";
    begin
        // // EstimationLineRec_1.Reset();
        // // EstimationLineRec_1.SetCurrentKey("Quote No.", "Line No.", "Drawing Number", "Version No. Disp");
        // // EstimationLineRec_1.SetRange("Quote No.", Rec."Quote No.");
        // // EstimationLineRec_1.SetRange("Version No.", Rec."Version No.");
        // // EstimationLineRec_1.SetRange("Drawing Number", Rec."Drawing Number");
        // // if EstimationLineRec_1.FindLast then begin
        // //     Rec."Drawing Number" := EstimationLineRec_1."Drawing Number";
        // //     Rec."Estimated Qty." := EstimationLineRec_1."Estimated Qty.";
        // //     Rec."Total Qty." := EstimationLineRec_1."Total Qty.";
        // //     CurrPage.Update();
        // // end;
    end;

    trigger
    OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        EstimationLineRec_1: Record "Estimation Line Tbl";
        EstimationLineRec_2: Record "Estimation Line Tbl";
        EstimationHeaderRecL: Record "Estimation Header";
    begin
        if Rec.Count > 0 then begin
            EstimationLineRec_1.Reset();
            EstimationLineRec_1.SetCurrentKey("Quote No.", "Line No.", "Drawing Number", "Version No. Disp");
            EstimationLineRec_1.SetRange("Quote No.", xRec."Quote No.");
            EstimationLineRec_1.SetRange("Version No.", xRec."Version No.");
            EstimationLineRec_1.SetRange("Line No.", xRec."Line No.");
            if EstimationLineRec_1.FindLast then begin
                if (Rec."Drawing Number" = '') then begin
                    Rec."Version No." := EstimationLineRec_1."Version No.";
                    Rec."Version No. Disp" := EstimationLineRec_1."Version No. Disp";
                    Rec."Drawing Number" := EstimationLineRec_1."Drawing Number";
                    Rec."Estimated Qty." := EstimationLineRec_1."Estimated Qty.";
                    Rec."Total Qty." := EstimationLineRec_1."Total Qty.";
                    CurrPage.Update(false);
                end;
            end;

        end
        else begin
            EstimationHeaderRecL.Reset();
            EstimationHeaderRecL.SetRange("Quote No.", "Quote No.");
            if EstimationHeaderRecL.FindFirst() then begin
                // "Version No. Disp" := EstimationHeaderRecL."Version No. Disp";
                "Version No." := EstimationHeaderRecL."Version No.";
                CurrPage.Update(false);
            end;
        end;

    end;
    // Stop 04-09-2019

    var
        BOQImport: XmlPort "BOQ-Import";
        BOQPage: Page "BOQ List";
        EstimationProcess: Codeunit Process;

    trigger OnModifyRecord(): Boolean
    var
        EstimHdrRec: Record "Estimation Header";
    begin
        // Start 02-07-2019
        // Comments Code
        /*
        EstimHdrRec.Reset();
        EstimHdrRec.SetRange("Quote No.", Rec."Quote No.");
        if EstimHdrRec.FindFirst() then begin
            if EstimHdrRec.Status = EstimHdrRec.Status::Released then
                Error('You cannot modify');
        end;
        */
        // Stop 02-07-2019
    End;


    // Start 02-07-2019
    procedure CheckReleaseStatusValidation()
    var
        EstimHdrRec: Record "Estimation Header";
    begin
        EstimHdrRec.Reset();
        EstimHdrRec.SetRange("Quote No.", Rec."Quote No.");
        if EstimHdrRec.FindFirst() then begin
            if EstimHdrRec.Status = EstimHdrRec.Status::Released then
                Error('You cannot modify');
        end;
    End;
    // Stop 02-07-2019
}