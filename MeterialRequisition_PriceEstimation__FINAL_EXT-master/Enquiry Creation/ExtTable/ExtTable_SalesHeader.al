tableextension 50028 "Ext. Sales Header" extends "Sales Header"
{
    fields
    {
        field(50651; "Order Accepted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50505; "Sales Transaction Type"; Option)
        {
            OptionMembers = " ",Dispatch,"Proforma Invoice";
        }
        // field(50001; "Over Head %"; Decimal)
        // {

        field(50506; "Progressive Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        // }
        // field(50002; "Margin %"; Decimal)
        // {

        // }
        // field(50003; "Version No."; Integer)
        // {
        //     InitValue = 1;
        //     Editable = false;

        // }
        // field(50004; "Scope Of Work"; Code[20])
        // {
        //     TableRelation = Opportunity;


        // }
        // field(50005; "Product Type"; Code[20])
        // {

        // }
        // field(50006; "Location Details"; Code[20])
        // {

        // }
        // field(50007; "Quote Validity"; Date)
        // {

        // }
        // field(50008; "Warranty"; Boolean)
        // {

        // }
        // field(50009; "Insurance"; Boolean)
        // {

        // }
        // field(50010; "Estimation Version No."; Integer)
        // {
        //     InitValue = 1;
        // }
        // Add changes to table fields here
        field(50000; "Dispatch Type"; Option)
        {
            //As per Ankur guide line
            //OptionMembers = " ","Partial","Final";
            OptionMembers = "Partial","Final";
        }

        field(50013; "Scope Of Work 1"; Text[100])
        {
            Caption = 'Scope Of Work';

        }
        field(50014; "Scope Of Work 2"; Text[100])
        {

        }
        field(50001; "Over Head %"; Decimal)
        {


        }
        field(50002; "Margin %"; Decimal)
        {

        }
        field(50003; "Version No."; Integer)
        {
            InitValue = 1;
            Editable = false;

        }
        field(50004; "Scope Of Work"; Code[20])
        {
            TableRelation = Opportunity;


        }
        field(50005; "Product Type"; Code[250])
        {
            //TableRelation = "Product Type";
            trigger
           OnValidate()
            begin
                if Rec."Product Type" = '' then
                    Rec."Product Type" := xRec."Product Type";
            end;

            trigger
            OnLookup()
            var
                ProductTypeListPageL: Page "Product Type List";
                ProductTypeRecL: Record "Product Type";
                ProductTypeCodeL: Code[250];
                ProductTypeTextL: Text;
                Ln: Integer;
            begin
                Clear(ProductTypeListPageL);
                Clear(ProductTypeCodeL);
                Clear(ProductTypeTextL);
                ProductTypeRecL.Reset();
                if "Product Type" <> ' ' then
                    ProductTypeListPageL.SetVal("Product Type");
                ProductTypeRecL.SetRange("Fabric Type", false);
                ProductTypeListPageL.SetRecord(ProductTypeRecL);
                ProductTypeListPageL.SetTableView(ProductTypeRecL);
                ProductTypeListPageL.LookupMode(true);
                if ProductTypeListPageL.RunModal() = Action::LookupOK then begin
                    ProductTypeRecL.Reset();
                    ProductTypeRecL.SetRange(Select, true);
                    if ProductTypeRecL.FindSet() then begin
                        repeat
                            ProductTypeCodeL += ProductTypeRecL.Code + '|';
                        until ProductTypeRecL.Next() = 0;
                    end;
                    Ln := StrLen(ProductTypeCodeL);
                    if Ln > 0 then
                        ProductTypeTextL := DelStr(ProductTypeCodeL, Ln, Ln);
                end
                else
                    exit;

                Validate("Product Type", ProductTypeTextL);
                Modify();
                ProductTypeRecL.Reset();
                ProductTypeRecL.ModifyAll(Select, false);

            end;
        }
        field(50006; "Location Details"; Text[250])
        {
            Caption = 'Project Location';
        }
        field(50007; "Quote Validity"; Date)
        {

        }
        field(50008; "Warranty"; Boolean)
        {

        }
        field(50009; "Insurance"; Boolean)
        {

        }
        field(50010; "Estimation Version No."; Integer)
        {
            InitValue = 1;
        }
        field(50011; "Work Done"; Decimal)
        {

        }
        modify("Opportunity No.")
        {

            trigger
            OnAfterValidate()
            var
                OpprtunityRecL: Record Opportunity;
            begin
                if "Opportunity No." <> '' then
                    if OpprtunityRecL.Get("Opportunity No.") then begin
                        Validate("Scope Of Work 1", OpprtunityRecL.Description);
                        Validate("Scope Of Work 2", OpprtunityRecL."Scope Of Work 2");
                    end
                    else begin
                        Clear("Scope Of Work 1");
                        Clear("Scope Of Work 2");
                    end;



            end;
        }

        field(50101; "Job No."; Code[20])
        {
            TableRelation = Job;
            trigger
            OnValidate()
            var
                JobsRecL: Record Job;
            begin
                if "Job No." <> xRec."Job No." then
                    ClearVarialbe();

                JobsRecL.Reset();
                if JobsRecL.Get("Job No.") then begin
                    "Job description" := JobsRecL.Description;
                    Modify();
                end;
            end;
        }
        field(50102; "Job description"; Text[150])
        {
            Editable = false;
        }
        field(50103; "Job Task No"; Code[20])
        {
            //  TableRelation = "Job Task"."Job Task No." where ("Job No." = field ("Job No."));
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."), "Job Task Type" = const(Posting));
            trigger
            OnValidate()
            var
                JobTaskRecL: Record "Job Task";
            begin
                JobTaskRecL.Reset();
                if JobTaskRecL.Get("Job No.", "Job Task No") then begin
                    "Job Task Description" := JobTaskRecL.Description;
                    Modify();
                end;
                if "Job Task No" = '' then
                    Clear("Job Task Description");
            end;
        }
        field(50104; "Job Task Description"; Text[150])
        {
            Editable = false;
        }
        // Start 01-07-2019
        field(50105; "Project Description"; Text[50])
        {

        }
        field(50106; "Consultant"; Code[80])
        {

        }
        // Stop 01-07-2019


        field(50107; "Fabric Type"; Code[250])
        {

            //TableRelation = "Product Type" where ("Fabric Type" = const (true), Code = field ("Fabric Type"));
            trigger
            OnValidate()
            begin
                if Rec."Fabric Type" = '' then
                    Rec."Fabric Type" := xRec."Fabric Type";
            end;

            trigger
            OnLookup()
            var
                FabricTypeListPageL: Page "Fabric Type";
                FabricTypeRecL: Record "Product Type";
                FabricTypeCodeL: Code[250];
                FabricTypeTextL: Text;
                Ln: Integer;
            begin
                Clear(FabricTypeListPageL);
                Clear(FabricTypeCodeL);
                Clear(FabricTypeTextL);

                FabricTypeRecL.Reset();
                if "Fabric Type" <> ' ' then
                    FabricTypeListPageL.SetVal("Fabric Type");

                FabricTypeRecL.SetRange("Fabric Type", true);
                FabricTypeListPageL.SetRecord(FabricTypeRecL);
                FabricTypeListPageL.SetTableView(FabricTypeRecL);
                FabricTypeListPageL.LookupMode(true);
                if FabricTypeListPageL.RunModal() = Action::LookupOK then begin
                    FabricTypeRecL.Reset();
                    FabricTypeRecL.SetRange(Select, true);
                    if FabricTypeRecL.FindSet() then begin
                        repeat
                            FabricTypeCodeL += FabricTypeRecL.Code + '|';
                        until FabricTypeRecL.Next() = 0;
                    end;
                    Ln := StrLen(FabricTypeCodeL);
                    if Ln > 0 then
                        FabricTypeTextL := DelStr(FabricTypeCodeL, Ln, Ln);
                end
                else
                    exit;
                //Clear("Fabric Type");
                Validate("Fabric Type", FabricTypeTextL);
                Modify();
                FabricTypeRecL.Reset();
                FabricTypeRecL.ModifyAll(Select, false);
            end;
        }
        // Stop 27-06-2019
        field(50108; "Dispatch Note"; Boolean)
        {
        }
        field(50109; "Delivery Location"; Text[250])
        {

        }
        field(50205; "Under Warranty"; Boolean)
        {
        }
        // Start Fields Created for Sales Quote Report
        field(50110; "Client"; Text[100])
        {

        }

        // Stop Fields Created for Sales Quote Report

        // Dispatch note
        modify("No.")
        {
            trigger
            OnBeforeValidate()
            begin

                "Dispatch Note" := true;
                Modify();
                Message('Boolean true');
            end;
        }
        // Disptach note
    }


    var
        myInt: Integer;
        salesHeader: Record "Sales Header";

    procedure ClearVarialbe()
    begin
        clear("Job description");
        //clear("Job No.");
        Clear("Job Task No");
        Clear("Job Task Description");

    end;
    // Start 19-07-2019
    trigger
    OnAfterInsert()
    var
        StdTermConditionDescRecL: Record "Std Term & Condition Descp";
        SalesCommnetLineRecL: Record "Sales Comment Line";
        NewLineNoL: Integer;
    begin
        // NewLineNoL := 10000;
        // if "No." <> xRec."No." then begin
        //     StdTermConditionDescRecL.Reset();
        //     StdTermConditionDescRecL.SetRange("Document Type", StdTermConditionDescRecL."Document Type"::"Sales Quote");
        //     if StdTermConditionDescRecL.FindSet() then
        //         repeat
        //             SalesCommnetLineRecL.Validate("Document Type", "Document Type");
        //             SalesCommnetLineRecL.Validate("No.", "No.");
        //             SalesCommnetLineRecL.Validate("Line No.", NewLineNoL);
        //             SalesCommnetLineRecL.Date := Today();
        //             SalesCommnetLineRecL.Validate("Term/Condition", StdTermConditionDescRecL."Term/Condition");
        //             SalesCommnetLineRecL.Validate(Comment, StdTermConditionDescRecL.Description);
        //             SalesCommnetLineRecL.Insert();
        //             NewLineNoL += 10000;
        //         until StdTermConditionDescRecL.Next() = 0;
        //end;
    end;
    // Stop 19-07-209






    //Custom Functions to resolve the errors 
    procedure CheckItemAvailabilityInLines_Custom()
    var
        SalesLine: Record "Sales Line";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
    begin
        SalesLine.SETRANGE("Document Type", "Document Type");
        SalesLine.SETRANGE("Document No.", "No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("No.", '<>%1', '');
        SalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF SalesLine.FINDSET THEN
            REPEAT
                IF ItemCheckAvail.SalesLineCheck(SalesLine) THEN
                    ItemCheckAvail.RaiseUpdateInterruptedError;
            UNTIL SalesLine.NEXT = 0;
    end;


    procedure CheckCreditMaxBeforeInsert_Custom()
    var
        SalesHeader: Record "Sales Header";
        ContBusinessRelation: Record "Contact Business Relation";
        Cont: Record Contact;
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        Cust: Record Customer;
    begin
        IF (GetFilterCustNo <> '') OR ("Sell-to Customer No." <> '') THEN BEGIN
            IF "Sell-to Customer No." <> '' THEN
                Cust.GET("Sell-to Customer No.")
            ELSE
                Cust.GET(GetFilterCustNo);
            IF Cust."Bill-to Customer No." <> '' THEN
                SalesHeader."Bill-to Customer No." := Cust."Bill-to Customer No."
            ELSE
                SalesHeader."Bill-to Customer No." := Cust."No.";
            CustCheckCreditLimit.SalesHeaderCheck(SalesHeader);
        END ELSE
            IF GetFilterContNo <> '' THEN BEGIN
                Cont.GET(GetFilterContNo);
                IF ContBusinessRelation.FindByContact(ContBusinessRelation."Link to Table"::Customer, Cont."Company No.") THEN BEGIN
                    Cust.GET(ContBusinessRelation."No.");
                    IF Cust."Bill-to Customer No." <> '' THEN
                        SalesHeader."Bill-to Customer No." := Cust."Bill-to Customer No."
                    ELSE
                        SalesHeader."Bill-to Customer No." := Cust."No.";
                    CustCheckCreditLimit.SalesHeaderCheck(SalesHeader);
                END;
            END;
    end;

    procedure GetFilterCustNo(): Code[20]
    var
        MinValue: Code[20];
        MaxValue: Code[20];
    begin
        IF GETFILTER("Sell-to Customer No.") <> '' THEN BEGIN
            IF TryGetFilterCustNoRange(MinValue, MaxValue) THEN
                IF MinValue = MaxValue THEN
                    EXIT(MaxValue);
        END;
    end;

    procedure GetFilterContNo(): Code[20]
    var
        myInt: Integer;
    begin
        IF GETFILTER("Sell-to Contact No.") <> '' THEN
            IF GETRANGEMIN("Sell-to Contact No.") = GETRANGEMAX("Sell-to Contact No.") THEN
                EXIT(GETRANGEMAX("Sell-to Contact No."));
    end;

    procedure TryGetFilterCustNoRange(VAR MinValue: Code[20]; VAR MaxValue: Code[20]): Boolean
    var
        myInt: Integer;
    begin
        MinValue := GETRANGEMIN("Sell-to Customer No.");
        MaxValue := GETRANGEMAX("Sell-to Customer No.");
    end;


}
