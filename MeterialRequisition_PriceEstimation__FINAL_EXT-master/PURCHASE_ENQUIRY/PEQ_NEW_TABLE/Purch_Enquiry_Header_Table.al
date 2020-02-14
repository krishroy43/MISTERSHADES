table 50002 "Purch. Enquiry Header"
{
    DataClassification = ToBeClassified;
    // Start Fields Adding 
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        /*
         field(21; "Lead Type"; Option)
         {
             OptionMembers = " ","Vendor","Contact";
             DataClassification = ToBeClassified;
         }
         */
        field(22; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            /*

            // Code comment for Vendor to Contact while Purchase Enquiry Creation
            trigger
            OnValidate()
            var
                VendorRecL: Record Vendor;
            begin

                if xRec."Vendor No." <> "Vendor No." then begin
                    VendorRecL.Reset();
                    VendorRecL.Get("Vendor No.");
                    // Start Vendor Information
                    // validate("Vendor No.", VendorRecL."No.");
                    Validate(Name, VendorRecL.Name);
                    Validate("Name 2", VendorRecL."Name 2");
                    //Validate(Contact, VendorRecL.Contact);
                    Validate(Contact, VendorRecL."Primary Contact No.");
                    Validate("Purchase Code", VendorRecL."Purchaser Code");
                    // Stop Vendor Information

                    // if format(VendorRecL."Lead Time Calculation") <> '' then
                    // "Expected delivery date" := CALCDATE(VendorRecL."Lead Time Calculation", DT2DATE("Creation dateTime"))
                    //else
                    // "Expected delivery date" := DT2DATE("Creation dateTime");
                end;
                /*
                                if format(VendorRecL."Lead Time Calculation") <> '' then
                                    "Expected delivery date" := CALCDATE(VendorRecL."Lead Time Calculation", DT2DATE("Creation dateTime"))
                                else
                                    "Expected delivery date" := DT2DATE("Creation dateTime");

                */

            /*
              if "Vendor No." = '' then begin
                  Clear(Name);
                  Clear("Name 2");
                  Clear(Contact);
                  Clear("Purchase Code");
              end;






          end;
          */
        }
        field(23; "Contact"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
            trigger
            OnValidate()
            var
                SalespersonPurchaserRecL: Record "Salesperson/Purchaser";
                ContactRecL: Record Contact;
            begin
                ContactRecL.Reset();
                if ContactRecL.Get(Contact) then begin
                    "Purchase Code" := ContactRecL."Salesperson Code";
                    //Modify();
                end;

            end;


            //where ("No." = field ("Vendor No."));
            /*
             trigger
             OnLookup()
             var
                 VendorRecL: Record Vendor;
                 Cont: Record Contact;
                 ContBusinessRelation: Record "Contact Business Relation";

             begin
                 VendorRecL.Get("Vendor No.");
                 IF "Vendor No." <> '' THEN
                     IF Cont.GET(VendorRecL."Primary Contact No.") THEN
                         Cont.SETRANGE("Company No.", Cont."Company No.")
                     ELSE
                         IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Vendor, "Vendor No.") THEN
                             Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.")
                         ELSE
                             Cont.SETRANGE("No.", '');

                 IF VendorRecL."Primary Contact No." <> '' THEN
                     IF Cont.GET(VendorRecL."Primary Contact No.") THEN;
                 IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                     xRec := Rec;
                     VALIDATE(Contact, Cont."No.");
                 END;
             end;

             */
        }
        field(24; "Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Name 2"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        /*
        field(25; "Address"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Address 2"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Post Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "City"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Phone No."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        */
        field(30; "Purchase Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(31; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Material Requisition Header";
            Editable = false;
        }
        field(32; "Creation dateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Expected delivery date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger
            OnValidate()
            var
                MatReqLineRecL: Record "Material Requisition Line";
            begin
                if "Job No." <> xRec."Job No." then begin
                    // MatReqLineRecL.CheckJobJobTaskLine("Requisition No.", xRec."Job No.", xRec."Job task No.");
                    Clear("Job task No.");
                end
            end;
        }
        field(35; "Job Task No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Task"."Job Task No." where ("Job No." = field ("Job No."), "Job Task Type" = const (Posting));
            trigger
            OnValidate()
            var
                MatReqLineRecL: Record "Material Requisition Line";
                PurchEnqryL: Record "Purch. Enquiry Line";
            begin
                if "Job Task No." <> xRec."Job Task No." then begin
                    PurchEnqryL.CheckJobJobTaskLine("Requisition No.", xRec."Job No.", xRec."Job task No.");
                end
            end;
        }
        field(37; "Converted to Quote"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }

    }
    // Stop Fields Adding
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        PurchPayableSetupRecG: Record "Purchases & Payables Setup";

    trigger OnInsert()
    begin
        InitInsert();

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
    begin



    end;

    trigger OnRename()
    begin

    end;

    procedure TestNoSeries()
    begin
        PurchPayableSetupRecG.Reset();
        PurchPayableSetupRecG.Get();
        PurchPayableSetupRecG.TestField("Purchase Enquiry No.");
    end;

    procedure InitInsert()
    var
        NoSeriesMgtCUL: Codeunit NoSeriesManagement;
    begin
        PurchPayableSetupRecG.Reset();
        PurchPayableSetupRecG.Get();
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgtCUL.InitSeries(PurchPayableSetupRecG."Purchase Enquiry No.", xRec."No.", Today(), "No.", PurchPayableSetupRecG."Purchase Enquiry No.");
        end;
    end;

}