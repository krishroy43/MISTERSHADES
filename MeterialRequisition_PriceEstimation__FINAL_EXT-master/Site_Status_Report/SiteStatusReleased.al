page 50212 "Site Status Released"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Site Status Report";
    Caption = 'Site and Production Status - Relesed';
    SourceTableView = where (Status = filter (Released));
    Editable = false;
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
                    Caption = 'Pre-Assigned Doc No.';
                }
                field("Site Status -Released Doc No."; "Site Status -Released Doc No.")
                { ApplicationArea = All; }
                field(Description; Description)
                { ApplicationArea = All; }
                field(Description2; Description2)
                { ApplicationArea = All; }
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
                field(Resource; Resource)
                { ApplicationArea = All; }
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
            action("Open Documen")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    If Rec.FindFirst then begin
                        Rec2.Copy(Rec);
                        Rec2.Status := Rec2.Status::Open;
                        Rec2.Modify;
                    end;
                end;
            }
            action(Reopen)
            {
                ApplicationArea = All;
                //RunObject = page SiteStatusOpen;
                //RunPageLink = "Documet No" =field("Documet No");
                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    If Rec.FindFirst then begin
                        Rec2.Copy(Rec);
                        Rec2.Status := Rec2.Status::Open;
                        Rec2.Modify;
                        Commit();
                        PAGE.RunModal(50211, Rec2);

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
        Status := Status::Released;
    end;

    trigger
    OnAfterGetCurrRecord()
    begin
        RefreshPAge();
    end;

    trigger
    OnOpenPage()
    begin
        RefreshPAge();

    end;

    var
        myInt: Integer;
        Rec2: Record "Site Status Report";

        OpenRec: Page SiteStatusOpen;



    procedure RefreshPAge()
    begin
        SetRange(Status, Status::Released);
    end;
}