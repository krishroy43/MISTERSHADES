// // report 50130 PurchEnqReport
// // {
// //     UsageCategory = Administration;
// //     ApplicationArea = All;

// //     dataset
// //     {
// //         dataitem("Purch. Enquiry Header"; "Purch. Enquiry Header")
// //         {
// //             column(No_; "No.")
// //             { }
// //             column(Posting_Date; FORMAT("Creation dateTime", 10, '<Day,2>/<Month,2>/<year,2>'))
// //             { }
// //             column(Expected_delivery_date; FORMAT("Expected delivery date", 10, '<Day,2>/<Month,2>/<year,2>'))
// //             { }
// //             column(Contact; Contact)
// //             { }
// //             column(Comp_Name; CompInfoRec.Name)
// //             { }
// //             column(Comp_Logo; CompInfoRec.Picture)
// //             { }
// //             column(Comp_Add1; CompInfoRec.Address)
// //             { }
// //             column(Comp_Add2; CompInfoRec."Address 2")
// //             { }
// //             column(Comp_City; CompInfoRec.City)
// //             { }
// //             column(Comp_Country; CompInfoRec."Country/Region Code")
// //             { }
// //             column(LocAdd; LocationRec.Address)
// //             { }
// //             column(LocAdd2; LocationRec."Address 2")
// //             { }
// //             column(LocPoCode; LocationRec."Post Code")
// //             { }
// //             column(LocCity; LocationRec.City)
// //             { }
// //             column(LocCountry; LocationRec.County)
// //             { }
// //             Column(LocPhone; LocationRec."Phone No.")
// //             { }
// //             column(LocEMail; LocationRec."E-Mail")
// //             { }
// //             dataitem("Purch. Enquiry Line"; "Purch. Enquiry Line")
// //             {
// //                 DataItemLink = "Document No." = FIELD ("No.");
// //                 column(Document_No_; "Document No.")
// //                 { }
// //                 column(LineNO; "No.")
// //                 { }
// //                 //To add Description in the Field after adding in Table.
// //                 //column(Description; Quantity)
// //                 //{ }
// //                 column(Item_Description; "Item Description")
// //                 {

// //                 }

// //                 column(UMO; "Unit of Measure")
// //                 { }
// //                 column(QTy; Quantity)
// //                 { }
// //             }
// //             trigger OnPreDataItem();
// //             begin
// //                 if LocationRec.get("Location Code") then;
// //             end;
// //         }

// //     }
// //     trigger OnPreReport();

// //     begin
// //         CompInfoRec.GET;
// //         CompInfoRec.CALCFIELDS(Picture);
// //     end;

// //     var
// //         LocationRec: Record Location;
// //         CompInfoRec: Record "Company Information";
// //         Posting: Date;

// // }