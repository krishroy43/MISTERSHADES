page 50441 "Archived Job Card"
{
    Caption = 'Archived Job Card';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Prices,WIP,Navigate,Job,Print/Send';
    RefreshOnActivate = true;
    SourceTable = "Archieved Job";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No"; "No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;
                }
                field("Job Type"; "Job Type")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies a short description of the job.';
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = Jobs;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the number of the customer who pays for the job.';

                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the contact person at the customer''s billing address.';
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = Jobs;
                    Importance = Promoted;
                    ToolTip = 'Specifies the name of the customer who pays for the job.';
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = Jobs;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the address of the customer to whom you will send the invoice.';
                }
                field("Advance Amount"; "Advance Amount")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = Jobs;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies an additional line of the address.';
                }
                field("Bill-to County"; "Bill-to County")
                {
                    ApplicationArea = Jobs;
                    QuickEntry = false;
                    ToolTip = 'Specifies the county code of the customer''s billing address.';
                }

                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    ApplicationArea = Jobs;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the postal code of the customer who pays for the job.';
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = Jobs;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the city of the address.';
                }
                field("Bill-to Country/Region Code"; "Bill-to Country/Region Code")
                {
                    ApplicationArea = Jobs;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the country/region code of the customer''s billing address.';
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ApplicationArea = Jobs;
                    Importance = Additional;
                    ToolTip = 'Specifies the name of the contact person at the customer who pays for the job.';
                }
                field("Search Description"; "Search Description")
                {
                    ApplicationArea = Jobs;
                    Importance = Additional;
                    ToolTip = 'Specifies an additional description of the job for searching purposes.';
                }
                field("Person Responsible"; "Person Responsible")
                {
                    ApplicationArea = Jobs;
                    Importance = Promoted;
                    ToolTip = 'Specifies the person at your company who is responsible for the job.';
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies when the job card was last modified.';
                }
                field("Project Manager"; "Project Manager")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the person who is assigned to manage the job.';
                    Visible = JobSimplificationAvailable;
                }

                field("Advance Received"; "Advance Received")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Project Amount (Planned)"; "Project Amount (Planned)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                // field("Advance Amount"; "Advance Amount")
                // {
                //     //Editable = false;
                //     ApplicationArea = All;

                // }
                field("Customer PO No."; "Customer PO No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Po. Date."; "Customer Po. Date.")
                {
                    ApplicationArea = All;
                }
                field("Project Location"; "Project Location")
                {
                    ApplicationArea = All;
                }
                field("Recipients Name"; "Recipients Name")
                {
                    ApplicationArea = All;
                }
                field("Product Type"; "Product Type")
                {
                    ApplicationArea = All;
                }
                field("Contract Ref."; "Contract Ref.")
                {
                    ApplicationArea = All;
                }
                field("Scope Of Work 1"; "Scope Of Work 1")
                {
                    ApplicationArea = All;
                }
                field("Scope Of Work 2"; "Scope Of Work 2")
                {
                    ApplicationArea = All;
                }
                field("Sales Quote"; "Sales Quote")
                {
                    ApplicationArea = All;

                }
                field("Sales Enquiry"; "Sales Enquiry")
                {
                    ApplicationArea = All;
                }

            }
            group("Project Contacts")
            {
                field(Finance; Finance)
                {
                    ApplicationArea = All;

                }
                field("Financer's Name"; finance_Var)
                {
                    ApplicationArea = All;


                }
                field("Site Project manager"; "Site Project manager")
                {
                    ApplicationArea = All;
                }
                field("Site Project Manager's Name"; SiteProjMgr_Var)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Procurement; Procurement)
                {
                    ApplicationArea = All;
                }
                field("Procurement's Name"; Procu_Var)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Quantity Surveyor"; "Quantity Surveyor")
                {
                    ApplicationArea = All;
                }
                field("Quantity Surveyor's Name"; QuiltSur_Var)
                {
                    ApplicationArea = All;
                    Editable = false;

                }

            }
            group("Documents and Approval")
            {
                field(" Material Finalization"; " Material Finalization")
                {
                    ApplicationArea = All;

                }
                field("Phy. and Material Approval"; "Phy. and Material Approval")
                {
                    ApplicationArea = All;

                }
                field("Shop Drawing Approval"; "Shop Drawing Approval")
                {
                    ApplicationArea = All;

                }
                field("Prototype Requested"; "Prototype Requested")
                {
                    ApplicationArea = All;

                }
                field("Proforma Invoice created"; "Proforma Invoice created")
                {
                    ApplicationArea = All;

                }
                field(Standard; "Standard 2")
                {
                    ApplicationArea = All;
                    Caption = 'Standard';

                }
                field("Workflow Status"; "Workflow Status")
                {
                    ApplicationArea = all;
                    Caption = 'Status';
                    Editable = false;

                }
            }
            group(Projects)
            {
                field("Election Method Statement"; "Erection Method Statement")
                {
                    ApplicationArea = All;

                }
                field("Painting Method Statement"; "Painting Method Statement")
                {
                    ApplicationArea = All;

                }
                field("Magnetic Particle Test Report"; "Magnetic Particle Test Report")
                {
                    ApplicationArea = All;

                }
                field("Painting Report DFT"; "Painting Report DFT")
                {
                    ApplicationArea = All;

                }
            }

            group(Productions)
            {
                field("Welding Statement"; "Welding Statement")
                {
                    ApplicationArea = All;

                }
                field("Elcomtr Calibrt. Certi. Paint"; "Elcomtr Calibrt. Certi. Paint")
                {
                    ApplicationArea = All;

                }
            }

            group("Project Completion")
            {
                group("Design \ Quantity Surveyor")
                {
                    field("Approved Drawing"; "Approved Drawing")
                    {
                        ApplicationArea = All;

                    }
                    field("Material Mill Certificate"; "Material Mill Certificat")
                    {
                        ApplicationArea = All;
                        Caption = 'Material Mill Certificate  ';

                    }
                    field("Painting Technical Data"; "Painting Technical Data")
                    {
                        ApplicationArea = All;

                    }
                    field("Operation and Maintnc Manual"; "Operation and Maintnc Manual")
                    {
                        ApplicationArea = All;

                    }
                    field("As Built Drawing"; "As Built Drawing")
                    {
                        ApplicationArea = All;

                    }
                    field("Apprv. Struct. Design Calc."; "Apprv. Struct. Design Calc.")
                    {
                        ApplicationArea = All;

                    }
                    field("Completion date"; "Completion date")
                    {
                        ApplicationArea = All;

                    }
                }

            }



            part(JobTaskLines; "Arch. Job Task Lines Subform")
            {
                ApplicationArea = Jobs;
                Caption = 'Tasks';
                SubPageLink = "Job No." = FIELD ("No."), "Archieved Version No." = field ("Archieved Version No.");
                SubPageView = SORTING ("Job Task No.", "Archieved Version No.") ORDER(Ascending);
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
                    ArchPlanningLineRecL.Reset();
                    ArchPlanningLineRecL.SetRange("Job No.", "No.");
                    ArchPlanningLineRecL.SetRange("Archieved Version No.", "Archieved Version No.");
                    if ArchPlanningLineRecL.FindSet() then
                        Page.RunModal(50443, ArchPlanningLineRecL);

                end;
            }
        }
    }




    var

        JobSimplificationAvailable: Boolean;
        NoFieldVisible: Boolean;
        IsCountyVisible: Boolean;
        finance_Var: Text[100];
        SiteProjMgr_Var: Text[100];
        QuiltSur_Var: Text[100];
        Procu_Var: Text[100];

    trigger
OnOpenPage()
    var
        ContactRecG: Record Contact;
        CustLedgerEntryRecL: Record "Cust. Ledger Entry";
        CustLedgerEntryPage: page "Customer Ledger Entries";
        AmountSumDecL: Decimal;
    begin

        // Stop 17-07-2019
        // Start 23-07-2019
        if "No." <> '' then begin

            if ContactRecG.get(Finance) then
                finance_Var := ContactRecG.Name;

            if ContactRecG.get("Site Project manager") then
                SiteProjMgr_Var := ContactRecG.Name;

            if ContactRecG.get("Quantity Surveyor") then
                QuiltSur_Var := ContactRecG.Name;

            if ContactRecG.get(Procurement) then
                Procu_Var := ContactRecG.Name;
        end;
    end;


}

