report 50020 "SalesQuote Report"
{
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'Sales Quote';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST (Quote));
            column(No; "No.")
            {
            }
            // column(Document_Date; Format("Document Date")) { }
            column(Document_Date; FORMAT("Document Date", 0, '<Month Text> <Day,2>,<Year4>')) { }
            //column(Document_Date; FORMAT("Document Date", 4, '<Month Text> <Day,2>,<Year4>')) { }
            //FORMAT(dateValue,10,'<Year4>/<Month,2>/<Day,2>');
            column(Name; CompanyInfo_Rec.Name) { }
            column(Name2; CompanyInfo_Rec."Name 2") { }

            column(CustName; Customer_Rec.Name) { }
            column(Adress; Customer_Rec.Address) { }
            column(Address2; Customer_Rec."Address 2") { }
            column(City; Customer_Rec.City) { }
            column(Country; Customer_Rec."Country/Region Code") { }
            column(Postcode; Customer_Rec."Post Code") { }
            column(FaxNo; Customer_Rec."Fax No.") { }
            column(PhoneNo; Customer_Rec."Phone No.") { }
            column(E_mail; Customer_Rec."E-Mail") { }
            column(MobileNo; Customer_Rec."Phone No.") { }
            ////column(Project_Description; "Project Description") { }
            // // // column(Adress; CompanyInfo_Rec.Address) { }
            // // // column(Address2; CompanyInfo_Rec."Address 2") { }
            // // // column(City; CompanyInfo_Rec.City) { }
            // // // column(Country; CompanyInfo_Rec."Country/Region Code") { }
            // // // column(Postcode; CompanyInfo_Rec."Post Code") { }
            // // // column(FaxNo; CompanyInfo_Rec."Fax No.") { }
            // // // column(PhoneNo; CompanyInfo_Rec."Phone No.") { }
            // // // column(E_mail; CompanyInfo_Rec."E-Mail") { }

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
            column(SalesPersonRecG_Phone; SalesPersonRecG."Phone No.") { }
            column(AmountInWordForWithoutJob; AmountInWordForWithoutJob[1]) { }

            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = field ("No.");
                column(Comment; Comment) { }
                column(StandardText_Rec; StandardText_Rec.Description) { }
                column(Standard_Code; StandardText_Rec.Code) { }
                column(Term_Condition; "Term/Condition") { }


                trigger OnAfterGetRecord()
                begin
                    StandardText_Rec.Reset();
                    if "Document Type" = "Document Type"::Quote then begin
                        if StandardText_Rec.Get("Term/Condition") then;

                    end;
                end;

            }




            dataitem("Sales Line"; "Sales Line")
            {

                DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");
                DataItemLink = "Document No." = field ("No.");
                column(Description; Description) { }
                column(Type; Type) { }
                column(Description_2; "Description 2") { }
                column(Unit_of_Measure; "Unit of Measure Code") { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Amount; "Line Amount") { }
                column(slNo; slNo) { }
                column(Amount; Amount) { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(VAT_Base_Amount; "VAT Base Amount") { }
                column(Quantity; Quantity) { }
                column(No1; "No.") { }
                column(Drawing_No_; "Drawing No.") { }
                column(Narration; Narration) { }


                trigger OnPreDataItem();
                begin
                    slNo := 0;
                    Clear(SumofLineAmount);

                end;

                trigger OnAfterGetRecord();
                begin
                    if ("No." <> '') AND ((Type = Type::"Charge (Item)") OR (Type = Type::"Fixed Asset") OR
                    (Type = Type::"G/L Account") OR (Type = Type::Item) OR (Type = Type::Resource)) then begin
                        slNo += 1;
                    end;
                    if "No." <> '' then begin
                        //  slNo += 1;
                        SumofLineAmount += "Amount Including VAT";
                    end;
                    AmountInWordCodeunitCU.InitTextVariable();
                    AmountInWordCodeunitCU.FormatNoText(AmountInWordForWithoutJob, SumofLineAmount, Currcode);



                end;
            }
            trigger OnPreDataItem();
            begin
                CompanyInfo_Rec.Get;

                Clear(Currcode);

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


                SalesPersonRecG.Reset();
                if SalesPersonRecG.Get("Salesperson Code") then;




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
        CompanyInfo_Rec: Record "Company Information";
        Customer_Rec: Record Customer;
        slNo: Integer;
        Location_Rec: Record Location;
        StandardText_Rec: Record "Standard Text";
        Currcode: code[20];

        Gl_setup: Record "General Ledger Setup";
        NoOfRows: Integer;
        NoOfRecords: Integer;
        SalesPersonRecG: Record "Salesperson/Purchaser";
        AmountInWordCodeunitCU: Codeunit "Amount In Word LT";
        SumofLineAmount: Decimal;
        AmountInWordForWithoutJob: array[2] of Text[250];



}