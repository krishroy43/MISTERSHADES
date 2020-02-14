// report 50055 "Sales Header Change Status"
// {
//     ApplicationArea = All;
//     Caption = 'Sales Header Change Status Report';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Permissions = TableData "Sales Header" = rimd;

//     dataset
//     {
//         dataitem("Sales Header"; "Sales Header")
//         {
//             RequestFilterFields = "No.", Status;
//             trigger
//             OnPreDataItem()
//             var
//                 SalesHeader: Record "Sales Header";
//             begin

//                 SalesHeader.Reset();
//                 SalesHeader.SetRange("No.", GetFilter("No."));
//                 "Sales Header".SetRange("Document Type", "Document Type"::Quote);
//                 if SalesHeader.FindFirst() then begin
//                     // if SalesHeader.get("Document Type", "No.") then begin
//                     SalesHeader.Status := Status::Open;
//                     SalesHeader.Modify();
//                 end;
//             end;
//         }

//     }
//     trigger
//     OnPostReport()
//     begin
//         Message('done');
//     end;
// }



// report 50056 "Opportunity Change Status"
// {
//     ApplicationArea = All;
//     Caption = 'Opportunity Change Status Report';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Permissions = TableData Opportunity = rimd;

//     dataset
//     {
//         dataitem(Opportunity;
//         Opportunity)
//         {
//             RequestFilterFields = "No.", Status;
//             trigger
//           OnPreDataItem()
//             var
//                 Opp: Record Opportunity;
//             begin
//                 // TestField("No.");
//                 // TestField(Status);
//                 Opp.Reset();
//                 if Opp.Get(GetFilter("No.")) then begin
//                     Opp.Status := Status::"Not Started";
//                     Opp.Modify();
//                 end;
//             end;
//         }
//     }
//     trigger
//     OnPostReport()
//     begin
//         Message('done');
//     end;
// }



// report 50057 "Purchase Header Change Status"
// {
//     ApplicationArea = All;
//     Caption = 'Purchase Header Change Status Report';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Permissions = TableData "Purchase Header" = rimd;


//     dataset
//     {
//         dataitem("Purchase Header"; "Purchase Header")
//         {
//             RequestFilterFields = "No.", Status, "Document Type";
//             trigger
//             OnPreDataItem()
//             var
//                 PurHrd: Record "Purchase Header";
//             begin
//                 // TestField("No.");
//                 // TestField(Status);
//                 // TestField("Document Type");
//                 PurHrd.Reset();
//                 PurHrd.SetRange("No.", GetFilter("No."));
//                 if PurHrd.FindFirst() then begin
//                     //if PurHrd.Get("Document Type", "No.") then begin
//                     PurHrd.Status := Status::Open;
//                     PurHrd.Modify();
//                 end;
//             end;
//         }
//     }
//     trigger
//     OnPostReport()
//     begin
//         Message('done');
//     end;
// }


// report 50058 "Job Change Status"
// {
//     ApplicationArea = All;
//     Caption = 'Job Change Status Report';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Permissions = TableData Job = rimd;

//     dataset
//     {
//         dataitem(Job_; Job)
//         {
//             RequestFilterFields = "No.", Status;
//             trigger
//            OnPreDataItem()
//             var
//                 JobRec: Record Job;
//             begin

//                 if JobRec.Get(GetFilter("No.")) then begin
//                     JobRec.Status := Status::Open;
//                     JobRec.Modify();
//                     Message('done');
//                 end;

//                 // Message('out done %1   -    %2', Job_."No.", Job_.Status);
//             end;
//         }

//     }
//     trigger
//     OnPostReport()
//     begin

//     end;
// }


// report 50059 "Cust. Report"
// {
//     ApplicationArea = All;
//     Caption = 'Cust Report';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Permissions = TableData "Cust. Ledger Entry" = rimd;

//     dataset
//     {

//         dataitem("Cust Led Entry"; "Cust. Ledger Entry")
//         {
//             RequestFilterFields = Open;

//             trigger
//            OnPreDataItem()
//             var
//                 CLERecL: Record "Cust. Ledger Entry";
//             begin

//                 CLERecL.Reset();
//                 CLERecL.SetRange(Open, false);
//                 if CLERecL.FindSet() then;
//                 // CLERecL.ModifyAll(Open, true);

//                 // Message('out done %1   -    %2', Job_."No.", Job_.Status);
//             end;
//         }

//     }
//     trigger
//     OnPostReport()
//     begin

//     end;
// }

report 50060 "Approval Entry Delete All"
{
    ApplicationArea = All;
    Caption = 'Delete Approval Entry Records';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = TableData "Approval Entry" = rimd;

    dataset
    {
        dataitem(ApprovalEntry; "Approval Entry")
        {
            trigger
           OnPreDataItem()
            var
                ApprovalEntry: Record "Approval Entry";
            begin

                ApprovalEntry.Reset();

                if ApprovalEntry.FindSet() then begin
                    DeleteAll();
                    Message('All Records Approval Entry Deleted Successfully.');
                end;
            end;
        }

    }

}
// /*
// Sales Enquiry
// */

// report 50061 "Opp. & Stage Cycle Delete All"
// {
//     ApplicationArea = All;
//     Caption = 'Opp. & Stage Cycle Delete All';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Permissions = TableData Opportunity = rimd, tabledata "Opportunity Entry" = rimd;

//     dataset
//     {
//         dataitem(Opportunity; Opportunity)
//         {
//             RequestFilterFields = "No.";

//             trigger
//            OnAfterGetRecord()
//             var
//                 Opportunity: Record Opportunity;
//                 OppEntry: Record "Opportunity Entry";
//                 EstHeader: Record "Estimation Header";
//                 EstLine: Record "Estimation Line Tbl";

//             begin

//                 Opportunity.Reset();
//                 Opportunity.SetRange("No.", "No.");
//                 if Opportunity.FindSet() then begin
//                     OppEntry.SetRange("Opportunity No.", Opportunity."No.");
//                     if OppEntry.FindSet() then
//                         OppEntry.DeleteAll();

//                     Opportunity.DeleteAll();
//                     EstHeader.DeleteAll();
//                     EstLine.DeleteAll();
//                     // Message('Deleted');
//                 end;
//             end;
//         }

//     }
// }




// /*
// Sales Enquiry
// */

// report 50063 "Sales Quote Delete All"
// {
//     ApplicationArea = All;
//     Caption = 'Sales Quote Delete All';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Permissions = TableData "Sales Header" = rimd, tabledata "Sales Line" = rimd;

//     dataset
//     {
//         dataitem(SalesHeader; "Sales Header")
//         {

//             RequestFilterFields = "No.";


//             trigger
//            OnAfterGetRecord()
//             var
//                 SalesHeader: Record "Sales Header";
//                 SalesLine: Record "Sales Line";
//             begin

//                 SalesHeader.Reset();
//                 SalesHeader.SetRange("No.", "No.");
//                 SalesHeader.SetRange("Document Type", "Document Type"::Quote);
//                 if SalesHeader.FindSet() then begin
//                     SalesLine.SetRange("Document No.", SalesHeader."No.");
//                     if SalesLine.FindSet() then
//                         SalesLine.DeleteAll();

//                     SalesHeader.DeleteAll();
//                     //Message('Deleted');
//                 end;
//             end;
//         }

//     }
// }




// /*
// Job 
// Job Task
// Job Planning Line
// */
// report 50064 "Jobs Task Planning Delete All"
// {
//     ApplicationArea = All;
//     Caption = 'Jobs Task Planning Delete All';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Permissions = TableData "Job" = rimd, tabledata "Job Task" = rimd, tabledata "Job Planning Line" = rimd;

//     dataset
//     {
//         dataitem(Job; Job)
//         {
//             RequestFilterFields = "No.";

//             trigger
//            OnAfterGetRecord()
//             var
//                 Job: Record Job;
//                 JobPlanningLine: Record "Job Planning Line";
//                 JobTask: Record "Job Task";

//             begin
//                 Job.Reset();
//                 Job.SetRange("No.", "No.");
//                 if Job.FindSet() then begin
//                     JobTask.Reset();
//                     JobTask.SetRange("Job No.", Job."No.");
//                     if JobTask.FindSet() then begin
//                         JobPlanningLine.Reset();
//                         JobPlanningLine.SetRange("Job No.", JobTask."Job No.");
//                         JobPlanningLine.SetRange("Job Task No.", JobTask."Job Task No.");
//                         if JobPlanningLine.FindSet() then begin
//                             JobPlanningLine.DeleteAll();
//                             JobTask.DeleteAll();
//                         end else
//                             JobTask.DeleteAll();
//                     end else
//                         Job.DeleteAll();
//                 end;
//                 //  Message('Delete');
//             end;
//         }

//     }
// }





// // Contact and Business

// report 50066 "Cont. & Business Delete All"
// {
//     ApplicationArea = All;
//     Caption = 'Cont. & Business Delete All';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     Permissions = TableData "Contact" = rimd, tabledata "Contact Business Relation" = rimd;

//     dataset
//     {
//         dataitem(Contact; "Contact")
//         {

//             RequestFilterFields = "No.";


//             trigger
//            OnAfterGetRecord()
//             var
//                 Cnt: Record "Contact";
//                 CntBusRel: Record "Contact Business Relation";
//             begin

//                 Cnt.DeleteAll();
//                 CntBusRel.DeleteAll();
//                 //Message('Deleted');

//             end;
//         }

//     }
// }