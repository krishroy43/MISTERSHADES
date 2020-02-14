report 50007 "JCC HOC Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    //RDLCLayout = 'RDL_Files/JCCHOCJOBS.rdl';
    Caption = 'JCC and HOC';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Job_; Job)
        {
            RequestFilterFields = "No.";

            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Description; Description) { }
            column(Contract_Ref_; "Contract Ref.") { }
            column(Project_Location; "Project Location") { }
            column(Customer_PO_No_; "Customer PO No.") { }
            column(Customer_Po__Date_; "Customer Po. Date.") { }
            column(No_; "No.") { }
            //column(Ending_Date; "Ending Date") { }
            column(Ending_Date; FORMAT("Ending Date", 10, '<Day,2>/<Month,2>/<year,4>')) { }
            column(Scope_Of_Work_1; "Scope Of Work 1") { }
            column(Scope_Of_Work_2; "Scope Of Work 2") { }
            column(Comp_Logo; CompInfoRec.Picture) { }
            column(Comp_Name; CompInfoRec.Name) { }
            column(Project_Manager; "Project Manager") { }

            column(Comp_Add1; CompInfoRec.Address) { }
            column(Comp_Add2; CompInfoRec."Address 2") { }
            column(Comp_City; CompInfoRec.City) { }
            column(Comp_Country; CompInfoRec."Country/Region Code") { }
            column(Comp_Phone; CompInfoRec."Phone No.") { }
            column(Comp_mail; CompInfoRec."E-Mail") { }
            column(Comep_Home_Page; CompInfoRec."Home Page") { }
            column(Comp_Fax; CompInfoRec."Fax No.") { }
            column(CustomerDegCap; CustomerDegCap) { }
            column(ContactRecG_name; ContactRecG.Name) { }
            column(CompanyDegCap_ProjectManager; CompanyDegCap) { }
            column(UserSetupRecG_FullNAme; UserSetupRecG."Full Name") { }
            // Start 16-07-2019
            column(Completion_date; "Completion date") { }
            // Stop 16-07-2019


            trigger
            OnAfterGetRecord()
            var
            begin
                //=====================================================================
                if (SelectCustomerResG = SelectCustomerResG::" ") then
                    Error('Please Select Customer Option');

                case SelectCustomerResG of
                    SelectCustomerResG::Finance:
                        begin
                            ProjectContactCode := Job_.Finance;
                        end;
                    SelectCustomerResG::Procurement:
                        begin
                            ProjectContactCode := Job_.Procurement;
                        end;
                    SelectCustomerResG::"Quantity Surveyor":
                        begin
                            ProjectContactCode := Job_."Quantity Surveyor";
                        end;
                    SelectCustomerResG::"Site Project manager":
                        begin
                            ProjectContactCode := Job_."Site Project manager";
                        end;
                end;
                //=======================================================================
                if (SelectCustomerResG = SelectCustomerResG::Finance) then begin
                    ContactRecG.get(ProjectContactCode);
                    CustomerDegCap := JobRecG.FieldCaption(JobRecG.Finance);
                end
                else
                    if (SelectCustomerResG = SelectCustomerResG::"Site Project manager") then begin
                        ContactRecG.get(ProjectContactCode);
                        CustomerDegCap := JobRecG.FieldCaption(JobRecG."Site Project manager");
                    end
                    else
                        if (SelectCustomerResG = SelectCustomerResG::Procurement) then begin
                            ContactRecG.get(ProjectContactCode);
                            CustomerDegCap := JobRecG.FieldCaption(JobRecG.Procurement);
                        end
                        else
                            if (SelectCustomerResG = SelectCustomerResG::"Quantity Surveyor") then begin
                                ContactRecG.get(ProjectContactCode);
                                CustomerDegCap := JobRecG.FieldCaption(JobRecG."Quantity Surveyor");
                            end
                            else
                                error('Please Select Atleat one from them');

                CompanyDegCap := Job_.FieldCaption("Project Manager");
                // Start 01-07-2019
                UserSetupRecG.Reset();
                UserSetupRecG.SetRange("User Name", "Project Manager");
                if UserSetupRecG.FindFirst() then;

                // Stop 01-07-2019

            end;

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Customer Representative")
                {
                    field("Customer Option"; SelectCustomerResG)
                    {
                        ApplicationArea = All;
                        trigger
                        OnValidate()
                        begin
                            /*
                            if (SelectCustomerResG = SelectCustomerResG::" ") then
                                Error('Please Select Customer Option');

                            case SelectCustomerResG of
                                SelectCustomerResG::Finance:
                                    begin
                                        ProjectContactCode := Job_.Finance;
                                    end;
                                SelectCustomerResG::Procurement:
                                    begin
                                        ProjectContactCode := Job_.Procurement;
                                    end;
                                SelectCustomerResG::"Quantity Surveyor":
                                    begin
                                        ProjectContactCode := Job_."Quantity Surveyor";
                                    end;
                                SelectCustomerResG::"Site Project manager":
                                    begin
                                        ProjectContactCode := Job_."Site Project manager";
                                    end;
                            end;
                            */
                        end;
                    }
                    field("Project Contact"; ProjectContactCode)
                    {
                        ApplicationArea = All;
                        Visible = false;
                        trigger
                        OnLookup(var Text: Text): Boolean
                        var
                            ContBusinessRelation: Record "Contact Business Relation";
                            Cont: Record Contact;
                            TempCust: Record Customer temporary;
                            Cust: Record Customer;
                        begin
                            /*
                          if (SelectCustomerResG = SelectCustomerResG::" ") OR (ProjectContactCode = ' ') then
                              Error('Please Select Customer Option');

                          JobRecG.SetRange("No.", Job_.GetFilter("No."));
                          if JobRecG.FindFirst() then begin
                              IF (JobRecG."Bill-to Customer No." <> '') AND Cont.GET(JobRecG."Bill-to Contact No.") THEN
                                  Cont.SETRANGE("Company No.", Cont."Company No.")
                              ELSE
                                  IF Cust.GET(JobRecG."Bill-to Customer No.") THEN BEGIN
                                      IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, JobRecG."Bill-to Customer No.") THEN
                                          Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                                  END ELSE
                                      Cont.SETFILTER("Company No.", '<>%1', '''');

                              IF JobRecG."Bill-to Contact No." <> '' THEN
                                  IF Cont.GET(JobRecG."Bill-to Contact No.") THEN;
                              IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                                  //xRec := Rec;
                                  ProjectContactCode := Cont."No.";
                                  Text := Cont."No.";
                              END;                            
                      end;
                      */
                        end;

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
    }
    labels
    {
        ClientNameLBL = 'Client Name :';
        ProjectNameLBL = 'Project :';
        ContractRefLBL = 'Contract Ref. :';
        AgreeNoPONoLBL = 'Agreement No. / P.O No. :';
        AgreeDatePODateLBL = 'Agreement Date / P.O Date :';
        JobNoLBL = 'Job# :';
        JobCompleteDateLBL = 'Job Completed Date :';
        ScopeofWorkLBL = 'Scope Of Work :';
        ClientResLBL = 'Client Representative :';
        SignNStampLBL = 'Signature & Stamp :';
        NameLBL = 'Name ';
        DesignationLBL = 'Designation';
        CommentLBL = 'Comments :';
        ReportHeaderLBL = 'JOB COMPLETION / HANDOVER CERTIFICATE';
        ProjectLocationLBL = 'Location :';

        ReportDeclarationLBL = 'We hereby certify that this structure or service has been installed in accordance with the predetermined plan, approved shop drawing in line with manufactures instruction, industry guidelines and best practice and for the purpose stated.It is safe to use and in suitable condition to be handed over to the client';

    }
    trigger OnPreReport();
    begin
        CompInfoRec.GET;
        CompInfoRec.CALCFIELDS(Picture);

    end;

    var
        CompInfoRec: Record "Company Information";
        ContactRecG: Record Contact;
        CompanyDegCap: Code[35];
        CompDegNameCodeG: Code[50];
        CustomerDegCap: Code[35];
        JobRecG: Record Job;
        SelectCustomerResG: Option " ","Finance","Site Project manager","Procurement","Quantity Surveyor";
        FinBoolG: Boolean;
        ProjectContactCode: Code[50];
        JobNumberCode: Code[20];
        UserSetupRecG: Record User;



}