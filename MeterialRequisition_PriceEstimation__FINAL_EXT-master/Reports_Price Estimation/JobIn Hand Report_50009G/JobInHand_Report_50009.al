report 50009 "JOBINHAND"
{
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'JOB IN HAND';
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
            column(InvoicedPrice; InvoicedPrice) { }
            column(Customer_PO_No_; "Customer PO No.") { }
            column(Product_Type; "Product Type") { }
            column(Project_Location; "Project Location") { }
            column(Starting_Date; "Starting Date") { }
            trigger OnAfterGetRecord();
            begin
                Clear(TotalPrice);
                Clear(InvoicedPrice);
                JobTask_Rec.Reset;
                JobTask_Rec.SetRange("Job No.", "No.");
                JobTask_Rec.SetRange("Job Task Type", JobTask_Rec."Job Task Type"::Posting);
                if JobTask_Rec.FindSet then;
                repeat
                    JobTask_Rec.CalcFields("Contract (Total Price)");
                    TotalPrice += JobTask_Rec."Contract (Total Price)";
                    JobTask_Rec.CalcFields("Contract (Invoiced Price)");
                    InvoicedPrice += JobTask_Rec."Contract (Invoiced Price)";
                until JobTask_Rec.Next = 0;
            end;

        }
    }

    /*   requestpage
       {
           layout
           {
               area(Content)
               {
                   group(GroupName)
                   {
                       field(Name; SourceExpression)
                       {
                           ApplicationArea = All;

                       }
                   }
               }
           }

           actions
           {
               area(processing)
               {
                   action(ActionName)
                   {
                       ApplicationArea = All;

                   }
               }
           }
       }*/

    var
        myInt: Integer;
        JobTask_Rec: Record "Job Task";
        TotalPrice: Decimal;
        InvoicedPrice: Decimal;
}