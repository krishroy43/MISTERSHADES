table 50011 "Estimation Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Quote No."; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Estimation No."; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Estimation Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Version No."; Integer)
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Estimation Archieve Header";

        }
        field(14; "Estimated Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger
          OnValidate()
            begin
                if Rec.Status = Status::Released then
                    Error('Please reopen the record');
            end;

        }
        field(15; "Total Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            begin
                if Rec.Status = Status::Released then
                    Error('Please reopen the record');
            end;

        }
        field(16; "Rate per Sq.M"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(17; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //if Rec.Status = Status::Open then beginend;
            end;

        }
        field(18; "Version No. Disp"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //if Rec.Status = Status::Open then beginend;
            end;

        }
        field(19; "Estimated Value"; Decimal)
        { }
        field(20; "Total Value"; Decimal)
        { }


    }

    keys
    {
        key(PK; "Quote No.", "Version No. Disp")
        {
            Clustered = true;
        }
    }

    var
        SalesandReceiSetupRec: Record "Sales & Receivables Setup";

    trigger OnInsert()
    var
        EstimationHdrRec: Record "Estimation Header";
    begin
        InitInsert();

        EstimationHdrRec.Reset();
        EstimationHdrRec.SetRange("Quote No.", "Quote No.");
        EstimationHdrRec.SetFilter("Estimation No.", '<>%1', ' ');
        if EstimationHdrRec.findfirst then begin
            if EstimationHdrRec."Version No." = 0 then
                EstimationHdrRec."Version No." := 1;
            EstimationHdrRec.Modify();

        end;

    end;

    trigger OnModify()
    var
        //RecSalesHeader: Record "Sales Header";
        EstimationHdrRec: Record "Estimation Header";
    begin
        if Rec.Status = Status::Released then
            Error('Please reopen the record');
        /*
        RecSalesHeader.RESET;
        RecSalesHeader.SetRange("Document Type", RecSalesHeader."Document Type"::Quote);
        RecSalesHeader.SetRange("No.", Rec."Quote No.");
        if RecSalesHeader.findfirst then begin
            RecSalesHeader."Version No." := Rec."Version No.";
            RecSalesHeader.modify;
        end;
*/
        EstimationHdrRec.Reset();
        EstimationHdrRec.SetRange("Quote No.", "Quote No.");
        EstimationHdrRec.SetFilter("Estimation No.", '<>%1', ' ');
        if EstimationHdrRec.findfirst then begin
            if EstimationHdrRec."Version No." = 0 then
                EstimationHdrRec."Version No." := 1;
            EstimationHdrRec.Modify();

        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure TestNoSeries()
    begin
        SalesandReceiSetupRec.Reset();
        SalesandReceiSetupRec.Get();
        SalesandReceiSetupRec.TestField("Estimation No.");
    end;

    procedure InitInsert()
    var
        NoSeriesMgtCUL: Codeunit NoSeriesManagement;
    begin
        SalesandReceiSetupRec.Reset();
        SalesandReceiSetupRec.Get();
        if "Estimation No." = '' then begin
            TestNoSeries();
            NoSeriesMgtCUL.InitSeries(SalesandReceiSetupRec."Estimation No.", xRec."Estimation No.", Today(), "Estimation No.", SalesandReceiSetupRec."Estimation No.");
        end;
    end;

}