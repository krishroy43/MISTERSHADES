report 50022 "Sales Shipment Report"
{
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'Delivery Note';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Document_Date; "Document Date") { }
            column(External_Document_No_; "External Document No.") { }
            column(Name; Name) { }
            column(Name2; Name2) { }
            column(Address; Address) { }
            column(Address2; Address2) { }
            column(PostCode; PostCode) { }
            column(Contact; Contact) { }
            column(City; City) { }
            column(Dispatch_Type; "Dispatch Type") { }
            column(Job_No_; "Job No.") { }
            column(Job_description; "Job description") { }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                //  DataItemLinkReference = "Transfer Shipment Header";
                DataItemLink = "No." = field("No.");
                column(Comment; Comment) { }
            }


            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(No; "No.") { }
                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Quantity; Quantity) { }
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
            trigger OnAfterGetRecord();
            begin
                if "Ship-to Code" = '' then begin
                    Name := "Sell-to Customer Name";
                    Name2 := "Sell-to Customer Name 2";
                    Address := "Sell-to Address";
                    Address2 := "Sell-to Address 2";
                    City := "Sell-to City";
                    PostCode := "Sell-to Post Code";
                    Contact := "Sell-to Contact";
                end else begin
                    Name := "Ship-to Name";
                    Name2 := "Ship-to Name 2";
                    Address := "Ship-to Address";
                    Address2 := "Ship-to Address 2";
                    City := "Ship-to City";
                    Contact := "Ship-to Contact";

                    PostCode := "Ship-to Post Code";




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
        SlNo: Integer;
        Name: Text[50];
        Name2: Text[50];
        Address: Text[50];
        Address2: Text[50];
        PostCode: Code[20];
        City: Text[30];
        Contact: Text[50];
}