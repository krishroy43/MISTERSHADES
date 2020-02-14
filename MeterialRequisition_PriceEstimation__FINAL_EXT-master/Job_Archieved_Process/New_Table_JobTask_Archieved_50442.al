table 50442 "Archieved Job Task"
{

    DataClassification = ToBeClassified;
    Caption = 'Archived Job Task';

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Editable = false;
            NotBlank = true;
        }
        field(2; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            NotBlank = true;


        }

        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Job Task Type"; Option)
        {
            Caption = 'Job Task Type';
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";

        }
        field(6; "WIP-Total"; Option)
        {
            Caption = 'WIP-Total';
            OptionCaption = ' ,Total,Excluded';
            OptionMembers = " ",Total,Excluded;


        }
        field(7; "Job Posting Group"; Code[20])
        {
            Caption = 'Job Posting Group';


        }
        field(9; "WIP Method"; Code[20])
        {
            Caption = 'WIP Method';

        }
        field(10; "Schedule (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Budget (Total Cost)';
            Editable = false;

        }
        field(11; "Schedule (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Budget (Total Price)';
            Editable = false;

        }
        field(12; "Usage (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Usage (Total Cost)';
            Editable = false;

        }
        field(13; "Usage (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Usage (Total Price)';
            Editable = false;

        }
        field(14; "Contract (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Billable (Total Cost)';
            Editable = false;

        }
        field(15; "Contract (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Billable (Total Price)';
            Editable = false;

        }
        field(16; "Contract (Invoiced Price)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Billable (Invoiced Price)';
            Editable = false;

        }
        field(17; "Contract (Invoiced Cost)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Billable (Invoiced Cost)';
            Editable = false;

        }
        field(19; "Posting Date Filter"; Date)
        {
            Caption = 'Posting Date Filter';
        }
        field(20; "Planning Date Filter"; Date)
        {
            Caption = 'Planning Date Filter';
        }
        field(21; Totaling; Text[250])
        {
            Caption = 'Totaling';
        }
        field(22; "New Page"; Boolean)
        {
            Caption = 'New Page';
        }
        field(23; "No. of Blank Lines"; Integer)
        {
            BlankZero = true;
            Caption = 'No. of Blank Lines';
            MinValue = 0;
        }
        field(24; Indentation; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
        }
        field(34; "Recognized Sales Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Recognized Sales Amount';
            Editable = false;
        }
        field(37; "Recognized Costs Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Recognized Costs Amount';
            Editable = false;
        }
        field(56; "Recognized Sales G/L Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Recognized Sales G/L Amount';
            Editable = false;
        }
        field(57; "Recognized Costs G/L Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Recognized Costs G/L Amount';
            Editable = false;
        }
        field(60; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';

        }
        field(61; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';

        }
        field(62; "Outstanding Orders"; Decimal)
        {

            Caption = 'Outstanding Orders';

        }
        field(63; "Amt. Rcd. Not Invoiced"; Decimal)
        {

            Caption = 'Amt. Rcd. Not Invoiced';

        }
        field(64; "Remaining (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Remaining (Total Cost)';
            Editable = false;

        }
        field(65; "Remaining (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;

            Caption = 'Remaining (Total Price)';
            Editable = false;

        }
        field(66; "Start Date"; Date)
        {

            Caption = 'Start Date';
            Editable = false;

        }
        field(67; "End Date"; Date)
        {

            Caption = 'End Date';
            Editable = false;

        }
        field(50053; "Archieved Version No."; Integer)
        {

        }

    }

    keys
    {
        key(Key1; "Job No.", "Job Task No.", "Archieved Version No.")
        {
            //SumIndexFields = "Recognized Sales Amount", "Recognized Costs Amount", "Recognized Sales G/L Amount", "Recognized Costs G/L Amount";
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