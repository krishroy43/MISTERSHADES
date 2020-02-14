report 50028 "Dispatch Note"
{
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'Dispatch Note';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";

            column(Name; CompanyInfo_Rec.Name) { }
            column(Adress; CompanyInfo_Rec.Address) { }
            column(Address2; CompanyInfo_Rec."Address 2") { }
            column(City; CompanyInfo_Rec.City) { }
            column(Country; CompanyInfo_Rec."Country/Region Code") { }
            column(Postcode; CompanyInfo_Rec."Post Code") { }
            column(Picture; CompanyInfo_Rec.Picture) { }
            column(PhoneNo; CompanyInfo_Rec."Phone No.") { }
            column(Email; CompanyInfo_Rec."E-Mail") { }
            column(VatRegNo; CompanyInfo_Rec."VAT Registration No.") { }
            column(No_; "No.") { }
            column(Description1; Description1) { }
            column(Description2; Description2) { }
            column(Cust_Name; Cust_Name) { }
            column(custPoNo; custPoNo) { }
            column(Posting_Date; Format("Posting Date")) { }
            column(Dispatch_Type; "Dispatch Type") { }
            column(Job_No_; "Job No.") { }
            // Start 05-09-2019
            column(Delivery_Location; "Delivery Location") { }
            column(External_Document_No_; "External Document No.") { }
            // Stop 05-09-2019
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {

                DataItemLink = "Document No." = field("No.");
                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Quantity; Quantity) { }
                column(No1; "No.") { }
                column(SlNo; SlNo) { }
                trigger OnPreDataItem()
                begin
                    SlNo := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    SetCurrentKey("No.");
                    if ("No." <> '') AND ((Type = Type::"Charge (Item)") OR (Type = Type::"Fixed Asset") OR
                          (Type = Type::"G/L Account") OR (Type = Type::Item) OR (Type = Type::Resource)) then begin
                        SlNo += 1;
                    end else begin
                        SlNo := 0;
                    end;

                end;
            }

            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = field("No.");
                column(Comment; Comment) { }
                column(StandardText_Rec; StandardText_Rec.Description) { }
                column(Standard_Code; StandardText_Rec.Code) { }
                column(Term_Condition; "Term/Condition") { }
                trigger OnAfterGetRecord()
                begin
                    StandardText_Rec.Reset();
                    if StandardText_Rec.Get("Term/Condition") then;

                end;
            }


            trigger OnPreDataItem()
            begin


                CompanyInfo_Rec.Get();
                if CompanyInfo_Rec.Get(CompanyInfo_Rec.CalcFields(Picture)) then;

                Clear(Description1);
                Clear(Description2);
                Clear(Cust_Name);
                Clear(custPoNo);


            end;

            trigger OnAfterGetRecord()
            begin
                Job_Rec.Reset();
                if Job_Rec.Get("Job No.") then begin
                    Description1 := Job_Rec."Project Location";
                    Description2 := Job_Rec.Description;
                    Cust_Name := Job_Rec."Bill-to Name";
                    custPoNo := Job_Rec."Customer PO No.";

                end;

            end;

        }
    }

    /*  requestpage
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
          }*/

    /*  actions
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
        To_Cap = 'To';
        Client_Ref_Cap = 'Client Ref.';
        DocumentNo_Cap = 'Document No.';
        DateOfDelivery_Cap = 'Date Of Delivery';
        Delivery_Cap = 'Delivery Type';
        JobNo_Cap = 'Job No.';
        SrNo_Cap = 'Sr.No.';
        Description_Cap = 'Description';
        Unit_Cap = 'Unit';
        Qty_Cap = 'Qty';


    }

    var
        myInt: Integer;
        SlNo: integer;
        CompanyInfo_Rec: Record "Company Information";

        Job_Rec: Record Job;
        Description1: Text[250];
        Description2: Text[250];
        Cust_Name: Text[250];
        custPoNo: Code[20];
        StandardText_Rec: Record "Standard Text";
}