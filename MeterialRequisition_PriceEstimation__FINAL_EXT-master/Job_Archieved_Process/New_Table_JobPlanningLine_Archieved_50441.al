table 50441 "Archieved Job Planning Line"
{

    DataClassification = ToBeClassified;
    Caption = 'Archived Job Planning Line';

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            NotBlank = true;
        }
        field(3; "Planning Date"; Date)
        {
            Caption = 'Planning Date';

        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';

        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account,Text';
            OptionMembers = Resource,Item,"G/L Account",Text;


        }
        field(7; "No."; Code[20])
        {
            Caption = 'No.';

        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';


        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;


        }
        field(11; "Direct Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost (LCY)';
        }
        field(12; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            Editable = false;


        }
        field(13; "Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Cost (LCY)';
            Editable = false;
        }
        field(14; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
            Editable = false;


        }
        field(15; "Total Price (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price (LCY)';
            Editable = false;
        }
        field(16; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            Editable = false;

        }
        field(17; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';

        }
        field(20; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(29; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;

        }
        field(32; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
        }
        field(33; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';

        }
        field(79; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Editable = false;

        }
        field(80; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            Editable = false;

        }
        field(81; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            Editable = false;

        }
        field(83; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(1000; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            NotBlank = true;

        }
        field(1001; "Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount (LCY)';
            Editable = false;

        }
        field(1002; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';

        }
        field(1003; "Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Cost';
            Editable = false;
        }
        field(1004; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';

        }
        field(1005; "Total Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Price';
            Editable = false;
        }
        field(1006; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';

        }
        field(1007; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';

        }
        field(1008; "Line Discount Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount (LCY)';
            Editable = false;

        }
        field(1015; "Cost Factor"; Decimal)
        {
            Caption = 'Cost Factor';
            Editable = false;
        }
        field(1019; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';
            Editable = false;
        }
        field(1020; "Lot No."; Code[50])
        {
            Caption = 'Lot No.';
            Editable = false;
        }
        field(1021; "Line Discount %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;

        }
        field(1022; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = 'Budget,Billable,Both Budget and Billable';
            OptionMembers = Budget,Billable,"Both Budget and Billable";


        }
        field(1023; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;

        }
        field(1024; "Currency Date"; Date)
        {
            AccessByPermission = TableData 4 = R;
            Caption = 'Currency Date';
        }
        field(1025; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

        }
        field(1026; "Schedule Line"; Boolean)
        {
            Caption = 'Budget Line';
            Editable = false;
            InitValue = true;
        }
        field(1027; "Contract Line"; Boolean)
        {
            Caption = 'Billable Line';
            Editable = false;
        }
        field(1030; "Job Contract Entry No."; Integer)
        {
            Caption = 'Job Contract Entry No.';
            Editable = false;
        }
        field(1035; "Invoiced Amount (LCY)"; Decimal)
        {
            Caption = 'Invoiced Amount (LCY)';
            Editable = false;
        }
        field(1036; "Invoiced Cost Amount (LCY)"; Decimal)
        {
            Caption = 'Invoiced Cost Amount (LCY)';
            Editable = false;

        }
        field(1037; "VAT Unit Price"; Decimal)
        {
            Caption = 'VAT Unit Price';
        }
        field(1038; "VAT Line Discount Amount"; Decimal)
        {
            Caption = 'VAT Line Discount Amount';
        }
        field(1039; "VAT Line Amount"; Decimal)
        {
            Caption = 'VAT Line Amount';
        }
        field(1041; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
        }
        field(1042; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(1043; "Job Ledger Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Job Ledger Entry No.';
            Editable = false;
        }
        field(1048; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            InitValue = "Order";
            OptionCaption = 'Planning,Quote,Order,Completed';
            OptionMembers = Planning,Quote,"Order",Completed;
        }
        field(1050; "Ledger Entry Type"; Option)
        {
            Caption = 'Ledger Entry Type';
            OptionCaption = ' ,Resource,Item,G/L Account';
            OptionMembers = " ",Resource,Item,"G/L Account";
        }
        field(1051; "Ledger Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Ledger Entry No.';
        }
        field(1052; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
        }
        field(1053; "Usage Link"; Boolean)
        {
            Caption = 'Usage Link';

        }
        field(1060; "Remaining Qty."; Decimal)
        {
            Caption = 'Remaining Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;


        }
        field(1061; "Remaining Qty. (Base)"; Decimal)
        {
            Caption = 'Remaining Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(1062; "Remaining Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Total Cost';
            Editable = false;
        }
        field(1063; "Remaining Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Total Cost (LCY)';
            Editable = false;
        }
        field(1064; "Remaining Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Line Amount';
            Editable = false;
        }
        field(1065; "Remaining Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Line Amount (LCY)';
            Editable = false;
        }
        field(1070; "Qty. Posted"; Decimal)
        {
            Caption = 'Qty. Posted';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(1071; "Qty. to Transfer to Journal"; Decimal)
        {
            Caption = 'Qty. to Transfer to Journal';
            DecimalPlaces = 0 : 5;
        }
        field(1072; "Posted Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Posted Total Cost';
            Editable = false;
        }
        field(1073; "Posted Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Posted Total Cost (LCY)';
            Editable = false;
        }
        field(1074; "Posted Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Posted Line Amount';
            Editable = false;
        }
        field(1075; "Posted Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Posted Line Amount (LCY)';
            Editable = false;
        }
        field(1080; "Qty. Transferred to Invoice"; Decimal)
        {
            Caption = 'Qty. Transferred to Invoice';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(1081; "Qty. to Transfer to Invoice"; Decimal)
        {
            Caption = 'Qty. to Transfer to Invoice';
            DecimalPlaces = 0 : 5;

        }
        field(1090; "Qty. Invoiced"; Decimal)
        {
            Caption = 'Qty. Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(1091; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(1100; "Reserved Quantity"; Decimal)
        {
            Caption = 'Reserved Quantity';

            Editable = false;

        }
        field(1101; "Reserved Qty. (Base)"; Decimal)
        {
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;


        }
        field(1102; Reserve; Option)
        {
            AccessByPermission = TableData 27 = R;
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;


        }
        field(1103; Planned; Boolean)
        {
            Caption = 'Planned';
            Editable = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';

        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5410; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;


        }
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';


        }
        field(5791; "Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';


        }
        field(5794; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(50000; "Enquiry Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50001; "Requisition Qty."; Decimal)
        {

            Editable = false;
        }
        field(50002; "Qty. Enquired"; Decimal)
        {
            Editable = false;
            Caption = 'Enquiry Qty.';
        }
        field(50048; "Company Item Description"; Text[250])
        {

        }
        field(50053; "Archieved Version No."; Integer)
        {

        }


    }

    keys
    {
        key(Key1; "Job No.", "Job Task No.", "Line No.", "Archieved Version No.")
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
