table 50009 "Purchase Quote Header"

{
    DataClassification = ToBeClassified;

    fields
    {


        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(21; "Enquiry no"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purch. Enquiry Header";

        }
        field(22; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Material Requisition Header";

        }
        field(23; "Vendor No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            trigger
            OnValidate()
            var
                VendorRecL: Record Vendor;
            begin
                if (xRec."Vendor No." <> "Vendor No.") AND ("Vendor No." <> '') then begin
                    VendorRecL.Reset();
                    VendorRecL.Get("Vendor No.");
                    // Start Vendor Information
                    Validate(Address, VendorRecL.Address);
                    Validate("Address 2", VendorRecL."Address 2");
                    Validate("Post Code", VendorRecL."Post Code");
                    Validate(City, VendorRecL.City);
                    Validate("Phone No.", VendorRecL."Phone No.");
                    // Stop Vendor Information
                end;

                if "Vendor No." = '' then begin
                    Clear(Address);
                    Clear("Address 2");
                    Clear("Post Code");
                    Clear(City);
                    Clear("Phone No.");
                end;

            end;
        }
        field(24; Address; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Address 2"; text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; City; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Type of Purchase"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Values Import",General,"Raw material",Branded;
        }
        field(30; "Purchaser Code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(31; "Promised receipt date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Job No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Job Task No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Ref. No"; Code[50])
        {
            Caption = 'Vendor Quote number';
            DataClassification = ToBeClassified;
        }
        field(36; "Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }















    }


    keys
    {
        key(PK; "No.")
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

}