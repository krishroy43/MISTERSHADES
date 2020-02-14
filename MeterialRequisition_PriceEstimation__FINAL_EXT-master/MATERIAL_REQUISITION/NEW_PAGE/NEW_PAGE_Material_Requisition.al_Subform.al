page 50006 "Material Requisition Subform"
{
    PageType = ListPart;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = "Material Requisition Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    LinksAllowed = false;
    //Caption = 'Material Req. Lines';
    Caption = 'Requisition Order Lines';


    layout
    {
        area(Content)
        {
            repeater("General")
            {

                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Enquiry Item"; "Enquiry Item")
                {
                    ApplicationArea = All;
                    // Editable = EditableFalseTrueAllControl;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;
                    trigger
                   OnValidate()
                    var
                    begin
                        if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                            Error('Job No. / Job Task No. Must be blank.');
                    end;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;
                    trigger
                   OnValidate()
                    var
                    begin
                        if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                            Error('Job No. / Job Task No. Must be blank.');
                    end;
                }
                // Start 28-06-2019
                field("Item Description"; "Item Description")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;
                }
                field("Item Description2"; "Item Description 2")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;
                }
                // Stop 28-06-2019
                field("Quantity needed"; "Quantity needed")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;
                }
                field("Qty. to Enquiry"; "Qty. to Enquiry")
                {
                    ApplicationArea = All;
                    // Editable = EditableFalseTrueAllControl;
                }
                field("Available Inventory"; "Available Inventory")
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;
                    trigger
                   OnValidate()
                    var
                    begin
                        if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                            Error('Job No. / Job Task No. Must be blank.');
                    end;
                }
                field(Location; Location)
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;
                    trigger
                    OnValidate()
                    var
                    begin
                        if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                            Error('Job No. / Job Task No. Must be blank.');
                    end;
                    //Editable = false;
                }
                field("Expected receipt date"; "Expected receipt date")
                {
                    ApplicationArea = All;
                    Editable = EditableFalseTrueAllControl;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job task No."; "Job task No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Planning Line No."; "Job Planning Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Req. To Quote"; "Req. To Enqry")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }

            }
        }
    }


    actions
    {

        area(Processing)
        {


            group("Function")
            {
                Image = MovementWorksheet;
                action("Get job planning line")
                {
                    ApplicationArea = All;
                    Image = Planning;
                    trigger OnAction()
                    var
                        RequisitionLineRecL: Record "Material Requisition Line";
                        ReqHeaderRecL: Record "Material Requisition Header";
                        JobPlanningLineRecL: Record "Job Planning Line";
                    begin

                        RequisitionLineRecL.Reset();
                        ReqHeaderRecL.Reset();
                        if ReqHeaderRecL.get("Document No.") then begin
                            ReqHeaderRecL.TestField("Enquiry Type");
                            RequisitionLineRecL.SetRange("Document No.", ReqHeaderRecL."Requisition No.");
                            RequisitionLineRecL.SetRange("Job No.", ReqHeaderRecL."Job No.");

                            if ReqHeaderRecL."Job task No." <> '' then
                                RequisitionLineRecL.SetRange("Job task No.", ReqHeaderRecL."Job task No.");

                            if RequisitionLineRecL.FindSet() then begin
                                //RequisitionLineRecL.DeleteAll();                               
                                OpenJobPlanningLine(ReqHeaderRecL."Job No.", ReqHeaderRecL."Job task No.");
                                //GetJobPlanningLine("Document No.");
                            end
                            else begin
                                OpenJobPlanningLine(ReqHeaderRecL."Job No.", ReqHeaderRecL."Job task No.");
                                //GetJobPlanningLine("Document No.");
                            end;
                            JobPlanningLineRecL.ModifyAll("Enquiry Item", false);
                        end;
                    end;

                }
                action("Create Enquiry")
                {
                    ApplicationArea = All;
                    Image = Create;
                    trigger
                    OnAction()
                    var
                        MaterialReqLineRecL: Record "Material Requisition Line";
                        MaterialReqHdrRec: Record "Material Requisition Header";
                        PurchaseEnquiryHeaderRecL: Record "Purch. Enquiry Header";
                    begin
                        MaterialReqHdrRec.Reset();

                        // // // // // // If MaterialReqHdrRec.Get(rec."Document No.") then begin
                        // // // // // //     If (MaterialReqHdrRec.Status = MaterialReqHdrRec.Status::Open) OR (MaterialReqHdrRec.Status = MaterialReqHdrRec.Status::"Pending Approval") then
                        // // // // // //       //------??  Error('Status Should be released for Create Enquiry');
                        // // // // // // end;

                        MaterialReqLineRecL.Reset();
                        MaterialReqLineRecL.SetRange("Document No.", "Document No.");
                        MaterialReqLineRecL.SetRange("Enquiry Item", true);
                        if MaterialReqLineRecL.Count = 0 then
                            Error('There is No Line for Enquiry.');
                        // Report 50015 File Path
                        // Location PURCHASE ENQUIRY -> PEQ_NEW_REPORT->NEW_REPORT_CreatingPurchEnquiry_Contact_50019
                        Report.RunModal(50019, true, false, MaterialReqLineRecL);

                    end;
                }

            }
        }
    }
    var
        myInt: Integer;
        EditableFalseTrueAllControl: Boolean;



    trigger
    OnOpenPage()
    begin
        // DisableHeaderLinePage;
    end;

    trigger
    OnModifyRecord(): Boolean
    begin
        DisableHeaderLinePage;
    end;

    trigger
    OnAfterGetRecord()
    begin
        DisableHeaderLinePage;

    end;

    trigger
    OnAfterGetCurrRecord()
    begin
        DisableHeaderLinePage;
    end;

    // Start GetJobPlanningLine Method
    local procedure GetJobPlanningLine(RequisitionNoP: Code[30])
    var
        JobPlanningLineRecL: Record "Job Planning Line";
        RequisitionHeaderRecL: Record "Material Requisition Header";
        RequisitionLineRecL: Record "Material Requisition Line";
        RequisitionLineRec2L: Record "Material Requisition Line";
        RequisitionLineRec3L: Record "Material Requisition Line";
        JobPlanningLineRec3L: Record "Job Planning Line";
        NewLineNoL: Integer;
    begin
        RequisitionHeaderRecL.Reset();
        if RequisitionHeaderRecL.get(RequisitionNoP) then begin

            If (RequisitionHeaderRecL.Status = RequisitionHeaderRecL.Status::"Pending Approval") OR
            (RequisitionHeaderRecL.Status = RequisitionHeaderRecL.Status::Released) then
                Error('Status Should be Open for Create Reqisition Line');

            RequisitionHeaderRecL.TestField("Job No.");
            // RequisitionHeaderRecL.TestField("Job task No.");
            // Changes Added as per excel 11.04.2019
            // RequisitionHeaderRecL.TestField("Enquiry Type");

            JobPlanningLineRecL.Reset();
            JobPlanningLineRecL.SetRange("Job No.", RequisitionHeaderRecL."Job No.");
            JobPlanningLineRecL.SetRange("Enquiry Item", true); //this is newly added as per req.
            // Start Filtr added 26.04.2019
            JobPlanningLineRecL.SetFilter("Line Type", '<>%1', JobPlanningLineRecL."Line Type"::Billable);
            // Stop Filtr added 26.04.2019
            if RequisitionHeaderRecL."Job task No." <> '' then begin
                JobPlanningLineRecL.SetRange("Job Task No.", RequisitionHeaderRecL."Job task No.");
            end;

            if JobPlanningLineRecL.FindSet() then begin
                repeat
                    /*
                    RequisitionLineRec3L.Reset();
                    RequisitionLineRec3L.SetRange("Document No.", RequisitionNoP);
                    RequisitionLineRec3L.SetRange("Job No.", JobPlanningLineRecL."Job No.");
                    RequisitionLineRec3L.SetRange("Job Planning Line No.", JobPlanningLineRecL."Line No.");
                    RequisitionLineRec3L.SetRange("No.", JobPlanningLineRecL."No.");
                    if RequisitionHeaderRecL."Job task No." <> '' then
                        RequisitionLineRec3L.SetRange("Job task No.", JobPlanningLineRecL."Job Task No.");
                    if not RequisitionLineRec3L.FindFirst() then begin
*/

                    RequisitionLineRecL.Init();
                    RequisitionLineRec2L.Reset();
                    RequisitionLineRec2L.SetRange("Document No.", RequisitionNoP);
                    RequisitionLineRec2L.SetRange("Job No.", JobPlanningLineRecL."Job No.");
                    RequisitionLineRec2L.SetRange("Job task No.", JobPlanningLineRecL."Job Task No.");
                    RequisitionLineRec2L.SetRange("Job Planning Line No.", JobPlanningLineRecL."Line No.");
                    RequisitionLineRec2L.SetRange("No.", JobPlanningLineRecL."No.");

                    /*
                     if RequisitionLineRec2L.FindLast() then begin
                         Message('true');
                         NewLineNoL := RequisitionLineRec2L."Line No." + 10000
                     end
                     else
                         NewLineNoL := 10000;
 */
                    if RequisitionLineRec3L.FindLast() then
                        NewLineNoL := RequisitionLineRec3L."Line No." + 10000
                    else
                        NewLineNoL := 10000;

                    RequisitionLineRecL.Validate("Document No.", RequisitionNoP);
                    RequisitionLineRecL.Validate("Line No.", NewLineNoL);


                    RequisitionLineRecL.Validate(Type, JobPlanningLineRecL.Type);
                    RequisitionLineRecL.Validate("No.", JobPlanningLineRecL."No.");
                    RequisitionLineRecL.Validate("Unit of Measure", JobPlanningLineRecL."Unit of Measure Code");
                    //RequisitionLineRecL.Validate(Location, JobPlanningLineRecL."Location Code");
                    RequisitionLineRecL.Validate(Location, RequisitionHeaderRecL."Location Code");
                    //RequisitionLineRecL.Validate("Expected receipt date", JobPlanningLineRecL."Planned Delivery Date");
                    RequisitionLineRecL.Validate("Expected receipt date", RequisitionHeaderRecL."Expected receipt date");

                    RequisitionLineRecL.Validate("Available Inventory", GetItemInvetoryByLocation(JobPlanningLineRecL."No.", JobPlanningLineRecL."Location Code"));

                    //RequisitionLineRecL.Validate("Quantity needed", JobPlanningLineRecL.Quantity);
                    JobPlanningLineRecL.CalcFields("Requisition Qty.");
                    RequisitionLineRecL.Validate("Quantity needed", (JobPlanningLineRecL.Quantity - JobPlanningLineRecL."Requisition Qty."));


                    // RequisitionLineRecL.Validate("Job Planning Line No.", JobPlanningLineRecL."Line No.");
                    // RequisitionLineRecL.Validate("Job No.", JobPlanningLineRecL."Job No.");
                    // RequisitionLineRecL.Validate("Job task No.", JobPlanningLineRecL."Job Task No.");


                    RequisitionLineRecL."Job Planning Line No." := JobPlanningLineRecL."Line No.";
                    RequisitionLineRecL."Job No." := JobPlanningLineRecL."Job No.";
                    RequisitionLineRecL."Job task No." := JobPlanningLineRecL."Job Task No.";
                    // Start 28-06-2019
                    RequisitionLineRecL."Item Description" := JobPlanningLineRecL.Description;
                    RequisitionLineRecL."Item Description 2" := JobPlanningLineRecL."Description 2";
                    // Stop 28-06-2019



                    if (JobPlanningLineRecL.Quantity - GetItemInvetoryByLocation(JobPlanningLineRecL."No.", JobPlanningLineRecL."Location Code")) > 0 then begin
                        RequisitionLineRecL.Validate("Qty. to Enquiry", (JobPlanningLineRecL.Quantity - GetItemInvetoryByLocation(JobPlanningLineRecL."No.", JobPlanningLineRecL."Location Code")));
                        RequisitionLineRecL.Validate("Enquiry Item", true)
                    end
                    else
                        RequisitionLineRecL.Validate("Qty. to Enquiry", 0);

                    //available inventory
                    if RequisitionLineRecL.Type = RequisitionLineRecL.Type::Item then
                        RequisitionLineRecL."Available Inventory" := GetItemInvetoryByLocation(RequisitionLineRecL."No.", RequisitionLineRecL.Location);
                    // //available inventory-end;

                    if NOT RequisitionLineRec2L.FindFirst() then begin
                        //Message('%1    %2    %3  ', JobPlanningLineRecL."Line No.", JobPlanningLineRecL."Job No.", JobPlanningLineRecL."Job Task No.");
                        if (JobPlanningLineRecL.Quantity - JobPlanningLineRecL."Requisition Qty.") <> 0 then
                            RequisitionLineRecL.Insert();

                    end;
                //if RequisitionLineRecL.Insert() then;
                //if RequisitionLineRecL.Insert() then;
                //RequisitionLineRecL.Modify();
                // end;
                until JobPlanningLineRecL.Next() = 0;

            end;
        end;
    end;
    // Stop GetJobPlanningLine Method  
    // Start GetItemInvetoryByLocation Method
    procedure GetItemInvetoryByLocation(ItemNoP: Code[50]; LocationCodeP: Code[50]): Decimal
    var
        ItemLedEntryRecL: Record "Item Ledger Entry";
        AvailableInvL: Decimal;
    begin
        Clear(AvailableInvL);
        ItemLedEntryRecL.Reset();
        ItemLedEntryRecL.SetCurrentKey("Item No.", "Location Code");
        ItemLedEntryRecL.SetRange("Item No.", ItemNoP);
        ItemLedEntryRecL.SetRange("Location Code", LocationCodeP);
        if ItemLedEntryRecL.FindSet() then
            repeat
                AvailableInvL += ItemLedEntryRecL."Remaining Quantity";
            until ItemLedEntryRecL.Next() = 0;

        exit(AvailableInvL);
    end;
    // Stop GetItemInvetoryByLocation Method

    // Start Opening Job Planning Line 
    procedure OpenJobPlanningLine(JobNo: Code[50]; JobTaskNo: Code[50])
    var
        //JobPlanningLinePAgeL: Page "Job Planning Line LT";
        JobPlanningLineRecL: Record "Job Planning Line";
        JobPlanningLineRec2L: Record "Job Planning Line";
        RequisitionLineRecL: Record "Material Requisition Line";
    begin
        JobPlanningLineRecL.Reset();
        JobPlanningLineRecL.SetRange("Job No.", JobNo);
        // Start Filtr added 26.04.2019
        JobPlanningLineRecL.SetFilter("Line Type", '<>%1', JobPlanningLineRecL."Line Type"::Billable);
        // Stop Filtr added 26.04.2019
        if JobTaskNo <> '' then
            JobPlanningLineRecL.SetRange("Job Task No.", JobTaskNo);
        if JobPlanningLineRecL.FindSet() then begin
            //JobPlanningLinePAgeL.SetTableView(JobPlanningLineRecL);
            Commit();
            if page.RunModal(50016, JobPlanningLineRecL) = Action::LookupOK then begin
                JobPlanningLineRec2L.Reset();
                JobPlanningLineRec2L.SetRange("Job No.", JobNo);
                JobPlanningLineRec2L.SetRange("Enquiry Item", true);
                if JobTaskNo <> '' then
                    JobPlanningLineRec2L.SetRange("Job Task No.", JobTaskNo);
                if JobPlanningLineRec2L.Count() <> 0 then begin
                    RequisitionLineRecL.Reset();
                    RequisitionLineRecL.SetRange("Document No.", "Document No.");
                    RequisitionLineRecL.SetRange("Job No.", JobNo);
                    if JobTaskNo <> '' then
                        RequisitionLineRecL.SetRange("Job task No.", JobTaskNo);
                    // if RequisitionLineRecL.FindSet() then
                    //  RequisitionLineRecL.DeleteAll();
                    GetJobPlanningLine("Document No.");
                end;
                //JobPlanningLineRecL.ModifyAll("Enquiry Item", false);
            end;
        end;
    end;
    // Stop Opening Job Planning Line 


    procedure DisableHeaderLinePage()
    var
        MRHeaderRecL: Record "Material Requisition Header";
    begin
        if MRHeaderRecL.get("Document No.") then begin
            if (MRHeaderRecL.Status = MRHeaderRecL.Status::"Pending Approval") or (MRHeaderRecL.Status = MRHeaderRecL.Status::Released) then begin
                EditableFalseTrueAllControl := false;
            end
            else begin
                EditableFalseTrueAllControl := true;

            end;
        end;
    end;
}