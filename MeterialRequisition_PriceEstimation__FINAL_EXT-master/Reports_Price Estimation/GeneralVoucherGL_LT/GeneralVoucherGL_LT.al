report 50116 GeneralVoucherGL_LT
{
    DefaultLayout = RDLC;
    RDLCLayout = 'MeterialRequisition_PriceEstimation__FINAL_EXT-master\Reports_Price Estimation\GeneralVoucherGL_LT\GeneralVoucherGL_LT.rdlc';
    Caption = 'GeneralVoucherGL_LT';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                ORDER(Ascending);
            RequestFilterFields = "Document No.";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(CompanyInfo_Name2; CompanyInfo."Name 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(UserName; UserName)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Country; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_vatRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_PhoneNol; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            /* column(DebitAmount; DebitAmount)
             {
             }*/
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            /* column(PaymentDesc; PaymentDesc)
             {
             }
             column(SourceNo; SourceNo)
             {
             }*/
            column(SourceNo; "G/L Account No.")
            {

            }
            column(PaymentDesc; "G/L Account Name")
            {

            }
            column(Narration_GLEntry; "G/L Entry".Description)//"G/L Entry".Narration)
            {
            }
            column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
            {
            }
            dataitem("G/L Entry_"; "G/L Entry")
            {
                DataItemLink = "Entry No." = field("Entry No.");
                column(Credit_Amount; "Credit Amount")
                {

                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    "G/L Entry_".SETFILTER("G/L Entry_"."Credit Amount", '<>1', 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /* IF "G/L Entry".Amount > 0 THEN
                     DebitAmount := 'Debit'
                 ELSE
                     DebitAmount := 'Credit';
        */
                /* IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor THEN BEGIN
                     IF VendorRec.GET("G/L Entry"."Source No.") THEN
                         PaymentDesc := VendorRec.Name;
                     SourceNo := "G/L Entry"."Source No.";
                 END
                 ELSE
                     IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Customer THEN BEGIN
                         IF CustomerRec.GET("G/L Entry"."Source No.") THEN
                             PaymentDesc := CustomerRec.Name;
                         SourceNo := "G/L Entry"."Source No.";
                     END
                     ELSE
                         IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::" " THEN BEGIN
                             IF GLAcctRec.GET("G/L Entry"."G/L Account No.") THEN
                                 PaymentDesc := GLAcctRec.Name;
                             SourceNo := "G/L Entry"."G/L Account No.";
                         END
                         ELSE
                             IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::"Fixed Asset" THEN BEGIN
                                 IF FixedAssetRec.GET("G/L Entry"."Source No.") THEN
                                     PaymentDesc := FixedAssetRec.Description;
                                 SourceNo := "G/L Entry"."Source No.";
                             END
                             ELSE
                                 IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Employee THEN BEGIN
                                     IF Employee.GET("G/L Entry"."Source No.") THEN
                                         PaymentDesc := Employee."First Name" + ' ' + Employee."Last Name";
                                     SourceNo := "G/L Entry"."Source No.";
                                 END;
        */
            end;

            trigger OnPreDataItem()
            begin
                //  "G/L Entry".SETFILTER("G/L Entry"."Source Code", '%1', 'GENJNL');
                "G/L Entry_".SETFILTER("G/L Entry_"."Debit Amount", '<>1', 0);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        Clear(Users);
        Clear(UserName);
        Users.SetCurrentKey("User Name");
        Users.SetRange("User Name", UserId);
        IF Users.FindFirst() then begin
            if Users."Full Name" <> '' then
                UserName := Users."Full Name"
            else
                UserName := UserId;
        end;
    end;

    var
        CompanyInfo: Record 79;
        //CreditAmount: Text;
        //DebitAmount: Text;
        FixedAssetRec: Record 5600;
        CustomerRec: Record 18;
        VendorRec: Record 23;
        GLAcctRec: Record 15;
        Employee: Record 5200;
        SourceNo: Code[20];
        PaymentDesc: Text[100];
        Custledentry_Rec: Record 21;
        Users: Record User;
        UserName: Text;
}

