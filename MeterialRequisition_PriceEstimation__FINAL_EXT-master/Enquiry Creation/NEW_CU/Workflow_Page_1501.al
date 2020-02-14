pageextension 50448 "Ext Workflow Page" extends Workflow
{
    actions
    {
        addlast(Flow)
        {
            group("Customize Setup")
            {
                action("CodeunitRun")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnAction()
                    begin
                        TestPagee.run;
                        //TestPage1.Run();
                    end;
                }
                action("WF Events Page")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnAction()
                    begin
                        //TestPagee.run;
                        TestPage2.Run();
                    end;
                }
                action("WF responses Page")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnAction()
                    begin
                        //TestPagee.run;
                        TestPage3.Run();
                    end;
                }
                action("Dynamics WF Filter")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnAction()
                    begin
                        //TestPagee.run;
                        TestPage1.Run();
                    end;
                }
            }
        }
    }

    var
        TestPagee: Codeunit InitialiseAllCodeunit;
        TestPage1: Page "Dynamic Request Page Fields";
        TestPage2: Page WorkFLowEvents;
        Testpage3: Page WFResponses;
        IntCU: Codeunit IntiCodeunit;
        ApprovalEntry: Record "Approval Entry";
        subformEnableBoolG: Boolean;
        ReleasedBool: Boolean;
        EditableFalseTrueAllControl: Boolean;

}