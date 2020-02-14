tableextension 50031 "Ext Table Job" extends Job
{
    fields
    {
        // Start SRNo.1
        field(50000; "Customer PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Project Location"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Recipients Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Product Type"; Code[250])
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
        // Stop SRNo.1
        // Start SRNo.3
        field(50004; "Sales Quote"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where ("Document Type" = const (Quote));
        }
        field(50005; "Sales Enquiry"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Opportunity;
        }
        // Stop SRNo.3
        // Start SRNo.6
        field(50006; "Approved Drawing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Material Mill Certificat"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Painting Technical Data"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Operation and Maintnc Manual"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Operation & Maintenance Manual';
        }
        field(50010; "As Built Drawing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "Apprv. Struct. Design Calc."; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved Structural Design Calculation';
        }
        field(50012; "Welding Statement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Elcomtr Calibrt. Certi. Paint"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Elcometer Calibration Certificate for Painting';
        }
        field(50014; "Erection Method Statement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Painting Method Statement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Magnetic Particle Test Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Painting Report DFT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // Stop SRNo.6
        // Start SRNo.8
        field(50018; Finance; Code[20])
        {
            DataClassification = ToBeClassified;
            /*
             trigger
             OnLookup()
             var
                 ContBusinessRelation: Record "Contact Business Relation";
                 Cont: Record Contact;
                 TempCust: Record Customer temporary;
                 Cust: Record Customer;
             begin
                 IF ("Bill-to Customer No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
                     Cont.SETRANGE("Company No.", Cont."Company No.")
                 ELSE
                     IF Cust.GET("Bill-to Customer No.") THEN BEGIN
                         IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.") THEN
                             Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                     END ELSE
                         Cont.SETFILTER("Company No.", '<>%1', '''');

                 IF "Bill-to Contact No." <> '' THEN
                     IF Cont.GET("Bill-to Contact No.") THEN;
                 IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                     xRec := Rec;
                     VALIDATE(Finance, Cont."No.");
                 END;

             end;*/


        }
        field(50019; "Site Project manager"; Code[20])
        {
            DataClassification = ToBeClassified;
            /*  trigger
             OnLookup()
              var
                  ContBusinessRelation: Record "Contact Business Relation";
                  Cont: Record Contact;
                  TempCust: Record Customer temporary;
                  Cust: Record Customer;
              begin
                  IF ("Bill-to Customer No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
                      Cont.SETRANGE("Company No.", Cont."Company No.")
                  ELSE
                      IF Cust.GET("Bill-to Customer No.") THEN BEGIN
                          IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.") THEN
                              Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                      END ELSE
                          Cont.SETFILTER("Company No.", '<>%1', '''');

                  IF "Bill-to Contact No." <> '' THEN
                      IF Cont.GET("Bill-to Contact No.") THEN;
                  IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                      xRec := Rec;
                      VALIDATE("Site Project manager", Cont."No.");
                  END;
              end;
              */
        }

        field(50020; Procurement; Code[20])
        {
            DataClassification = ToBeClassified;
            /*
             trigger
            OnLookup()
             var
                 ContBusinessRelation: Record "Contact Business Relation";
                 Cont: Record Contact;
                 TempCust: Record Customer temporary;
                 Cust: Record Customer;
             begin
                 IF ("Bill-to Customer No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
                     Cont.SETRANGE("Company No.", Cont."Company No.")
                 ELSE
                     IF Cust.GET("Bill-to Customer No.") THEN BEGIN
                         IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.") THEN
                             Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                     END ELSE
                         Cont.SETFILTER("Company No.", '<>%1', '''');

                 IF "Bill-to Contact No." <> '' THEN
                     IF Cont.GET("Bill-to Contact No.") THEN;
                 IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                     xRec := Rec;
                     VALIDATE(Procurement, Cont."No.");
                 END;
             end;
             */
        }
        field(50021; "Quantity Surveyor"; Code[20])
        {
            DataClassification = ToBeClassified;
            /*
            trigger
           OnLookup()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
                TempCust: Record Customer temporary;
                Cust: Record Customer;
                JobCard: Page "Job Card";
            begin
                IF ("Bill-to Customer No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
                    Cont.SETRANGE("Company No.", Cont."Company No.")
                ELSE
                    IF Cust.GET("Bill-to Customer No.") THEN BEGIN
                        IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.") THEN
                            Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
                    END ELSE
                        Cont.SETFILTER("Company No.", '<>%1', '''');

                IF "Bill-to Contact No." <> '' THEN
                    IF Cont.GET("Bill-to Contact No.") THEN;
                IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                    xRec := Rec;
                    VALIDATE("Quantity Surveyor", Cont."No.");
                END;
            end;
            */
        }

        // Stop SRNo.8
        // Start SRNo.9
        field(50022; " Material Finalization"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Phy. and Material Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Physical and Material Approval';
        }
        field(50024; "Shop Drawing Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Prototype Requested"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Proforma Invoice created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Standard"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Standard 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        // Stop SRNo.9
        // Start SRNo. 2
        field(50029; "Job Type"; Option)
        {
            OptionMembers = " ","Job in Hand",Project,"Tender Job","General Jobs",Trading;
        }
        // Stop SRNo. 2

        // Start SRNo.7
        field(50030; "Scope Of Work 1"; Text[100])
        {
            Caption = 'Scope Of Work';

        }
        field(50031; "Scope Of Work 2"; Text[100])
        {

        }
        field(50032; "Contract Ref."; Text[50])
        {

        }
        field(50033; "Customer Po. Date."; Date)
        {

        }
        field(50034; "Workflow Status"; Option)
        {

            OptionMembers = "Open","Pending for Approval","Released";

        }
        // Stop SRNo.7
        field(50036; "Salesperson Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(50037; "Completion date"; Date)
        {

        }
        field(50050; "Project Amount (Planned)"; Decimal)
        {
            Caption = 'Project Amount (Planned)';
            FieldClass = FlowField;
            CalcFormula = sum ("Job Planning Line"."Line Amount" where
            ("Job No." = field ("No."), "Contract Line" = const (true)));
            Editable = false;
        }

        field(50051; "Advance Received"; Boolean)
        {
            Editable = false;
        }

        field(50052; "Advance Amount"; Decimal)
        {

            //FieldClass = FlowField;
            //CalcFormula = SUM ("Cust. Ledger Entry".Amount WHERE ("Job No." = field ("No.")));
            trigger
            OnLookup()
            var
                CustLedgerEntryRecL: Record "Cust. Ledger Entry";
                CustLedgerEntryPage: page "Customer Ledger Entries";
            begin
                CustLedgerEntryRecL.Reset();
                CustLedgerEntryRecL.SetRange("Job No.", "No.");
                CustLedgerEntryRecL.SetRange("Posting Type", CustLedgerEntryRecL."Posting Type"::Advance);
                if page.RunModal(25, CustLedgerEntryRecL) = Action::LookupOK then begin
                end;
            end;

            trigger
            OnValidate()
            begin
                if xRec."Advance Amount" <> "Advance Amount" then
                    "Advance Amount" := xRec."Advance Amount";
            end;
        }
        field(50053; "Version No."; Integer)
        {

        }
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

    }

    var
        myInt: Integer;
}