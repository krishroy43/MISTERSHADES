report 50130 PurchEnqReport
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Purchase Enquiry';
    //RDLCLayout = 'Reports/Purchase Enquiry_R.rdl';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("Purch. Enquiry Header"; "Purch. Enquiry Header")
        {
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Posting_Date; FORMAT("Creation dateTime", 10, '<Day,2>/<Month,2>/<year,2>')) { }
            column(Expected_delivery_date; FORMAT("Expected delivery date", 10, '<Day,2>/<Month,2>/<year,2>')) { }
            column(Contact; Contact) { }
            column(Comp_Name; CompInfoRec.Name) { }
            column(Comp_Logo; CompInfoRec.Picture) { }
            column(Comp_Add1; CompInfoRec.Address) { }
            column(Comp_Add2; CompInfoRec."Address 2") { }
            column(Comp_City; CompInfoRec.City) { }
            column(PhoneNo; CompInfoRec."Phone No.") { }
            column(TRN; CompInfoRec."VAT Registration No.") { }
            column(Comp_Country; CompInfoRec."Country/Region Code") { }
            column(LocAdd; LocationRec.Address) { }
            column(LocAdd2; LocationRec."Address 2") { }
            column(LocPoCode; LocationRec."Post Code") { }
            column(LocCity; LocationRec.City) { }
            column(LocCountry; LocationRec.County) { }
            Column(LocPhone; PhoneNo) { }
            column(LocEMail; Email) { }
            //Modified
            column(Job_No__; "Job No.") { }
            column(ContactName_; ContactName) { }
            column(LocAddress_; LocAddress) { }
            column(LocCityCount_; LocCityCount) { }
            column(DeclarationText; DeclarationText) { }

            dataitem("Purch. Enquiry Line"; "Purch. Enquiry Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                column(Document_No_; "Document No.") { }
                column(LineNO; "No.") { }
                column(Item_Description; "Item Description") { }
                column(UMO; "Unit of Measure") { }
                column(QTy; Quantity) { }
                column(SrNo; SrNo) { }
                trigger
                OnPreDataItem()
                begin
                    SrNo := 0;
                end;

                trigger
                OnAfterGetRecord()
                begin
                    if "No." <> '' then
                        SrNo += 1;
                end;
            }
            dataitem("Purchase Enq. Comment Line"; "Purchase Enq. Comment Line")
            {
                DataItemLink = "No." = FIELD ("No.");
                column(Comment; Comment) { }
                column(StandardText_Rec; StandardText_Rec.Description) { }
                column(Standard_Code; StandardText_Rec.Code) { }
                column(Term_Condition; "Term/Condition") { }
                trigger OnAfterGetRecord()
                begin
                    StandardText_Rec.Reset();
                    if "Document Type" = "Document Type"::"Purchase Enquiry" then begin
                        if StandardText_Rec.Get("Term/Condition") then;

                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Contact: Record Contact;
            begin
                Clear(LocCityCount);
                Clear(Contact);
                Clear(ContactName);
                Clear(LocAddress);
                Clear(PhoneNo);
                Clear(Email);
                Contact.SetCurrentKey("No.");
                if Contact.GET("Purch. Enquiry Header".Contact) then begin
                    ContactName := Contact.Name;
                    if Contact.Address <> '' then
                        LocAddress := Contact.Address;
                    if Contact."Address 2" <> '' then begin
                        if LocAddress <> '' then
                            LocAddress := LocAddress + ', ' + Contact."Address 2"
                        else
                            LocAddress := Contact."Address 2";
                    end;
                    if Contact.City <> '' then
                        LocCityCount := Contact.City;

                    if Contact."Country/Region Code" <> '' then begin
                        if LocCityCount <> '' then
                            LocCityCount := LocCityCount + ', ' + Contact."Country/Region Code"
                        else
                            LocCityCount := Contact."Country/Region Code";
                    end;

                    PhoneNo := Contact."Phone No.";
                    Email := Contact."E-Mail";
                end;
            end;

            trigger OnPreDataItem();
            begin
                if LocationRec.get("Location Code") then;
            end;
        }

    }
    trigger OnPreReport();

    begin
        CompInfoRec.GET;
        CompInfoRec.CALCFIELDS(Picture);
    end;

    var
        LocationRec: Record Location;
        CompInfoRec: Record "Company Information";
        Posting: Date;
        ContactName: Text;
        LocAddress: Text;
        LocCityCount: Text;
        PhoneNo: Text;
        Email: Text;
        DeclarationText: Label 'This is computer generated Document no signature required.';
        StandardText_Rec: Record "Standard Text";
        SrNo: Integer;

}