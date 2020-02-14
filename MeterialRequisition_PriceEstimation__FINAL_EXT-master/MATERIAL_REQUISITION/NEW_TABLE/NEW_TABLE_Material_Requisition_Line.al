table 50006 "Material Requisition Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            // OptionMembers = " ","Resource","Item","G/L Account","Text";
            OptionMembers = "Resource","Item","G/L Account","Text";
            trigger
            OnValidate()
            begin
                if xRec.Type <> Type then begin
                    Clear("No.");
                    Clear("Enquiry Item");
                    Clear("Qty. to Enquiry");
                    Clear("Available Inventory");
                    Clear(Location);
                    Clear("Unit of Measure");
                    Clear("Job No.");
                    Clear("Job task No.");
                    Clear("Job Planning Line No.");
                    Clear("Expected receipt date");
                    Clear("Item Description");
                end;
            end;
        }
        field(22; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            /*
            TableRelation = IF (Type = CONST (" ")) "Standard Text" ELSE
            IF (Type = CONST (Resource)) Resource ELSE
            IF (Type = CONST (Item)) Item;*/
            TableRelation = IF (Type = CONST (Resource)) Resource ELSE
            IF (Type = CONST (Item)) Item ELSE
            IF (Type = CONST ("G/L Account")) "G/L Account" ELSE
            //IF (Type = CONST (" ")) "Standard Text" ELSE
            IF (Type = CONST (Text)) "Standard Text";
            trigger
            OnValidate()
            begin
                CASE Type OF
                    Type::Text:
                        CopyFromStandardText;
                    Type::"G/L Account":
                        CopyFromGLAccount;
                    Type::Item:
                        CopyFromItem;
                    Type::Resource:
                        CopyFromResource;
                END;
                /*
                Validate("Qty. to Enquiry", ("Quantity needed" - "Available Inventory"));

                if "Qty. to Enquiry" > 0 then
                    Validate("Enquiry Item", true)
                else
                    Validate("Qty. to Enquiry", 0);
*/



            end;
        }
        field(23; "Quantity needed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quantity';
            trigger
            OnValidate()
            begin
                CheckQtyChangeIfGetLineFromJob("No.", "Job No.", "Job task No.", "Job Planning Line No.", "Quantity needed");
                Validate("Qty. to Enquiry", ("Quantity needed" - "Available Inventory"));

                if "Qty. to Enquiry" > 0 then
                    Validate("Enquiry Item", true)
                else
                    Validate("Qty. to Enquiry", 0);


                if "Quantity needed" = 0 then begin
                    Clear("Qty. to Enquiry");
                    Clear("Enquiry Item");
                end;

            end;
        }
        field(24; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST (Item), "No." = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("No.")) ELSE
            IF (Type = CONST (Resource), "No." = FILTER (<> '')) "Resource Unit of Measure".Code WHERE ("Resource No." = FIELD ("No.")) ELSE
            "Unit of Measure";

        }
        field(25; "Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(26; "Expected receipt date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger
            OnValidate()
            begin
                //if "Job No." <> xRec."Job No." then
                //Clear("Job task No.");

                //CheckJobJobTaskLine("No.", "Job No.", "Job task No.");
            end;
        }
        field(28; "Job task No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Task"."Job Task No." where ("Job No." = field ("Job No."), "Job Task Type" = const (Posting));
        }
        field(29; "Job Planning Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Available Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Enquiry Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = ' Create Enquiry';
        }
        field(32; "Qty. to Enquiry"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            begin
                if ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                    if ("Qty. to Enquiry" > "Quantity needed") then
                        Error('Quantity  can not be more than the Quantity in Job planning lines');
            end;
        }
        field(33; "Req. To Quote"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Req. To Enqry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // Start 28-06-2019
        field(35; "Item Description"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Item Description 2"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        // Stop 28-06-2019

    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        RequisitionHeaderRecL: Record "Material Requisition Header";
    begin
        RequisitionHeaderRecL.Reset();
        if RequisitionHeaderRecL.get("Document No.") then begin
            If (RequisitionHeaderRecL.Status = RequisitionHeaderRecL.Status::"Pending Approval") OR
            (RequisitionHeaderRecL.Status = RequisitionHeaderRecL.Status::Released) then
                Error('Status Should be Open for Delete Reqisition Line');
        end;
    end;

    trigger OnModify()
    var
    //  RequisitionHeaderRecL: Record "Material Requisition Header";
    begin
        // RequisitionHeaderRecL.Reset();
        //if RequisitionHeaderRecL.get("Document No.") then begin
        // If (RequisitionHeaderRecL.Status = RequisitionHeaderRecL.Status::"Pending Approval") OR
        // (RequisitionHeaderRecL.Status = RequisitionHeaderRecL.Status::Released) then
        // Error('Status Should be Open for Delete Reqisition Line');
        // end;
    end;

    trigger OnDelete()
    var
        RequisitionHeaderRecL: Record "Material Requisition Header";
    begin
        RequisitionHeaderRecL.Reset();
        if RequisitionHeaderRecL.get("Document No.") then begin
            If (RequisitionHeaderRecL.Status = RequisitionHeaderRecL.Status::"Pending Approval") OR
            (RequisitionHeaderRecL.Status = RequisitionHeaderRecL.Status::Released) then
                Error('Status Should be Open for Delete Reqisition Line');
        end;
    end;

    trigger OnRename()
    begin

    end;

    procedure CheckJobJobTaskLine(DocNoP: Code[50]; JobNoL: Code[50]; JobTaskL: Code[50])
    var
        MaterialReqLineRecL: Record "Material Requisition Line";
    begin
        MaterialReqLineRecL.SetRange("Document No.", DocNoP);
        MaterialReqLineRecL.SetRange("Job No.", JobNoL);
        MaterialReqLineRecL.SetRange("Job task No.", JobTaskL);
        if MaterialReqLineRecL.Count() > 0 then
            Error('Document No. %1 , Job No. %2 and Job Task No. %3 Lines are availabe.', DocNoP, JobNoL, JobTaskL);
    end;

    procedure CheckQtyChangeIfGetLineFromJob(ItemNo: Code[50]; JobNo: Code[50];
    JobTaskNo: Code[50]; PlnLineNo: Integer; CurrQty: Decimal)
    var
        PlanningJobLineL: Record "Job Planning Line";
        MRHeaderRecL: Record "Material Requisition Header";
    begin
        if MRHeaderRecL.Get("Document No.") then
            if (MRHeaderRecL."Job No." <> '') and (MRHeaderRecL."Job task No." <> '') then begin
                PlanningJobLineL.Reset();
                PlanningJobLineL.SetRange("Job No.", JobNo);
                PlanningJobLineL.SetRange("Job Task No.", JobTaskNo);
                PlanningJobLineL.SetRange("No.", ItemNo);
                PlanningJobLineL.SetRange("Line No.", PlnLineNo);
                if PlanningJobLineL.FindFirst() then
                    if CurrQty > PlanningJobLineL.Quantity then
                        Error('Quantity  can not be more than the Quantity in Job planning lines');
            end;
    end;


    procedure CopyFromStandardText()
    var
        StandardText: Record "Standard Text";
        MaterialHeaderL: Record "Material Requisition Header";
    begin
        MaterialHeaderL.Reset();
        StandardText.GET("No.");
        MaterialHeaderL.get("Document No.");
        Validate(Location, MaterialHeaderL."Location Code");
        Validate("Expected receipt date", MaterialHeaderL."Expected receipt date");
    end;

    procedure CopyFromGLAccount()
    var
        GLAcc: Record "G/L Account";
        MaterialHeaderL: Record "Material Requisition Header";
        MaterialRegLinePAge: page "Material Requisition Subform";
    begin
        MaterialHeaderL.Reset();
        MaterialHeaderL.get("Document No.");
        GLAcc.GET("No.");
        GLAcc.CheckGLAcc;
        Validate("Available Inventory", MaterialRegLinePAge.GetItemInvetoryByLocation("No.", MaterialHeaderL."Location Code"));
        //Validate("Unit of Measure");
        //Validate(Location, MaterialHeaderL."Location Code");
        Validate("Expected receipt date", MaterialHeaderL."Expected receipt date");

    end;

    procedure CopyFromItem()
    var
        Item: Record Item;
        MaterialHeaderL: Record "Material Requisition Header";
        MaterialRegLinePAge: page "Material Requisition Subform";
    begin
        MaterialHeaderL.Reset();
        MaterialHeaderL.get("Document No.");
        TESTFIELD("No.");
        Item.GET("No.");
        IF "No." <> Item."No." THEN
            Item.GET("No.");

        Item.TESTFIELD(Blocked, FALSE);
        Item.TESTFIELD("Gen. Prod. Posting Group");
        IF Item.Type = Item.Type::Inventory THEN BEGIN
            Item.TESTFIELD("Inventory Posting Group");
            //"Posting Group" := Item."Inventory Posting Group";
        END;
        Validate("Available Inventory", MaterialRegLinePAge.GetItemInvetoryByLocation("No.", MaterialHeaderL."Location Code"));
        Validate("Unit of Measure", Item."Base Unit of Measure");
        Validate(Location, MaterialHeaderL."Location Code");
        Validate("Expected receipt date", MaterialHeaderL."Expected receipt date");
        // Start 28-06-2019
        "Item Description" := Item.Description;
        // Stop 29-06-2019

    end;

    procedure CopyFromResource()
    var
        MaterialHeaderL: Record "Material Requisition Header";
        MaterialRegLinePAge: page "Material Requisition Subform";
        Res: Record Resource;
    begin
        MaterialHeaderL.Reset();
        MaterialHeaderL.get("Document No.");
        Res.GET("No.");
        Res.CheckResourcePrivacyBlocked(FALSE);
        Res.TESTFIELD(Blocked, FALSE);
        Validate("Available Inventory", MaterialRegLinePAge.GetItemInvetoryByLocation("No.", MaterialHeaderL."Location Code"));
        Validate("Unit of Measure", Res."Base Unit of Measure");
        Validate(Location, MaterialHeaderL."Location Code");
        Validate("Expected receipt date", MaterialHeaderL."Expected receipt date");
    end;





}