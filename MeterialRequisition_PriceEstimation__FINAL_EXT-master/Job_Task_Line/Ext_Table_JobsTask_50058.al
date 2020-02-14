tableextension 50060 "Ext Jobs Task" extends "Job Task"
{
    fields
    {
        field(50000; "Task Completed"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            begin
                if "Task Completed" then begin
                    "Completion Date" := Today;
                    "Completed By" := UserId;
                end else
                    if not "Task Completed" then begin
                        Clear("Completed By");
                        Clear("Completion Date");
                    end;

            end;
        }
        field(50001; "Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                JobSetupRecL: Record "Jobs Setup";
                LastCompDayTxtL: Text;

            begin
                JobSetupRecL.Reset();
                JobSetupRecL.Get();
                LastCompDayTxtL := '<-' + JobSetupRecL."Completion Date Calc." + '>';
                if ("Completion Date" < (CALCDATE(LastCompDayTxtL, Today))) then
                    Error('Completation date is more than setup %1    %2 ', (CALCDATE(LastCompDayTxtL, Today)), "Completion Date");


            end;
        }
        field(50002; "Completed By"; Code[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50053; "Version No."; Integer)
        {

        }
        field(50054; "Billable"; Boolean)
        {

        }
    }
}
