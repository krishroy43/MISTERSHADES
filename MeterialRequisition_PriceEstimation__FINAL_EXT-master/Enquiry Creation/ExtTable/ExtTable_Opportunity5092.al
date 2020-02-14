tableextension 50000 "Ext. Opportunity" extends Opportunity
{

    // Start Adding Fields
    fields
    {
        field(50000; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            trigger
            OnValidate()
            var
                CustRecL: Record Customer;
                SalesPersonRecL: Record "Salesperson/Purchaser";

            begin
                SalesPersonRecL.Reset();
                if CustRecL.Get("Customer No.") then begin
                    //"Contact Name" := CustRecL.Name;
                    "Customer Name" := CustRecL.Name;
                    if SalesPersonRecL.Get(CustRecL."Salesperson Code") then begin
                        "Salesperson Code" := CustRecL."Salesperson Code";
                        // "Salesperson Name" := SalesPersonRecL.Name;
                    end;

                end
            end;
        }
        field(50001; "Source of Enquiry"; Option)
        {
            OptionMembers = " ","Advertisement Call","Social Networking","Cold Calling","Staff Member","Regular Customer",Mail,"Online Form","Online Chat";
        }
        field(50002; "Person in charge"; Code[20])
        {
            //TableRelation = Contact where( "No."=field());

            trigger
            OnLookup()
            var
                ContactRecL: Record Contact;
                ContactListPgL: Page "Contact List";
                CustomerRecL: Record Customer;
                // Start
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            // Stop 
            begin
                ContactRecL.Reset();
                Clear(ContactListPgL);
                CustomerRecL.Reset();

                if "Lead Type" = "Lead Type"::Customer then begin
                    CustomerRecL.Get("Customer No.");
                    IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Customer No.") THEN
                        Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.")
                    ELSE
                        Cont.SETRANGE("No.", '');

                    IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                        xRec := Rec;
                        "Person in charge" := Cont."No.";
                    END;
                    // end;
                    // // // if CustomerRecL.Get("Customer No.") then begin
                    // // //     ContactRecL.SetRange("No.", CustomerRecL."Primary Contact No.");
                    // // //     ContactListPgL.SetRecord(ContactRecL);
                    // // //     ContactListPgL.SetTableView(ContactRecL);
                    // // //     ContactListPgL.LookupMode(true);
                    // // //     if ContactListPgL.RunModal = Action::LookupOK then begin
                    // // //         ContactListPgL.GetRecord(ContactRecL);
                    // // //         "Person in charge" := ContactRecL."No.";
                    // // //     end;
                    // // // end;
                end
                else begin
                    ContactListPgL.SetRecord(ContactRecL);
                    ContactListPgL.SetTableView(ContactRecL);
                    ContactListPgL.LookupMode(true);
                    if ContactListPgL.RunModal = Action::LookupOK then begin
                        ContactListPgL.GetRecord(ContactRecL);
                        "Person in charge" := ContactRecL."No.";
                    end;
                end;
            end;


        }
        field(50003; "Product Type"; Code[250])
        {
            // Start 27-06-2019
            //TableRelation = "Product Type";
            //TableRelation = "Product Type" where ("Fabric Type" = const (false));
            // Stop 27-06-2019
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
        field(50004; "Project Location"; Text[250])
        {

        }
        field(50005; "Technical Specification"; Text[250])
        {

        }
        field(50006; "Drawing Details"; Text[250])
        {

        }
        field(50007; "Necessary documents"; Text[250])
        {

        }
        field(50008; "Initiatives"; Text[250])
        {

        }
        field(50009; "MSME Status"; Option)
        {
            //OptionMembers = " ","Under Progress","Quotation sent","Regret","Review","Under Approval";
            // Start 27-06-2019
            OptionMembers = " ","Under Progress","Quotation sent","Regret";
            // Stop 27-06-2019
            Caption = 'Enquiry Status';
            Editable = false;
        }
        field(50010; "Enquiry Type"; Code[20])
        {
            TableRelation = "Enquiry Type";
            trigger
            OnValidate()
            var
                EnquiryTypeRecG: Record "Enquiry Type";
                DateformulaTxtG: Text[100];
            begin
                if EnquiryTypeRecG.Get(Rec."Enquiry Type") then begin
                    DateformulaTxtG := Format(EnquiryTypeRecG."Due Date Calculation");
                    "Date of Conversion in Proposal" := CalcDate(DateformulaTxtG, Today);
                end;
                if "Enquiry Type" = '' then
                    "Date of Conversion in Proposal" := 0D;

            end;

        }
        field(50011; "Authority Required"; Boolean)
        {

        }
        field(50012; "Authorities"; Option)
        {
            OptionMembers = " ","DM","DCCA","Tarkhees","ADM","Consultants","others";
        }
        field(50013; "Date of Conversion in Proposal"; Date)
        {
            Editable = false;
        }
        field(50014; "Date for Submit Quotation"; Date)
        {

        }
        field(50015; "Enquiry Registered by"; Text[150])
        {

        }
        field(50016; "Follow-up By"; Code[150])
        {
            TableRelation = Employee;
            //TableRelation = "User Setup";
            // WHERE ("Enquiry Restriction" = FILTER (true));
            /*
                        trigger
                        OnLookup()
                        var
                            UserSetupRecL: Record "User Setup";
                            UserSetipPgL: Page "User Setup";
                        begin
                            UserSetupRecL.Reset();
                            Clear(UserSetipPgL);
                            UserSetupRecL.SetRange("Enquiry Restriction", true);
                            UserSetipPgL.SetRecord(UserSetupRecL);
                            UserSetipPgL.SetTableView(UserSetupRecL);
                            UserSetipPgL.LookupMode(true);
                            if UserSetipPgL.RunModal = Action::LookupOK then begin
                                UserSetipPgL.GetRecord(UserSetupRecL);
                                "Follow-up By" := UserSetupRecL."User ID";
                            end;

                        end;
                        */
        }
        field(50017; "Follow-up Date/Time"; DateTime)
        {

        }
        field(50018; "Design Input required"; Boolean)
        {

        }
        field(50019; "Sample requested"; Boolean)
        {

        }
        field(50020; "Remarks"; Text[250])
        {

        }
        field(50021; "Lead Type"; Option)
        {
            OptionMembers = " ","Customer","Contact";
            trigger
            OnValidate()
            var
                UserSetupRecL: Record "User Setup";
            begin
                /*
                                UserSetupRecL.Reset();
                                if UserSetupRecL.Get(UserId()) then begin
                                    if UserSetupRecL."Enquiry Restriction" then
                                        if "Enquiry Registered by" <> UserId() then
                                            Error('Sorry ! Your are Restricted user ,you cannot modify this Enquiry.');
                                end;

                  */
                if (XRec."Lead Type" = "Lead Type"::Contact) OR (Xrec."Lead Type" = "Lead Type"::Customer) then
                    if not Confirm('You Want to rename ?') then begin
                        "Lead Type" := xRec."Lead Type";
                        exit
                    end
                    else begin
                        Clear("Contact No.");
                        Clear("Contact Company Name");
                        Clear("Contact Name");
                        Clear("Customer No.");
                        Clear("Customer Name");
                        Clear("Salesperson Code");
                        Clear("Person in charge");
                        Clear("Contact Company No.");
                    end;
            end;



        }
        field(50023; "Customer Name"; Text[50])
        {
            Editable = false;
        }
        field(50024; "Job Type"; Option)
        {
            OptionMembers = " ";
        }
        // Start 27-06-2019
        field(50025; "Fabric Type"; Code[250])
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




        // Start Modify Table fileds
        modify("Contact No.")
        {
            trigger
            OnAfterValidate()
            var
                SalesPersonRecL: Record "Salesperson/Purchaser";
                ContactRecL: Record Contact;
            begin
                SalesPersonRecL.Reset();
                if ContactRecL.Get("Contact No.") then
                    if SalesPersonRecL.Get(ContactRecL."Salesperson Code") then begin
                        "Salesperson Code" := ContactRecL."Salesperson Code";
                        //"Salesperson Name" := SalesPersonRecL.Name;
                    end;
            end;
        }

        modify("Sales Document No.")
        {
            TableRelation = IF ("Sales Document Type" = CONST(Quote)) "Sales Header"."No."
            WHERE("Document Type" = CONST(Quote), "Sell-to Contact No." = FIELD("Contact No."), "Sell-to Customer No." = field("Customer No.")) ELSE
            IF ("Sales Document Type" = CONST(Order)) "Sales Header"."No."
            WHERE("Document Type" = CONST(Order), "Sell-to Contact No." = FIELD("Contact No."), "Sell-to Customer No." = field("Customer No."))
            ELSE
            IF ("Sales Document Type" = CONST("Posted Invoice")) "Sales Invoice Header"."No."
             WHERE("Sell-to Contact No." = FIELD("Contact No."), "Sell-to Customer No." = field("Customer No."));
        }

        // Start Modify Table fileds
        field(50022; "Scope Of Work 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        // start 27-06-2019
        // modify(Status)
        // {
        //     trigger
        //     OnAfterValidate()
        //     begin
        //         if Status = Status::Lost then begin
        //             "MSME Status" := "MSME Status"::Regret;
        //             Modify();
        //             Message('on val status');
        //             Commit();

        //         end;
        //     end;
        // }
        // stop 27-06-2019

    }
    // Stop Adding Fields



    trigger
    OnAfterInsert()
    begin
        "Enquiry Registered by" := UserId();
        "Follow-up Date/Time" := CurrentDateTime();
        Modify();

    end;
    //


    var
        Text005: Label 'You cannot assign a sales quote to the %2 record of the %1 while the %2 record of the %1 has no contact company assigned.';
        Text011: Label 'A sales quote has already been assigned to this opportunity.';

    procedure OnModifyRecords(OpprtnyRec: Record Opportunity)
    var
        UserSetupRecL: Record "User Setup";
    begin
        UserSetupRecL.Reset();
        if UserSetupRecL.Get(UserId()) then begin
            if UserSetupRecL."Enquiry Restriction" then
                if (OpprtnyRec."Enquiry Registered by" <> UserId()) AND (OpprtnyRec."No." <> '') then
                    Error('You cannot access the enquiries, you have not created.');

        end;
    end;


    procedure CreateQuoteForCustomer();
    var
        Cont: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        SalesHeader: Record "Sales Header";
        CustTemplate: Record "Customer Template";
        CustTemplateCode: Code[10];

        CustomerRecL: Record Customer;
    begin
        if "Lead Type" = "Lead Type"::Customer then begin
            CustomerRecL.get("Customer No.");

            IF SalesHeader.GET(SalesHeader."Document Type"::Quote, "Sales Document No.") THEN
                ERROR(Text011);

            TESTFIELD(Status, Status::"In Progress");

            //SalesHeader.SETRANGE("Sell-to Contact No.", "Contact No.");
            SalesHeader.SETRANGE("Sell-to Customer No.", "Customer No.");
            SalesHeader.INIT;
            SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
            SalesHeader.INSERT(TRUE);
            SalesHeader.VALIDATE("Salesperson Code", "Salesperson Code");
            SalesHeader.VALIDATE("Campaign No.", "Campaign No.");
            SalesHeader."Opportunity No." := "No.";
            SalesHeader."Order Date" := GetEstimatedClosingDate;
            SalesHeader."Shipment Date" := SalesHeader."Order Date";

            SalesHeader."Product Type" := "Product Type";
            SalesHeader."Fabric Type" := "Fabric Type";
            SalesHeader."Location Details" := "Project Location";
            // IF CustTemplateCode <> '' THEN
            //SalesHeader.VALIDATE("Sell-to Customer Template Code", CustTemplateCode);
            SalesHeader.Validate("Sell-to Customer No.", "Customer No.");

            // 09-07-2019
            SalesHeader."Scope Of Work 1" := Description;
            SalesHeader."Scope Of Work 2" := "Scope Of Work 2";
            // 09-07-2019 

            SalesHeader.MODIFY();

            "Sales Document Type" := "Sales Document Type"::Quote;
            "Sales Document No." := SalesHeader."No.";
            MODIFY;

            PAGE.RUN(PAGE::"Sales Quote", SalesHeader);
        end;
    END;

    local procedure GetEstimatedClosingDate(): Date;
    var
        OppEntry: Record "Opportunity Entry";
    begin
        OppEntry.SETCURRENTKEY(Active, "Opportunity No.");
        OppEntry.SETRANGE(Active, TRUE);
        OppEntry.SETRANGE("Opportunity No.", "No.");
        IF OppEntry.FINDFIRST THEN
            EXIT(OppEntry."Estimated Close Date");
    end;

    procedure CloseOpportunity_CUS()
    var
        TempOppEntry: Record "Opportunity Entry" temporary;

    begin
        IF "No." <> '' THEN
            TempOppEntry.CloseOppFromOpp_CUS(Rec);

    end;

    procedure StartActivateFirstStage_Cust()
    var
        SalesCycleStage: Record "Sales Cycle Stage";
        OpportunityEntry: Record "Opportunity Entry";
        ActivateFirstStageQst: Label 'Would you like to activate first stage for this opportunity?';
        SalesCycleNotFoundErr: Label 'Sales Cycle Stage not found.';
    begin
        if Confirm(ActivateFirstStageQst) then begin
            TestField("Sales Cycle Code");
            TestField(Status, Status::"Not Started");
            SalesCycleStage.SetRange("Sales Cycle Code", "Sales Cycle Code");
            if SalesCycleStage.FindFirst then begin
                OpportunityEntry.Init;
                OpportunityEntry."Sales Cycle Stage" := SalesCycleStage.Stage;
                OpportunityEntry."Sales Cycle Stage Description" := SalesCycleStage.Description;
                OpportunityEntry.InitOpportunityEntry(Rec);
                OpportunityEntry.InsertEntry_(OpportunityEntry, false, true);
                OpportunityEntry.UpdateEstimates;
            end else
                Error(SalesCycleNotFoundErr);
        end;
    end;
}