page 50211 SiteStatusOpen
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Site Status Report";
    Caption = 'Site and Production Status';
    // SourceTableView = where (Status = filter (Open), Status = filter (''));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(DocumetNo; "Documet No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                { ApplicationArea = All; }
                field(Description2; Description2)
                {
                    ApplicationArea = All;

                }
                field("Job No."; "Job No.")
                { ApplicationArea = All; }
                field("Job Description"; "Job Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Task No."; "Job Task No.")
                { ApplicationArea = All; }
                field("Job task Description"; "Job task Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(User; User)
                { ApplicationArea = All; }
                // field(Resource; Resource)
                //{ ApplicationArea = All; }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Planned Date"; "Planned Date")
                {
                    ApplicationArea = All;
                }
                field(Approver; Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Release)
            {
                ApplicationArea = All;
                Enabled = ApprovableVisiableG;
                trigger OnAction()
                begin
                    //TestField("Job No.");
                    CurrPage.SetSelectionFilter(Rec);
                    If Rec.FindFirst then begin
                        Rec2.Copy(Rec);
                        Rec2.Status := Rec2.Status::Released;
                        Rec2.Modify;
                        Rec2.INITINSERT_R("Documet No");
                    end;
                end;
            }
            action("Approve")
            {
                ApplicationArea = All;
                Image = Approval;
                trigger
                OnAction()
                var
                begin
                    TestField("Job No.");
                    if Not Approve then begin
                        Approve := true;
                        Modify();
                    end;

                end;
            }
        }
    }
    trigger
       OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    trigger
    OnInit()

    begin
        Date := Today;
        // Status := Status::Open;
    end;

    trigger
    OnAfterGetRecord()
    begin
        RefreshPAge();
    end;

    trigger
        OnAfterGetCurrRecord()
    begin
        RefreshPAge();
        Status := Status::Open;
        if Approve then
            ApprovableVisiableG := true
        else
            ApprovableVisiableG := false;
    end;

    trigger
    OnOpenPage()
    begin
        RefreshPAge();
        Status := Status::Open;


        if Approve then
            ApprovableVisiableG := true
        else
            ApprovableVisiableG := false;

    end;

    var
        //myInt: Integer;
        RecPage: Page SiteStatusOpen;
        Rec2: Record "Site Status Report";
        ApprovableVisiableG: Boolean;

    procedure RefreshPAge()
    begin
        SetRange(Status, Status::Open);
    end;

}