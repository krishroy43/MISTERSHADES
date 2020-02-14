table 50651 "Order Acceptance"
{
    fields
    {
        // Start General Table
        field(1; "Sales Quote No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Order Acceptance status"; Option)
        {
            OptionMembers = Open,Completed;
            DataClassification = ToBeClassified;
        }
        field(4; "Acceptance date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        // Stop General Table
        // Start Contract Table
        field(5; "Contract Documents Verified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Warranty Details Confirmed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Contract Remarks"; Text[150])
        {

        }
        // Stop Contract Table
        // Start Finance Table
        field(8; "Finance Documents Verified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Customer PO Received"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Advance Received"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Finance Remarks"; text[150])
        {
            DataClassification = ToBeClassified;
        }
        // Stop Finance Table
        // Start Management Tab
        field(12; "Terms and conditions approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Payment Milestones confirmed"; Boolean)
        {

        }
        field(14; "Profitability confirmed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Management Remarks"; text[150])
        {
            DataClassification = ToBeClassified;
        }
        // Stop Management Tab

    }

    trigger
    OnModify()
    begin

    end;
}