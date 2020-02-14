report 50008 "JOBReport"
{

    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'JOB REPORT';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Job; Job)
        {
            DataItemTableView = sorting ("No.") order(ascending);
            RequestFilterFields = "No.";
            column(Creation_Date; Format("Creation Date")) { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(No_; "No.") { }
            column(TotalPrice; TotalPrice) { }
            column(Customer_PO_No_; "Customer PO No.") { }
            column(Sales_Quote_No; "Sales Quote") { }
            column(Project_Location; "Project Location") { }
            column(Product_Type; "Product Type") { }

            trigger OnAfterGetRecord();
            begin
                Clear(TotalPrice);
                JobTask_Rec.Reset;
                JobTask_Rec.SetRange("Job No.", "No.");
                JobTask_Rec.SetRange("Job Task Type", JobTask_Rec."Job Task Type"::Posting);
                if JobTask_Rec.FindSet then;
                repeat
                    JobTask_Rec.CalcFields("Contract (Total Price)");
                    TotalPrice += JobTask_Rec."Contract (Total Price)";
                until JobTask_Rec.Next = 0;
            end;


        }
    }


    var
        myInt: Integer;
        JobTask_Rec: Record "Job Task";
        TotalPrice: Decimal;
}