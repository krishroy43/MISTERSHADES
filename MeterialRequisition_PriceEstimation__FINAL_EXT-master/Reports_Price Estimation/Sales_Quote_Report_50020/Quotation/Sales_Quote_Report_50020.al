report 50101 "SalesQuote"
{
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'Sales Quote';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'MeterialRequisition_PriceEstimation__FINAL_EXT-master\Reports_Price Estimation\Sales_Quote_Report_50020\Quotation\50101 Sales quote 15 jan.rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote));
            column(No; "No.")
            {
            }
            column(Document_Date; "Document Date") { }
            column(Name; CompanyInfo_Rec.Name) { }
            column(Name2; CompanyInfo_Rec."Name 2") { }
            column(CustName; Customer_Rec.Name) { }
            column(IsStatus; IsStatus) { }
            column(Adress; Customer_Rec.Address) { }
            column(Address2; Customer_Rec."Address 2") { }
            column(City; Customer_Rec.City) { }
            column(Country; Customer_Rec."Country/Region Code") { }
            column(Postcode; Customer_Rec."Post Code") { }
            column(FaxNo; Customer_Rec."Fax No.") { }
            column(PhoneNo; Customer_Rec."Phone No.") { }
            column(E_mail; Customer_Rec."E-Mail") { }
            column(MobileNo; Customer_Rec."Phone No.") { }
            column(Picture; CompanyInfo_Rec.Picture) { }
            column(Scope_Of_Work_1; "Scope Of Work 1") { }
            column(Scope_Of_Work_2; "Scope Of Work 2") { }
            column(Product_Type; "Product Type") { }
            column(Location_Details; "Location Details") { }
            //column(Bill_to_Contact; "Bill-to Contact") { }
            column(Bill_to_Contact; "Sell-to Contact") { }
            column(Currcode; Currcode) { }
            column(Consultant; Consultant) { }
            column(Client; Client) { }
            column(Project_Description; "Project Description") { }
            column(SalesPersonRecG_Name; SalesPersonRecG.Name) { }
            column(No__of_Archived_Versions; NoOfArchive) { }
            column(SalesPersonRecG_Phone; SalesPersonRecG."Phone No.") { }
            column(SalesPersonRecG_jobTitle; SalesPersonRecG."Job Title") { }
            column(SalesPersonRecG_Email; SalesPersonRecG."E-Mail") { }
            column(ContactRec_Name; ContactRec.Name) { }
            column(ContactRec_Mobile; ContactRec."Phone No.") { }
            column(ContactRec_Email; ContactRec."E-Mail")
            { }
            column(ContactRec_City; ContactRec.City)
            { }
            column(ContactRec_Country; ContactRec."Country/Region Code") { }
            column(CompanyInfo_Rec_Web; CompanyInfo_Rec."Home Page") { }
            column(AmountInWordForWithoutJob; AmountInWordForWithoutJob[1]) { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemTableView = SORTING("Document Type") WHERE("Document Type" = CONST(Quote));
                DataItemLink = "Document No." = field("No.");

                column(Description; Description + ' ' + "Description 2" + ' ' + Narration) { }
                column(Type; Type) { }
                //additional field -Option added On 21 dec 2019
                column(Option; Option) { }
                column(ItemPict; TenantMedia.Content)
                {

                }
                column(IsOption; IsOption) { }
                column(Description_2; "Description 2") { }
                column(Unit_of_Measure; "Unit of Measure Code") { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Discount__; "Line Discount %") { }
                column(Line_Discount_Amount; "Line Discount Amount") { }
                column(DiscUnitPrice; DiscUnitPrice) { }
                column(Unit_Cost; "Unit Cost") { }
                column(Line_Amount; "Line Amount") { }
                column(slNo; slNo) { }
                column(Line_No_; "Line No.") { }
                column(Amount; Amount) { }
                column(Amount_Including_VAT; "Amount Including VAT") { }//last
                column(VAT_Base_Amount; "VAT Base Amount") { }
                column(VATAmount; "Amount Including VAT" - "VAT Base Amount") { }
                column(Quantity; Quantity) { }
                column(No1; "No.") { }
                column(Drawing_No_; "Drawing No.") { }
                column(Narration; Narration) { }

                trigger OnAfterGetRecord();
                begin
                    if ("No." <> '') AND ((Type = Type::"Charge (Item)") OR (Type = Type::"Fixed Asset") OR
                    (Type = Type::"G/L Account") OR (Type = Type::Item) OR (Type = Type::Resource)) then begin

                        //
                        if (Option <> '') AND (Option <> Optiontext) then begin
                            slNo := 0;
                            Optiontext := Option;
                        end;

                        //
                        slNo += 1;
                        //image
                        Clear(RecItem);
                        Clear(TenantMedia);
                        RecItem.SetRange("No.", "No.");
                        if RecItem.FindFirst() then begin
                            IF RecItem.Picture.COUNT > 0 THEN BEGIN
                                TenantMedia.SetRange(ID, RecItem.Picture.ITEM(1));
                                if TenantMedia.FindFirst() then begin
                                    TenantMedia.CALCFIELDS(Content);
                                    // Message('%1....%2', TenantMedia.Content.Length, RecItem.Picture.ITEM(1));
                                END;
                            END;
                        End;
                        //image


                        if "No." <> '' then begin
                            //  slNo += 1;
                            SumofLineAmount += "Amount Including VAT";
                        end;
                        AmountInWordCodeunitCU.InitTextVariable();
                        AmountInWordCodeunitCU.FormatNoText(AmountInWordForWithoutJob, SumofLineAmount, Currcode);

                        if Option <> '' then
                            IsOption := true;
                        Clear(DiscUnitPrice);
                        DiscUnitPrice := "Sales Line"."Unit Cost" - ("Sales Line"."Line Discount Amount" / "Sales Line".Quantity);

                    end;

                end;

                trigger OnPreDataItem();
                begin
                    slNo := 0;
                    Clear(SumofLineAmount);
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = field("No.");
                column(Comment; Comment) { }
                column(StandardText_Rec; StandardText_Rec.Description) { }
                column(Standard_Code; StandardText_Rec.Code) { }
                column(Term_Condition; "Term/Condition") { }
                column(CommentDescription2; Description) { }

                trigger OnAfterGetRecord()
                begin
                    StandardText_Rec.Reset();
                    if "Document Type" = "Document Type"::Quote then begin
                        if StandardText_Rec.Get("Term/Condition") then;

                    end;
                end;

            }
            trigger OnPreDataItem();
            begin
                CompanyInfo_Rec.Get;
                CompanyInfo_Rec.CalcFields(Picture);
                Clear(Currcode);
                IsOption := false;
            end;

            trigger OnAfterGetRecord();
            begin
                Customer_Rec.Reset;
                if Customer_Rec.Get("Sell-to Customer No.") then;

                Gl_setup.Reset();
                Gl_setup.Get();
                if SalesHeader."Currency Code" = '' then
                    Currcode := Gl_setup."LCY Code"
                else
                    Currcode := SalesHeader."Currency Code";

                if Status = Status::Released then
                    IsStatus := true
                else
                    IsStatus := false;
                SalesPersonRecG.Reset();
                if SalesPersonRecG.Get("Salesperson Code") then;
                ContactRec.Reset();
                if ContactRec.Get("Sell-to Contact No.") then;
                Clear(NoOfArchive);
                if SalesHeader."No. of Archived Versions" <> 0 then
                    NoOfArchive := ' REV' + FORMAT(SalesHeader."No. of Archived Versions");
            end;

        }


    }

    /*requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; SourceExpression)
                    {
                        ApplicationArea = All;
                        
                    }
                }
            }
        }
    
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }*/

    labels
    {
        Attention_Cap = 'Attention :';
        Company_Cao = 'Company :';
        Address_Cap = 'Address   :';
        Tel_Cap = 'Tel      :';
        Fax_Cap = 'Fax     :';
        Mob_Cap = 'Mob    :';
        Email_Cap = 'Email  :';
        Project_name = 'Project Name       :';
        project_Location = 'Project Location  :';
        Consultant_Cap = 'Consultant            :';
        Client_Cap = 'Client                    :';
        SubWworks_Cap = 'Sub-Works           :';
        Dearmadam_Cap = 'Dear Sir/Madam :';
        S_No = 'SI';
        Item_Description = 'ITEM DESCRIPTION';
        Unit_Cap = 'UNIT';
        Unit_rate = 'UNIT RATE';
        Total_Cap = 'TOTAL';
        Total_Amount = 'TOTAL AMOUNT';
        ValueAddedTAX_Cap = 'Value Added TAX';
        Final_Amount = 'Final Amount';
    }


    var
        myInt: Integer;
        RecItem: Record Item;
        IsStatus: Boolean;
        Optiontext: Text;
        CompanyInfo_Rec: Record "Company Information";
        Customer_Rec: Record Customer;
        IsOption: Boolean;
        TenantMedia: Record "Tenant Media";
        DiscUnitPrice: Decimal;
        slNo: Integer;
        Location_Rec: Record Location;
        StandardText_Rec: Record "Standard Text";
        Currcode: code[20];
        ContactRec: Record Contact;
        Gl_setup: Record "General Ledger Setup";
        NoOfRows: Integer;
        NoOfRecords: Integer;
        SalesPersonRecG: Record "Salesperson/Purchaser";
        AmountInWordCodeunitCU: Codeunit "Amount In Word LT";
        SumofLineAmount: Decimal;
        AmountInWordForWithoutJob: array[2] of Text[250];
        NoOfArchive: Text;
        Index: Integer;

}


pageextension 50125 POSUBFORM extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout hera
        addafter("Direct Unit Cost")
        {
            field("Average Unit Cost"; "Average Unit Cost")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter("Qty. Assigned")
        {
            field("IC Partner Ref. Type_"; "IC Partner Ref. Type")
            {
                ApplicationArea = All;
                CaptionClass = 'IC Partner Ref. Type';
            }
            field("IC Partner Reference_"; "IC Partner Reference")
            {
                ApplicationArea = All;
                Caption = 'IC Partner Reference';
            }
            field("IC Partner Code_"; "IC Partner Code")
            {
                ApplicationArea = All;
                Caption = 'IC Partner Code';
            }
        }
        modify("IC Partner Ref. Type")
        {
            Visible = false;
        }
        modify("IC Partner Reference")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}

pageextension 50126 PISubform extends "Purch. Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Qty. Assigned")
        {
            field("IC Partner Ref. Type_"; "IC Partner Ref. Type")
            {
                ApplicationArea = All;
                CaptionClass = 'IC Partner Ref. Type';
            }
            field("IC Partner Reference_"; "IC Partner Reference")
            {
                ApplicationArea = All;
                Caption = 'IC Partner Reference';
            }
            field("IC Partner Code_"; "IC Partner Code")
            {
                ApplicationArea = All;
                Caption = 'IC Partner Code';
            }
        }
        modify("IC Partner Ref. Type")
        {
            Visible = false;
        }
        modify("IC Partner Reference")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
