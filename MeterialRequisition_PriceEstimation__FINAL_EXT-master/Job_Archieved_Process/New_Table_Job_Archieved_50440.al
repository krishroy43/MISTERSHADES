table 50440 "Archieved Job"
{
    DataClassification = ToBeClassified;
    Caption = 'Archived Job';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';


        }
        field(2; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';


        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(5; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';


        }
        field(12; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(13; "Starting Date"; Date)
        {
            Caption = 'Starting Date';


        }
        field(14; "Ending Date"; Date)
        {
            Caption = 'Ending Date';


        }
        field(19; Status; Option)
        {
            Caption = 'Status';
            InitValue = Open;
            OptionCaption = 'Planning,Quote,Open,Completed';
            OptionMembers = Planning,Quote,Open,Completed;


        }
        field(20; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';



        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';



        }
        field(23; "Job Posting Group"; Code[20])
        {
            Caption = 'Job Posting Group';
        }
        field(24; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Posting,All';
            OptionMembers = " ",Posting,All;
        }
        field(29; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;

        }
        field(31; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
        }
        field(32; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
        }
        field(49; "Scheduled Res. Qty."; Decimal)
        {

            Caption = 'Scheduled Res. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(50; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';

        }
        field(51; "Posting Date Filter"; Date)
        {
            Caption = 'Posting Date Filter';
        }
        field(55; "Resource Gr. Filter"; Code[20])
        {
            Caption = 'Resource Gr. Filter';
        }
        field(56; "Scheduled Res. Gr. Qty."; Decimal)
        {

            Caption = 'Scheduled Res. Gr. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(57; Picture; BLOB)
        {
            Caption = 'Picture';
            ObsoleteReason = 'Replaced by Image field';
            ObsoleteState = Pending;
            SubType = Bitmap;
        }
        field(58; "Bill-to Name"; Text[100])
        {
            Caption = 'Bill-to Name';
        }
        field(59; "Bill-to Address"; Text[100])
        {
            Caption = 'Bill-to Address';
        }
        field(60; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(61; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';

        }
        field(63; "Bill-to County"; Text[30])
        {

            Caption = 'Bill-to County';
        }
        field(64; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';

        }
        field(66; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;

        }
        field(67; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            Editable = true;

        }
        field(68; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
        }
        field(117; Reserve; Option)
        {
            AccessByPermission = TableData 27 = R;
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
        }
        field(1000; "WIP Method"; Code[20])
        {
            Caption = 'WIP Method';

        }
        field(1001; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';


        }
        field(1002; "Bill-to Contact No."; Code[20])
        {
            AccessByPermission = TableData 5050 = R;
            Caption = 'Bill-to Contact No.';


        }
        field(1003; "Bill-to Contact"; Text[100])
        {
            Caption = 'Bill-to Contact';
        }
        field(1004; "Planning Date Filter"; Date)
        {
            Caption = 'Planning Date Filter';

        }
        field(1005; "Total WIP Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Cost Amount';
            Editable = false;

        }
        field(1006; "Total WIP Cost G/L Amount"; Decimal)
        {
            Caption = 'Total WIP Cost G/L Amount';
            Editable = false;

        }
        field(1007; "WIP Entries Exist"; Boolean)
        {

            Caption = 'WIP Entries Exist';

        }
        field(1008; "WIP Posting Date"; Date)
        {
            Caption = 'WIP Posting Date';
            Editable = false;
        }
        field(1009; "WIP G/L Posting Date"; Date)
        {

            Caption = 'WIP G/L Posting Date';
            Editable = false;

        }
        field(1011; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';

        }
        field(1012; "Exch. Calculation (Cost)"; Option)
        {
            Caption = 'Exch. Calculation (Cost)';
            OptionCaption = 'Fixed FCY,Fixed LCY';
            OptionMembers = "Fixed FCY","Fixed LCY";
        }
        field(1013; "Exch. Calculation (Price)"; Option)
        {
            Caption = 'Exch. Calculation (Price)';
            OptionCaption = 'Fixed FCY,Fixed LCY';
            OptionMembers = "Fixed FCY","Fixed LCY";
        }
        field(1014; "Allow Schedule/Contract Lines"; Boolean)
        {
            Caption = 'Allow Budget/Billable Lines';
        }
        field(1015; Complete; Boolean)
        {
            Caption = 'Complete';


        }
        field(1017; "Recog. Sales Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Recog. Sales Amount';
            Editable = false;

        }
        field(1018; "Recog. Sales G/L Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Recog. Sales G/L Amount';
            Editable = false;

        }
        field(1019; "Recog. Costs Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Recog. Costs Amount';
            Editable = false;
        }
        field(1020; "Recog. Costs G/L Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Recog. Costs G/L Amount';
            Editable = false;
        }
        field(1021; "Total WIP Sales Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Total WIP Sales Amount';
            Editable = false;
        }
        field(1022; "Total WIP Sales G/L Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Sales G/L Amount';
            Editable = false;
        }
        field(1023; "WIP Completion Calculated"; Boolean)
        {

            Caption = 'WIP Completion Calculated';
        }
        field(1024; "Next Invoice Date"; Date)
        {

            Caption = 'Next Invoice Date';
        }
        field(1025; "Apply Usage Link"; Boolean)
        {
            Caption = 'Apply Usage Link';


        }
        field(1026; "WIP Warnings"; Boolean)
        {

            Caption = 'WIP Warnings';
            Editable = false;
        }
        field(1027; "WIP Posting Method"; Option)
        {
            Caption = 'WIP Posting Method';
            OptionCaption = 'Per Job,Per Job Ledger Entry';
            OptionMembers = "Per Job","Per Job Ledger Entry";


        }
        field(1028; "Applied Costs G/L Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Applied Costs G/L Amount';
            Editable = false;
        }
        field(1029; "Applied Sales G/L Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Applied Sales G/L Amount';
            Editable = false;
        }
        field(1030; "Calc. Recog. Sales Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Calc. Recog. Sales Amount';
            Editable = false;
        }
        field(1031; "Calc. Recog. Costs Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Calc. Recog. Costs Amount';
            Editable = false;
        }
        field(1032; "Calc. Recog. Sales G/L Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Calc. Recog. Sales G/L Amount';
            Editable = false;
        }
        field(1033; "Calc. Recog. Costs G/L Amount"; Decimal)
        {
            AutoFormatType = 1;

            Caption = 'Calc. Recog. Costs G/L Amount';
            Editable = false;
        }
        field(1034; "WIP Completion Posted"; Boolean)
        {

            Caption = 'WIP Completion Posted';
        }
        field(1035; "Over Budget"; Boolean)
        {
            Caption = 'Over Budget';
        }
        field(1036; "Project Manager"; Code[50])
        {
            Caption = 'Project Manager';
        }

        field(50000; "Customer PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Project Location"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Recipients Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Product Type"; Code[250])
        {
        }

        field(50004; "Sales Quote"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Sales Enquiry"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50006; "Approved Drawing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Material Mill Certificat"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Painting Technical Data"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Operation and Maintnc Manual"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Operation & Maintenance Manual';
        }
        field(50010; "As Built Drawing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "Apprv. Struct. Design Calc."; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved Structural Design Calculation';
        }
        field(50012; "Welding Statement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Elcomtr Calibrt. Certi. Paint"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Elcometer Calibration Certificate for Painting';
        }
        field(50014; "Erection Method Statement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Painting Method Statement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Magnetic Particle Test Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Painting Report DFT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50018; Finance; Code[20])
        {
            DataClassification = ToBeClassified;



        }
        field(50019; "Site Project manager"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(50020; Procurement; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50021; "Quantity Surveyor"; Code[20])
        {
            DataClassification = ToBeClassified;

        }


        field(50022; " Material Finalization"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Phy. and Material Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Physical and Material Approval';
        }
        field(50024; "Shop Drawing Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Prototype Requested"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Proforma Invoice created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Standard"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Standard 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50029; "Job Type"; Option)
        {
            OptionMembers = " ","Job in Hand",Project,"Tender Job","General Jobs",Trading;
        }

        field(50030; "Scope Of Work 1"; Text[100])
        {
            Caption = 'Scope Of Work';

        }
        field(50031; "Scope Of Work 2"; Text[100])
        {

        }
        field(50032; "Contract Ref."; Text[50])
        {

        }
        field(50033; "Customer Po. Date."; Date)
        {

        }
        field(50034; "Workflow Status"; Option)
        {

            OptionMembers = "Open","Pending for Approval","Released";

        }
        // Stop SRNo.7
        field(50036; "Salesperson Code"; Code[20])
        {
        }
        field(50037; "Completion date"; Date)
        {

        }
        field(50050; "Project Amount (Planned)"; Decimal)
        {
            Caption = 'Project Amount (Planned)';

            Editable = false;
        }

        field(50051; "Advance Received"; Boolean)
        {
            Editable = false;
        }

        field(50052; "Advance Amount"; Decimal)
        {

        }
        field(50053; "Archieved Version No."; Integer)
        {

        }



    }

    keys
    {
        key(Key1; "No.", "Archieved Version No.")
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