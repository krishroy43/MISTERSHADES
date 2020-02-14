report 50000 "Creation Purch. Enquiry"

{
    //UsageCategory = Tasks;
    //ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

        dataitem(MaterialReqLine; "Material Requisition Line")
        {


            trigger
            OnPreDataItem()
            begin
                //SetRange("Enquiry Item", true);
                // PurchaEnquiryLineRecG.DeleteAll(true);

            end;


            trigger
            OnAfterGetRecord()
            var
                VendorRec2L: Record Vendor;

            begin
                if RunFunG then begin
                    RunFunG := false;
                    VendorRec2L.Reset();
                    VendorRec2L.SetRange("Purch. Enquiry", true);
                    if VendorRec2L.FindSet() then begin
                        repeat
                            CreatPurchEnquiryHeader("Document No.", VendorRec2L."No.");
                            Commit();
                        until VendorRec2L.Next() = 0;
                    end;
                end;



            end;
        }


    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Purchase Enquiry")
                {
                    field("Vendor No."; VendorCodeG)
                    {
                        ApplicationArea = All;
                        //TableRelation = Vendor;                        
                        trigger
                        OnLookup(var Text: Text): Boolean
                        var
                            VendorRecL: Record Vendor;
                        begin
                            VendorRecL.Reset();
                            Commit();
                            if page.RunModal(50023, VendorRecL) = Action::LookupOK then begin
                                ;
                            end;

                        end;
                    }
                    field("Expected Delivery Date"; ExpecteddeliverydateG)
                    {
                        ApplicationArea = All;
                        //Visible = false;

                    }
                }
            }
        }


    }

    var
        VendorCodeG: Code[50];
        ExpecteddeliverydateG: Date;
        PurchEnquiryHeaderRecG: Record "Purch. Enquiry Header";
        PurchPayableSetupRecG: Record "Purchases & Payables Setup";
        NoSeriesMgtCUG: Codeunit NoSeriesManagement;
        PurchaEnquiryLineRecG: Record "Purch. Enquiry Line";
        RunFunG: Boolean;
        LastLineNumberG: Integer;
        NewDocumentNoG: Code[50];
        VendorRecG: Record Vendor;


        // Start Report Trigger
    trigger
    OnInitReport()
    begin
        VendorRecG.Reset();
        VendorRecG.SetRange("Purch. Enquiry", true);
        if VendorRecG.FindSet() then
            VendorRecG.ModifyAll("Purch. Enquiry", false);
        Commit();
    end;

    trigger
    OnPreReport()
    begin
        RunFunG := true;
        VendorRecG.Reset();
        VendorRecG.SetRange("Purch. Enquiry", true);
        if not VendorRecG.FindSet() and (ExpecteddeliverydateG = 0D) then
            //if not VendorRecG.FindSet() then
            Error('Please Select Vendor code .');


        TestNoSeries;
    end;

    trigger
    OnPostReport()
    begin
        Message('Purchase Enquiry Created Successfully.');
        VendorRecG.Reset();
        VendorRecG.SetRange("Purch. Enquiry", true);
        if VendorRecG.FindSet() then
            VendorRecG.ModifyAll("Purch. Enquiry", false);
        Commit();

    end;
    // Stop Report Trigger

    procedure TestNoSeries()
    begin
        PurchPayableSetupRecG.Reset();
        PurchPayableSetupRecG.Get();
        PurchPayableSetupRecG.TestField("Purchase Enquiry No.");
    end;

    procedure CreatPurchEnquiryHeader(var DocNoP: Code[50]; VendorCodeP: Code[50])
    var
        VendorRecL: Record Vendor;
        MaterialReqHeaderRecL: Record "Material Requisition Header";
    begin

        VendorRecL.Reset();

        Clear(NoSeriesMgtCUG);
        Clear(NewDocumentNoG);
        Clear(PurchEnquiryHeaderRecG."No.");

        PurchPayableSetupRecG.Reset();
        MaterialReqHeaderRecL.Reset();
        PurchPayableSetupRecG.Get();
        VendorRecL.Get(VendorCodeP);
        MaterialReqHeaderRecL.Get(DocNoP);
        PurchEnquiryHeaderRecG.Init();
        if PurchEnquiryHeaderRecG."No." = '' then begin
            // Start No. Series            
            PurchEnquiryHeaderRecG."No." := NoSeriesMgtCUG.GetNextNo(PurchPayableSetupRecG."Purchase Enquiry No.", Today, true);            // Stop No. Series 
            NewDocumentNoG := PurchEnquiryHeaderRecG."No.";
        end;
        // Start Vendor Information
        PurchEnquiryHeaderRecG.validate("Vendor No.", VendorRecL."No.");
        PurchEnquiryHeaderRecG.validate(Name, VendorRecL.Name);
        PurchEnquiryHeaderRecG.validate("Name 2", VendorRecL."Name 2");
        PurchEnquiryHeaderRecG.Validate(Contact, VendorRecL.Contact);
        PurchEnquiryHeaderRecG.Validate("Purchase Code", VendorRecL."Purchaser Code");
        // Stop Vendor Information
        // Start Basic Information
        PurchEnquiryHeaderRecG.validate("Requisition No.", MaterialReqHeaderRecL."Requisition No.");
        //PurchEnquiryHeaderRecG."Expected delivery date" := ExpecteddeliverydateG;
        //Message('%1', VendorRecL."Lead Time Calculation");
        if format(VendorRecL."Lead Time Calculation") <> '' then begin
            //PurchEnquiryHeaderRecG."Expected delivery date" := CALCDATE(VendorRecL."Lead Time Calculation", Today())
            PurchEnquiryHeaderRecG."Expected delivery date" := CALCDATE(VendorRecL."Lead Time Calculation", ExpecteddeliverydateG)
        end
        else begin
            //PurchEnquiryHeaderRecG."Expected delivery date" := Today;
            PurchEnquiryHeaderRecG."Expected delivery date" := ExpecteddeliverydateG;
        end;

        //PurchEnquiryHeaderRecG."Creation dateTime" := MaterialReqHeaderRecL."Creation Date and Time";
        PurchEnquiryHeaderRecG."Creation dateTime" := CurrentDateTime;
        PurchEnquiryHeaderRecG.Validate("Job No.", MaterialReqHeaderRecL."Job No.");
        // new field added in Purchase enqry location code
        PurchEnquiryHeaderRecG.Validate("Location Code", MaterialReqHeaderRecL."Location Code");
        // new field added in Purchase enqry location code
        PurchEnquiryHeaderRecG.Validate("Job Task No.", MaterialReqHeaderRecL."Job task No.");
        PurchEnquiryHeaderRecG.Insert();
        // Stop Basic Information      
        InsertPurchaseEnquiry(DocNoP);



    end;

    procedure InsertPurchaseEnquiry(DocNo: Code[50])
    var
        purchaseEnqryLineRecL: Record "Purch. Enquiry Line";
        MaterilReqLine: Record "Material Requisition Line";
    begin
        Clear(MaterilReqLine);
        Clear(LastLineNumberG);
        MaterilReqLine.Reset();
        MaterilReqLine.SetRange("Document No.", DocNo);
        MaterilReqLine.SetRange("Enquiry Item", true);
        if MaterilReqLine.FindSet() then begin
            repeat
                PurchaEnquiryLineRecG.Init();
                // Start Getting Last Line Number
                purchaseEnqryLineRecL.Reset();
                purchaseEnqryLineRecL.SetRange("Document No.", NewDocumentNoG);
                if purchaseEnqryLineRecL.FindLast() then
                    LastLineNumberG := purchaseEnqryLineRecL."Line No." + 10000
                else
                    LastLineNumberG := 10000;
                // Stop Getting Last Line Number
                // Start Inserting Line Formation
                // new fields added in purchase enqry table
                //Message('%1', DocNo);
                PurchaEnquiryLineRecG.Validate("Material Req. No.", DocNo);

                PurchaEnquiryLineRecG.Validate("Document No.", NewDocumentNoG);
                PurchaEnquiryLineRecG."Line No." := LastLineNumberG;
                PurchaEnquiryLineRecG.Validate(Type, MaterilReqLine.Type);
                PurchaEnquiryLineRecG.Validate("No.", MaterilReqLine."No.");
                // PurchaEnquiryLineRecG.Validate(Quantity, "Quantity needed");
                PurchaEnquiryLineRecG.Validate(Quantity, MaterilReqLine."Qty. to Enquiry");
                PurchaEnquiryLineRecG.Validate("Unit of Measure", MaterilReqLine."Unit of Measure");
                PurchaEnquiryLineRecG.Validate(Location, MaterilReqLine.Location);
                PurchaEnquiryLineRecG."Expected receipt date" := MaterilReqLine."Expected receipt date";
                PurchaEnquiryLineRecG.Validate("Job No.", MaterilReqLine."Job No.");
                PurchaEnquiryLineRecG.Validate("Job task No.", MaterilReqLine."Job task No.");
                PurchaEnquiryLineRecG.Validate("Job Planning Line No.", MaterilReqLine."Job Planning Line No.");

                // Stop Inserting Line Formation
                PurchaEnquiryLineRecG.Insert();
            until MaterilReqLine.Next() = 0;
            // once item get enquiry then boolean true.
            MaterilReqLine.ModifyAll("Req. To Enqry", true);
        end;
    end;

    procedure CheckDubplicatPurchaseEnqry(): Boolean
    var
        PurchEnqryHeaderRecL: Record "Purch. Enquiry Header";
        PurchEnqryLineRecL: Record "Purch. Enquiry Line";
    begin

    end;


}