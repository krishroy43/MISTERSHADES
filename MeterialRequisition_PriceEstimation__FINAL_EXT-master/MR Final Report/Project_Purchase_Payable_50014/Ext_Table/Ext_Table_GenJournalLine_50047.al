tableextension 50047 "Ext Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; JobNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            trigger
            OnValidate()
            begin
                Validate("Dimension Set ID", CopyFromJobDimensionToReleaseProductionOrder(JobNo));
            end;
        }
        field(50001; JobTaskNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD (JobNo), "Job Task Type" = CONST (Posting));
        }

        field(50050; "Posting Type"; Option)
        {
            OptionMembers = " ",Advance,Running,Retention;
            DataClassification = ToBeClassified;
        }
        field(50051; "Retention Reversal"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // Start 09-07-2019
        field(50052; "Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        // Stop 09-07-2019
        modify("Account No.")
        {
            trigger
            OnAfterValidate()
            begin
                // Start 01-07-2019
                CheckCustomerVATRegNo("Account No.");
                // Stop 01-07-2019
            end;
        }
    }


    // Start 01-07-2019
    procedure CheckCustomerVATRegNo(CustomerNo: code[20])
    var
        CustomerRecL: Record Customer;
    begin
        if "Account Type" = "Account Type"::Customer then begin
            if CustomerRecL.get(CustomerNo) then begin

                if NOT ((CustomerRecL."Customer Posting Group" = 'INDIVIDUAL') OR (CustomerRecL."Customer Posting Group" = 'FOREIGN')) then
                    if CustomerRecL."VAT Registration No." = '' then
                        Error('Please Specify VAT Registration Number.');
            end;
        end;
    end;
    // Stop 01-07-2019

    procedure CopyFromJobDimensionToReleaseProductionOrder(JobNoP: Code[20]): Integer
    var
        DefaultDimensionRecL: Record "Default Dimension";
        DimensionSetEntryRecL: Record "Dimension Set Entry" temporary;
        DimensionValueRecL: Record "Dimension Value";
        DimensionManagementCU: Codeunit DimensionManagement;
    begin
        DefaultDimensionRecL.Reset();
        DefaultDimensionRecL.SetCurrentKey("Table ID", "No.", "Dimension Code");
        DefaultDimensionRecL.SetRange("Table ID", Database::Job);
        DefaultDimensionRecL.SetRange("No.", JobNoP);
        if DefaultDimensionRecL.FindSet() then begin
            repeat
                DimensionSetEntryRecL.Init();
                DimensionSetEntryRecL.Validate("Dimension Code", DefaultDimensionRecL."Dimension Code");
                DimensionSetEntryRecL.Validate("Dimension Value Code", DefaultDimensionRecL."Dimension Value Code");

                DimensionValueRecL.Reset();
                DimensionValueRecL.SetRange("Dimension Code", DefaultDimensionRecL."Dimension Code");
                DimensionValueRecL.SetRange(Code, DefaultDimensionRecL."Dimension Value Code");
                if DimensionValueRecL.FindFirst() then
                    DimensionSetEntryRecL.Validate("Dimension Value ID", DimensionValueRecL."Dimension Value ID");

                if DimensionSetEntryRecL.Insert() then;
            until DefaultDimensionRecL.Next() = 0;
        end;

        exit(DimensionManagementCU.GetDimensionSetID(DimensionSetEntryRecL));


    end;
}

