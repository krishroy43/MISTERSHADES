table 50004 "Purch. Enquiry Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = " ","Resource","Item","G/L Account","Text";
            OptionMembers = "Resource","Item","G/L Account","Text";
            trigger
            OnValidate()
            begin
                if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                    Error('Job No. / Job Task No. Must be blank.');
                if xRec.Type <> Type then begin
                    Clear("No.");
                    Clear(Location);
                    Clear("Expected receipt date");
                    Clear(Quantity);
                    Clear("Unit of Measure");
                    Clear("Job No.");
                    Clear("Job task No.");
                    Clear("Job Planning Line No.");
                end;

            end;

        }
        field(21; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST (Resource)) Resource ELSE
            IF (Type = CONST (Item)) Item ELSE
            IF (Type = CONST ("G/L Account")) "G/L Account" ELSE
            // IF (Type = CONST (" ")) "Standard Text" ELSE
            IF (Type = CONST (Text)) "Standard Text";
            trigger
            OnValidate()
            begin
                if ("Job No." <> '') and ("Job No." <> '') and ("Job Planning Line No." <> 0) then
                    Error('Job No. / Job Task No. Must be blank.');
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

            end;

        }
        field(22; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                MaterialRegLineRecL: Record "Material Requisition Line";
            begin
                MaterialRegLineRecL.Reset();
                MaterialRegLineRecL.SetRange("Document No.", "Material Req. No.");
                MaterialRegLineRecL.SetRange("Job No.", "Job No.");
                MaterialRegLineRecL.SetRange("Job task No.", "Job task No.");
                MaterialRegLineRecL.SetRange("Job Planning Line No.", "Job Planning Line No.");
                MaterialRegLineRecL.SetRange("No.", "No.");
                if MaterialRegLineRecL.FindFirst() then
                    if MaterialRegLineRecL."Qty. to Enquiry" <> Quantity then
                        Error('Quantity Must be equal to Requsition line Qrt. to Enquiry ');


            end;

        }
        field(23; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST (Item), "No." = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("No.")) ELSE
            IF (Type = CONST (Resource), "No." = FILTER (<> '')) "Resource Unit of Measure".Code WHERE ("Resource No." = FIELD ("No.")) ELSE
            "Unit of Measure";

        }
        field(24; "Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

        }
        field(25; "Expected receipt date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Expected delivery date';

        }
        field(26; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger
            OnValidate()
            begin
                if "Job No." <> xRec."Job No." then
                    Clear("Job task No.");

                CheckJobJobTaskLine("No.", "Job No.", "Job task No.");
            end;

        }
        field(27; "Job task No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Task"."Job Task No." where ("Job No." = field ("Job No."), "Job Task Type" = const (Posting));

        }
        field(28; "Job Planning Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(29; "Material Req. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Material Requisition Header";
            Editable = false;
        }
        // Start 28-06-2019
        field(30; "Item Description"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Item Description 2"; Text[80])
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
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure CopyFromResource()
    var
        Res: Record Resource;
        PurchEnqryHeaderL: Record "Purch. Enquiry Header";
    begin
        Res.GET("No.");
        PurchEnqryHeaderL.get("Document No.");
        Res.CheckResourcePrivacyBlocked(FALSE);
        Res.TESTFIELD(Blocked, FALSE);

        Validate("Expected receipt date", PurchEnqryHeaderL."Expected delivery date");
        if (PurchEnqryHeaderL."Job No." <> '') then
            Validate("Job No.", PurchEnqryHeaderL."Job No.");

        if (PurchEnqryHeaderL."Job Task No." <> '') then
            Validate("Job task No.", PurchEnqryHeaderL."Job Task No.");
        Validate("Unit of Measure", Res."Base Unit of Measure");
        Validate(Location, PurchEnqryHeaderL."Location Code");
    end;

    procedure CopyFromItem()
    var
        PurchEnqryHeaderL: Record "Purch. Enquiry Header";
        itemRecL: Record Item;
    begin
        PurchEnqryHeaderL.get("Document No.");
        itemRecL.Get("No.");
        Validate("Expected receipt date", PurchEnqryHeaderL."Expected delivery date");
        if (PurchEnqryHeaderL."Job No." <> '') then
            Validate("Job No.", PurchEnqryHeaderL."Job No.");

        if (PurchEnqryHeaderL."Job Task No." <> '') then
            Validate("Job task No.", PurchEnqryHeaderL."Job Task No.");

        Validate("Unit of Measure", itemRecL."Base Unit of Measure");
        Validate(Location, PurchEnqryHeaderL."Location Code");

        "Item Description" := itemRecL.Description;
        "Item Description 2" := itemRecL."Description 2";
    end;

    procedure CopyFromGLAccount()
    var
        PurchEnqryHeaderL: Record "Purch. Enquiry Header";
    begin
        PurchEnqryHeaderL.get("Document No.");
        Validate("Expected receipt date", PurchEnqryHeaderL."Expected delivery date");
        if (PurchEnqryHeaderL."Job No." <> '') then
            Validate("Job No.", PurchEnqryHeaderL."Job No.");

        if (PurchEnqryHeaderL."Job Task No." <> '') then
            Validate("Job task No.", PurchEnqryHeaderL."Job Task No.");
        //Validate(Location, PurchEnqryHeaderL."Location Code");


    end;

    procedure CopyFromStandardText()
    var
        StandardText: Record "Standard Text";
        PurchEnqryHeaderL: Record "Purch. Enquiry Header";
    begin
        StandardText.GET("No.");
        PurchEnqryHeaderL.get("Document No.");

        Validate("Expected receipt date", PurchEnqryHeaderL."Expected delivery date");
        if (PurchEnqryHeaderL."Job No." <> '') then
            Validate("Job No.", PurchEnqryHeaderL."Job No.");

        if (PurchEnqryHeaderL."Job Task No." <> '') then
            Validate("Job task No.", PurchEnqryHeaderL."Job Task No.");

        Validate(Location, PurchEnqryHeaderL."Location Code");

    end;

    procedure CheckJobJobTaskLine(DocNoP: Code[50]; JobNoL: Code[50]; JobTaskL: Code[50])
    var
        MaterialReqLineRecL: Record "Material Requisition Line";
        PurchEnqryLineL: Record "Purch. Enquiry Line";
    begin
        PurchEnqryLineL.SetRange("Document No.", DocNoP);
        PurchEnqryLineL.SetRange("Job No.", JobNoL);
        PurchEnqryLineL.SetRange("Job task No.", JobTaskL);
        if PurchEnqryLineL.Count() > 0 then
            Error('Document No. %1 , Job No. %2 and Job Task No. %3 Lines are availabe.', DocNoP, JobNoL, JobTaskL);
    end;


}