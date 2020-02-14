report 50127 "Transfer Receipt Report"
{
    // UsageCategory = Administration;
    //  ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'Transfer Receipt';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
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
            column(Location2; Location2) { }
            column(Job_No_; "Job No.") { }
            column(JOBG; JOBG) { }
            column(Cust_Name; Cust_Name) { }
            column(userName1; userName1) { }
            column(userName2; userName2) { }
            // column(PONO; Job_Rec."Customer PO No.") { }
            // column(Job_BillToName; Job_Rec."Bill-to Name") { }
            column(Transfer_Order_Date; FORMAT("Transfer Order Date")) { }



            dataitem("Inventory Comment Line"; "Inventory Comment Line")
            {
                //  DataItemLinkReference = "Transfer Shipment Header";
                DataItemLink = "No." = field ("No.");
                column(Comment; Comment) { }
            }


            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
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
                user_Rec.Reset();
                user_Rec.SetRange("User Name", "Transfer Receipt Header".Creator);
                if user_Rec.FindFirst() then
                    userName1 := user_Rec."Full Name";

                user_Rec.Reset();
                user_Rec.SetRange("User Name", "Transfer Receipt Header".Receiver);
                if user_Rec.FindFirst() then
                    userName2 := user_Rec."Full Name";

                if "Transfer Receipt Header"."Job No." <> '' then begin
                    JOBG := "Transfer Receipt Header"."Job No.";
                    Cust_Name := Job_Rec."Bill-to Name"
                end else begin
                    JOBG := '';
                    Cust_Name := '';
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
        Location1: Text[250];
        Location2: Text[250];
        user_Rec: Record User;
        userName1: Code[50];
        userName2: Code[50];
        JOBG: Code[50];
        Cust_Name: Text[80];


}