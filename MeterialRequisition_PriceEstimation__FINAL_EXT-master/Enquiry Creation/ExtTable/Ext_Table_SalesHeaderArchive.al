tableextension 50002 "Ext. Sales Header Archive" extends "Sales Header Archive"
{
    fields
    {
        field(50651; "Order Accepted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50505; "Sales Transaction Type"; Option)
        {
            OptionMembers = " ",Dispatch,"Proforma Invoice";
        }
        // field(50001; "Over Head %"; Decimal)
        // {

        field(50506; "Progressive Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50000; "Dispatch Type"; Option)
        {
            //As per Ankur guide line
            //OptionMembers = " ","Partial","Final";
            OptionMembers = "Partial","Final";
        }

        field(50013; "Scope Of Work 1"; Text[100])
        {
            Caption = 'Scope Of Work';

        }
        field(50014; "Scope Of Work 2"; Text[100])
        {

        }
        field(50001; "Over Head %"; Decimal)
        {


        }
        field(50002; "Margin %"; Decimal)
        {

        }
        field(50004; "Scope Of Work"; Code[20])
        {
            TableRelation = Opportunity;


        }
        field(50005; "Product Type"; Code[250])
        {
        }
        field(50006; "Location Details"; Text[250])
        {
            Caption = 'Project Location';
        }
        field(50007; "Quote Validity"; Date)
        {

        }
        field(50008; "Warranty"; Boolean)
        {

        }
        field(50009; "Insurance"; Boolean)
        {

        }
        field(50010; "Estimation Version No."; Integer)
        {
            InitValue = 1;
        }
        field(50011; "Work Done"; Decimal)
        {

        }

        field(50101; "Job No."; Code[20])
        {
        }
        field(50102; "Job description"; Text[150])
        {
            Editable = false;
        }
        field(50103; "Job Task No"; Code[20])
        {
        }
        field(50104; "Job Task Description"; Text[150])
        {
            Editable = false;
        }
        field(50105; "Project Description"; Text[50])
        {

        }
        field(50106; "Consultant"; Code[80])
        {

        }
        field(50107; "Fabric Type"; Code[250])
        {
        }
        field(50108; "Dispatch Note"; Boolean)
        {
        }
        field(50109; "Delivery Location"; Text[250])
        {

        }
        field(50205; "Under Warranty"; Boolean)
        {
        }
        field(50110; "Client"; Text[100])
        {

        }
    }
}