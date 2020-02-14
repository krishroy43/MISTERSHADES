tableextension 50022 "Ext. Job Planning Line" extends "Job Planning Line"
{
    fields
    {
        field(50000; "Enquiry Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // Start 07.05.2019
        //New field added to check Requisition Line Qty for each line
        field(50001; "Requisition Qty."; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = sum ("Material Requisition Line"."Qty. to Enquiry" where("Job No." = field("Job No."), "Job task No." = field("Job Task No."), "Job Planning Line No." = field("Line No.")));
            Editable = false;
        }
        field(50002; "Qty. Enquired"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Purch. Enquiry Line".Quantity where("Job No." = field("Job No."), "Job task No." = field("Job Task No."), "Job Planning Line No." = field("Line No.")));
            Editable = false;
            Caption = 'Enquiry Qty.';
        }

        // Stop 07.05.2019

        field(50048; "Company Item Description"; Text[250])
        {

        }
        field(50053; "Version No."; Integer)
        {

        }
        field(50054; "Narration"; Text[250])
        {

        }
        field(50055; "Drawing No."; Text[250])
        {

        }

    }


}