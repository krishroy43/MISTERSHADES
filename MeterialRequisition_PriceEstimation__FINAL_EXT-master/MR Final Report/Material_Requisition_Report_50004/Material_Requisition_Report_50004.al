report 50004 "Material Requisition"

{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    //RDLCLayout = 'MaterilRequisitionJob.rdlc';
    Caption = 'Requisition  Order Report';

    dataset
    {
        dataitem(MaterialReqHeader; "Material Requisition Header")
        {
            RequestFilterFields = "Requisition No.";
            DataItemTableView = sorting ("Requisition No.");
            column(Requisition_No_; "Requisition No.") { }
            column(Creation_Date_and_Time; format("Creation Date and Time", 10, '<Day,2>/<Month,2>/<Year4>')) { }
            column(Job_No_; "Job No.") { }
            column(Comp_Logo; CompInfoRec.Picture) { }
            column(Comp_Name; CompInfoRec.Name) { }
            column(Comp_Add1; CompInfoRec.Address) { }
            column(Comp_Add2; CompInfoRec."Address 2") { }
            column(SENDERID; ApprovalEntryRecG."Sender ID") { }
            column(APPROVERID; ApprovalEntryRecG."Approver ID") { }
            column(JobName; JobRecG.Description) { }
            column(AppIDFullName; UserRec2G."Full Name") { }
            column(SenderIDFullName; UserRecG."Full Name") { }

            dataitem(MaterialRequLine; "Material Requisition Line")
            {
                DataItemLink = "Document No." = field ("Requisition No.");
                column(No_; "No.") { }
                column(Quantity_needed; "Quantity needed") { }
                column(DescriptionTextG; DescriptionTextG) { }
                column(Type; Type) { }
                column(Unit_of_Measure; "Unit of Measure") { }

                trigger
                OnAfterGetRecord()
                var
                    ItemRecL: Record Item;
                    GLAccountRecL: Record "G/L Account";
                    ResourceRecL: Record Resource;
                    TextRecL: Record "Standard Text";
                begin
                    if type = type::Item then begin
                        if ItemRecL.Get("No.") then
                            DescriptionTextG := ItemRecL.Description;
                    end
                    else
                        if type = type::"G/L Account" then begin
                            if GLAccountRecL.Get("No.") then
                                DescriptionTextG := GLAccountRecL.Name;
                        end
                        else
                            if type = type::Resource then begin
                                if ResourceRecL.get("No.") then
                                    DescriptionTextG := ResourceRecL.Name;
                            end
                            else begin
                                if TextRecL.get("No.") then
                                    DescriptionTextG := TextRecL.Description;
                            end;
                end;
            }
            // Start Mater Dataitem Trigger 
            trigger
            OnAfterGetRecord()
            var
            begin
                UserRec2G.Reset();
                UserRecG.Reset();
                JobRecG.Reset();
                ApprovalEntryRecG.Reset();
                ApprovalEntryRecG.SETFILTER("Table ID", '%1', DATABASE::"Material Requisition Header");
                ApprovalEntryRecG.SETFILTER("Record ID to Approve", '%1', MaterialReqHeader.RecordId);
                ApprovalEntryRecG.SETRANGE("Related to Change", FALSE);
                if ApprovalEntryRecG.FindLast() then
                    ;
                UserRecG.SetRange("User Name", ApprovalEntryRecG."Sender ID");
                if UserRecG.FindFirst() then
                    ;
                UserRec2G.SetRange("User Name", ApprovalEntryRecG."Approver ID");
                if UserRec2G.FindFirst() then
                    ;
                if JobRecG.get("Job No.") then
                    ;
            end;
            // Start Mater Dataitem Trigger 
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    // ApplicationArea = All;

                    //}
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
        ReportHeaderLbl = 'Material Requisition [Job]';
        RequisitionNoLbl = 'Requisition No.';
        JobNoLbl = 'Job No.';
        DateLbl = 'Date';
        RequestedByLbl = 'Requested By';
        SrNoLbl = 'Sr. No.';
        ItemCodeLbl = 'Item Code';
        DescriptionLbl = 'Descrition';
        BOQLlb = 'BOQ';
        UnitLbl = 'Unit';
        RequestedLbl = 'Requested';
        ApprovedLbl = 'Approved';
        PreparedByLbl = 'Prepared By';
        AuthorisedByLbl = 'Authorised By';
        PrintOnLbl = 'Print On :';
    }


    var
        myInt: Integer;
        CompInfoRec: Record "Company Information";
        DescriptionTextG: Text[200];
        ApprovalEntryRecG: Record "Approval Entry";
        JobRecG: Record Job;
        UserRecG: Record user;
        UserRec2G: Record User;


    trigger OnPreReport();
    begin
        CompInfoRec.GET;
        CompInfoRec.CALCFIELDS(Picture);
    end;
}