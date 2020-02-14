table 50005 "Material Requisition Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }


        field(3; "Date of Requisition"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Requisition date';
            Editable = false;
        }
        field(22; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger
            OnValidate()
            var
                MatReqLineRecL: Record "Material Requisition Line";
                PaymentMileStoneRecL: Record "Payment Milestone";
                JobRecL: Record Job;
            begin
                if "Job No." <> xRec."Job No." then begin
                    MatReqLineRecL.CheckJobJobTaskLine("Requisition No.", xRec."Job No.", xRec."Job task No.");
                    Clear("Job task No.");
                end;

                if "Enquiry Type" = "Enquiry Type"::General then
                    Error('Enquiry Type must be Project.')
                else
                    if "Enquiry Type" = "Enquiry Type"::" " then
                        Error('Please Select Enquiry Type as  a Project');


                // Start 08-09-2019
                JobRecL.Reset();
                if JobRecL.Get("Job No.") then begin
                    PaymentMileStoneRecL.Reset();
                    PaymentMileStoneRecL.SetRange("Document No.", "Job No.");
                    PaymentMileStoneRecL.SetRange("Document Type", PaymentMileStoneRecL."Document Type"::Job);
                    PaymentMileStoneRecL.SetRange("Posting Type", PaymentMileStoneRecL."Posting Type"::Advance);
                    if PaymentMileStoneRecL.FindFirst() then begin
                        if JobRecL."Advance Received" = false then
                            Error('Advance not recieve for Job %1', JobRecL."No.");
                    end;
                end;
                // Stop 08-09-2019
            end;

        }
        field(23; "Job task No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Task"."Job Task No." where ("Job No." = field ("Job No."), "Job Task Type" = const (Posting));
            trigger
            OnValidate()
            var
                MatReqLineRecL: Record "Material Requisition Line";
            begin
                if "Job Task No." <> xRec."Job Task No." then begin
                    MatReqLineRecL.CheckJobJobTaskLine("Requisition No.", xRec."Job No.", xRec."Job task No.");
                end
            end;
        }
        field(24; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(25; "Expected receipt date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Supplier name"; Text[100])
        {
            // DATATYPE chnages Text[100] to code[50]
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

        }
        field(28; "Origin of Item"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = ' Item Origin 2';
        }
        field(29; "Project Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Dimension;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1), Blocked = const (false));
        }
        field(30; "Initiator Id"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Creation Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Approver ID"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Sent for approval datetime"; DateTime)
        {
            DataClassification = ToBeClassified;

        }
        field(34; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Released;
        }
        field(35; "Enquiry Type"; Option)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = " ",General,Service,Material;
            OptionMembers = " ",General,Project;
            Caption = 'Requisition Type';
            trigger OnValidate()
            begin
                if "Enquiry Type" <> "Enquiry Type"::Project then begin
                    Clear("Job No.");
                    Clear("Job task No.");
                end;
            end;
        }
        field(36; "Req. Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Editable = true;
        }


        field(37; "Origin of Item 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = ' Item Origin';
            TableRelation = "Country/Region";
        }
        field(38; "Supplier name 2"; code[20])
        {
            // DATATYPE chnages Text[100] to code[50]
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            trigger
            OnValidate()
            var
                VendorRecL: Record Vendor;
            begin
                if "Supplier name 2" = '' then
                    Clear("Vendor Name")
                else
                    if xRec."Supplier name 2" <> "Supplier name 2" then begin
                        VendorRecL.Get("Supplier name 2");
                        Validate("Vendor Name", VendorRecL.Name);
                    end;

            end;
        }
        field(39; "Vendor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(PK; "Requisition No.")
        {
            Clustered = true;
        }
    }

    var
        PurchPayableSetupRecG: Record "Purchases & Payables Setup";


    trigger OnInsert()
    begin

        InitInsert();
        "Date of Requisition" := WorkDate();

    end;

    trigger OnModify()
    begin
        If (Status = Status::"Pending Approval") OR (Status = Status::Released) then
            Error('You cannot modify the record when status is %1', Status)
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure TestNoSeries()
    begin
        PurchPayableSetupRecG.Reset();
        PurchPayableSetupRecG.Get();
        PurchPayableSetupRecG.TestField("Material Requisition No.");
    end;

    procedure InitInsert()
    var
        NoSeriesMgtCUL: Codeunit NoSeriesManagement;
    begin
        PurchPayableSetupRecG.Reset();
        PurchPayableSetupRecG.Get();
        if "Requisition No." = '' then begin
            TestNoSeries();
            NoSeriesMgtCUL.InitSeries(PurchPayableSetupRecG."Material Requisition No.", xRec."Requisition No.", Today(), "Requisition No.", PurchPayableSetupRecG."Material Requisition No.");
            "Creation Date and Time" := CurrentDateTime();
            "Date of Requisition" := WorkDate();
            "Req. Creation Date" := Today;
        end;
    end;



}