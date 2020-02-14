report 50021 "Transfer Shipment Report"
{
    // UsageCategory = Administration;
    //  ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'Issue Voucher';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            column(Name; CompanyInfo_Rec.Name) { }
            column(Name2; CompanyInfo_Rec."Name 2") { }
            column(Adress; CompanyInfo_Rec.Address) { }
            column(Address2; CompanyInfo_Rec."Address 2") { }
            column(City; CompanyInfo_Rec.City) { }
            column(Country; CompanyInfo_Rec."Country/Region Code") { }
            column(Postcode; CompanyInfo_Rec."Post Code") { }
            column(Picture; CompanyInfo_Rec.Picture) { }
            column(PhoneNo; CompanyInfo_Rec."Phone No.") { }
            column(Email; CompanyInfo_Rec."E-Mail") { }
            column(TRN; CompanyInfo_Rec."VAT Registration No.") { }
            column(Name1; Location1) { }
            column(Job_No_; "Job No.") { }
            column(PONO; Job_Rec."Customer PO No.") { }
            column(Job_BillToName; Job_Rec."Bill-to Name") { }
            column(Heading; Heading) { }
            column(Heading1; Heading1) { }
            column(Heading2; Heading2) { }
            column(JOBG; JOBG) { }
            column(Cust_Name; Cust_Name) { }
            column(userName; userName1) { }
            column(userName2; userName2) { }
            column(Description1; Description1) { }
            column(Transfer_Order_Date; FORMAT("Transfer Order Date")) { }



            dataitem("Inventory Comment Line"; "Inventory Comment Line")
            {
                //  DataItemLinkReference = "Transfer Shipment Header";
                DataItemLink = "No." = field ("No.");
                column(Comment; Comment) { }
            }


            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = field ("No.");
                column(Item_No_; "Item No.") { }
                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(Unit_of_Measure; "Unit of Measure Code") { }
                column(Quantity; Quantity) { }
                column(Requisition_No_; "Requisition No.") { }
                column(SlNo; SlNo) { }


                trigger OnPreDataItem();
                begin
                    SlNo := 0;
                end;

                trigger OnAfterGetRecord();
                begin
                    SlNo += 1;
                end;

            }
            trigger OnPreDataItem();
            begin
                CompanyInfo_Rec.Get;
                CompanyInfo_Rec.CalcFields(CompanyInfo_Rec.Picture);

                Clear(Location1);
                Clear(Location2);
                Clear(Description1);
                Clear(JOBG);
                Clear(Cust_Name);
                Clear(Heading);
                Clear(Heading1);
                Clear(Heading2);
                Clear(userName1);
                Clear(userName2);

            end;

            trigger OnAfterGetRecord();
            begin
                Location_Rec.Reset;
                if Location_Rec.Get("Transfer-from Code") then;
                Location1 := Location_Rec.Name;

                Location_Rec.Reset;
                if Location_Rec.Get("Transfer-to Code") then
                    Location2 := Location_Rec.Name;

                Job_Rec.Reset();
                if Job_Rec.Get("Job No.") then;

                if "Transfer Shipment Header"."Job No." <> '' then begin
                    Heading := 'Issue Voucher';
                    Heading1 := 'Ref. No.';
                    Heading2 := 'Customer Name';
                end else begin
                    Heading := 'Transfer Shipment';
                    Heading1 := '';
                    Heading2 := '';
                end;



                if "Transfer Shipment Header"."Job No." <> '' then
                    Description1 := Job_Rec."Project Location"
                else
                    Description1 := Location2;

                if "Transfer Shipment Header"."Job No." <> '' then begin
                    JOBG := "Transfer Shipment Header"."Job No.";
                    Cust_Name := Job_Rec."Bill-to Name"
                end else begin
                    JOBG := '';
                    Cust_Name := '';
                end;

                user_Rec.Reset();
                user_Rec.SetRange("User Name", "Transfer Shipment Header".Creator);
                if user_Rec.FindFirst() then
                    userName1 := user_Rec."Full Name";

                user_Rec.Reset();
                user_Rec.SetRange("User Name", "Transfer Shipment Header".Receiver);
                if user_Rec.FindFirst() then
                    userName2 := user_Rec."Full Name";
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

    var
        myInt: Integer;
        SlNo: integer;
        CompanyInfo_Rec: Record "Company Information";
        Location_Rec: Record Location;
        Job_Rec: Record Job;

        Heading: Text[20];

        Description1: Text[250];

        JOBG: Code[20];
        Cust_Name: Text[250];
        Location1: Text[250];
        Location2: Text[250];

        Heading1: Text[250];
        Heading2: Text[250];

        user_Rec: Record User;

        userName1: Code[50];
        userName2: Code[50];
}