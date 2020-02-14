page 50442 "Arch. Job Task Lines Subform"
{
    Caption = 'Archived Job Task Lines Subform';
    DataCaptionFields = "Job No.";
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "Archieved Job Task";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;



    layout
    {
        area(content)
        {
            repeater("ArchJobTask")
            {
                // IndentationColumn = DescriptionIndent;
                // IndentationControls = Description;
                field("Archieved Version No."; "Archieved Version No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Job No."; "Job No.")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    // Style = Strong;
                    // StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies the number of the related job.';
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    // Style = Strong;
                    // StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies the number of the related job task.';
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    // Style = Strong;
                    // StyleExpr = StyleIsStrong;
                    ToolTip = 'Specifies a description of the job task. You can enter anything that is meaningful in describing the task. The description is copied and used in descriptions on the job planning line.';
                }
                field("Job Task Type"; "Job Task Type")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    ToolTip = 'Specifies the purpose of the account. Newly created accounts are automatically assigned the Posting account type, but you can change this. Choose the field to select one of the following five options:';
                }
                field(Totaling; Totaling)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies an interval or a list of job task numbers.';
                    Visible = false;
                }
                field("Job Posting Group"; "Job Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the job posting group of the task.';
                    Visible = false;
                }
                field("WIP-Total"; "WIP-Total")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the job tasks you want to group together when calculating Work In Process (WIP) and Recognition.';
                    Visible = false;
                }
                field("WIP Method"; "WIP Method")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the Work in Process calculation method that is associated with a job. The value in this field comes from the WIP method specified on the job card.';
                    Visible = false;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    ToolTip = 'Specifies the start date for the job task. The date is based on the date on the related job planning line.';
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    ToolTip = 'Specifies the end date for the job task. The date is based on the date on the related job planning line.';
                }
                field("Schedule (Total Cost)"; "Schedule (Total Cost)")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    Caption = 'Budget (Total Cost)';
                    ToolTip = 'Specifies, in the local currency, the total budgeted cost for the job task during the time period in the Planning Date Filter field.';
                }
                field("Schedule (Total Price)"; "Schedule (Total Price)")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget (Total Price)';
                    ToolTip = 'Specifies, in local currency, the total budgeted price for the job task during the time period in the Planning Date Filter field.';
                    Visible = false;
                }
                field("Usage (Total Cost)"; "Usage (Total Cost)")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    Caption = 'Actual (Total Cost)';
                    ToolTip = 'Specifies, in local currency, the total cost of the usage of items, resources and general ledger expenses posted on the job task during the time period in the Posting Date Filter field.';
                }
                field("Usage (Total Price)"; "Usage (Total Price)")
                {
                    ApplicationArea = Suite;
                    Caption = 'Actual (Total Price)';
                    ToolTip = 'Specifies, in the local currency, the total price of the usage of items, resources and general ledger expenses posted on the job task during the time period in the Posting Date Filter field.';
                    Visible = false;
                }
                field("Contract (Total Cost)"; "Contract (Total Cost)")
                {
                    ApplicationArea = Suite;
                    Caption = 'Billable (Total Cost)';
                    ToolTip = 'Specifies, in local currency, the total billable cost for the job task during the time period in the Planning Date Filter field.';
                    Visible = false;
                }
                field("Contract (Total Price)"; "Contract (Total Price)")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    Caption = 'Billable (Total Price)';
                    ToolTip = 'Specifies, in the local currency, the total billable price for the job task during the time period in the Planning Date Filter field.';
                }
                field("Contract (Invoiced Cost)"; "Contract (Invoiced Cost)")
                {
                    ApplicationArea = Suite;
                    Caption = 'Billable (Invoiced Cost)';
                    ToolTip = 'Specifies, in the local currency, the total billable cost for the job task that has been invoiced during the time period in the Posting Date Filter field.';
                    Visible = false;
                }
                field("Contract (Invoiced Price)"; "Contract (Invoiced Price)")
                {
                    ApplicationArea = Basic, Suite, Jobs;
                    Caption = 'Billable (Invoiced Price)';
                    ToolTip = 'Specifies, in the local currency, the total billable price for the job task that has been invoiced during the time period in the Posting Date Filter field.';
                }
                field("Remaining (Total Cost)"; "Remaining (Total Cost)")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the remaining total cost (LCY) as the sum of costs from job planning lines associated with the job task. The calculation occurs when you have specified that there is a usage link between the job ledger and the job planning lines.';
                    Visible = false;
                }
                field("Remaining (Total Price)"; "Remaining (Total Price)")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the remaining total price (LCY) as the sum of prices from job planning lines associated with the job task. The calculation occurs when you have specified that there is a usage link between the job ledger and the job planning lines.';
                    Visible = false;
                }
                // field("EAC (Total Cost)"; CalcEACTotalCost)
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'EAC (Total Cost)';
                //     ToolTip = 'Specifies the estimate at completion (EAC) total cost for a job task line. If the Apply Usage Link check box on the job is selected, then the EAC (Total Cost) field is calculated as follows:';
                //     Visible = false;
                // }
                // field("EAC (Total Price)"; CalcEACTotalPrice)
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'EAC (Total Price)';
                //     ToolTip = 'Specifies the estimate at completion (EAC) total price for a job task line. If the Apply Usage Link check box on the job is selected, then the EAC (Total Price) field is calculated as follows:';
                //     Visible = false;
                // }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field("Outstanding Orders"; "Outstanding Orders")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the sum of outstanding orders, in local currency, for this job task. The value of the Outstanding Amount (LCY) field is used for entries in the Purchase Line table of document type Order to calculate and update the contents of this field.';
                    Visible = false;


                }
                field("Amt. Rcd. Not Invoiced"; "Amt. Rcd. Not Invoiced")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the sum for items that have been received but have not yet been invoiced. The value in the Amt. Rcd. Not Invoiced (LCY) field is used for entries in the Purchase Line table of document type Order to calculate and update the contents of this field.';
                    Visible = false;


                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Planning Lines")
            {
                Image = Line;
                ApplicationArea = All;
                trigger
                OnAction()
                var
                    ArchPlanningLineRecL: Record "Archieved Job Planning Line";
                    ArchJobTaskRecL: Record "Archieved Job Task";
                begin
                    CurrPage.SetSelectionFilter(ArchJobTaskRecL);
                    if ArchJobTaskRecL.FindFirst() then begin
                        ArchPlanningLineRecL.Reset();
                        ArchPlanningLineRecL.SetRange("Job No.", "Job No.");
                        ArchPlanningLineRecL.SetRange("Job Task No.", ArchJobTaskRecL."Job Task No.");
                        ArchPlanningLineRecL.SetRange("Archieved Version No.", "Archieved Version No.");
                        if ArchPlanningLineRecL.FindSet() then
                            Page.RunModal(50443, ArchPlanningLineRecL);
                    end;
                    Page.RunModal(50443, ArchPlanningLineRecL);

                end;
            }
        }
    }



}

