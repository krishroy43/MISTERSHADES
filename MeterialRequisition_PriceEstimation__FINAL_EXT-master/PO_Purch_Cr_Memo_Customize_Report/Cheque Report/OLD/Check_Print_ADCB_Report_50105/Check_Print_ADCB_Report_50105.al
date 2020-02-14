report 50105 "Check Print ADCB"
{
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    Caption = 'Check Print ADCB Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            RequestFilterFields = "Document No.";
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.")
                                 order(ascending) where("Document Type" = filter(Payment | Refund));
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Amount; Amount1) { }
            column(AmtWord; AmtWord) { }
            column(Description; Description) { }
            column(PrintAmtWords1; PrintAmtWords1) { }
            column(PrintAmtWords2; PrintAmtWords2) { }
            trigger OnPreDataItem();
            begin
                Clear(Amount);

            end;

            trigger OnAfterGetRecord();

            begin
                /* Clear(Name);
                 Vendor_Rec.Reset;
                 if Vendor_Rec.Get("Vendor Ledger Entry"."Vendor No.") then
                     Name := Vendor_Rec.Name;*/

                /* Amount := ABS("Gen. Journal Line".Amount);
                 decimalVar1 := (Amount DIV 1);
                 DecimalVar := (Round(Amount) MOD 1 * 100);
                 CheckRep.FormatNoText(NoText, decimalVar1, '');
                 CheckRep.FormatNoText(NoText1, DecimalVar, '');
                 AmtWord := NoText[1] + 'AND' + NoText1[1];
                 //  Message('%1', AmtWord);*/

                //AmtWord1 := NoText1[1];
                Amount1 := ABS("Gen. Journal Line".Amount);

                CheckRep.InitTextVariable();
                //FormatNoText(AmtTowords,GenJnlLine.Amount,CurrCode);//LT
                CheckRep.FormatNoText(AmtTowords, Amount1, '');
                PrintAmtWords := AmtTowords[1] + AmtTowords[2];
                IF (COPYSTR(PrintAmtWords, STRLEN(PrintAmtWords), 1) = ' ') THEN BEGIN
                    PrintAmtWords := AmtTowords[1] + AmtTowords[2] + 'ONLY';
                    PrintAmtWords1 := PrintAmtWords;
                    PrintAmtWords := COPYSTR(PrintAmtWords1, 50);
                    PrintAmtWords := COPYSTR(PrintAmtWords1, 50);
                    PrintAmtWords2 := COPYSTR(PrintAmtWords1, 1, STRPOS(PrintAmtWords, ' ') + 49);

                    j := 49;
                    IF STRLEN(PrintAmtWords1) > 49 THEN
                        REPEAT
                            PrintAmtWords2 := COPYSTR(PrintAmtWords1, 1, STRPOS(PrintAmtWords, ' ') + j);
                            Mychar := FORMAT(PrintAmtWords2[STRLEN(PrintAmtWords2)]);
                            j := j - 1;
                        UNTIL Mychar = ' ';
                    PrintAmtWords2 := COPYSTR(PrintAmtWords1, 1, STRPOS(PrintAmtWords, ' ') + j);

                    PrintAmtWords1 := COPYSTR(PrintAmtWords1, STRLEN(PrintAmtWords2) + 1);
                END ELSE BEGIN
                    PrintAmtWords := AmtTowords[1] + AmtTowords[2] + ' ' + 'ONLY';
                    PrintAmtWords1 := PrintAmtWords;
                    PrintAmtWords := COPYSTR(PrintAmtWords1, 50);
                    PrintAmtWords2 := COPYSTR(PrintAmtWords1, 1, STRPOS(PrintAmtWords, ' ') + 49);
                    PrintAmtWords1 := COPYSTR(PrintAmtWords1, STRLEN(PrintAmtWords2) + 1);

                END;


            end;

        }
    }

    /*  requestpage
      {
          layout
          {
              area(content)
              {
                  group(GroupName)
                  {
                      field(Name; SourceExpression)
                      {
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
        Vendor_Rec: Record Vendor;
        Name: Text[50];
        CheckRep: Report Check;
        NoText: array[1] of Text;
        AmtWord: Text[250];

        Amount: Decimal;
        DecimalVar: Decimal;
        decimalVar1: Decimal;
        NoText1: array[1] of Text;
        PrintAmtWords: Text[250];
        PrintAmtWords1: Text[250];
        PrintAmtWords2: Text[250];
        AmtTowords: array[2] of Text;
        Mychar: Text[250];
        j: Integer;
        Amount1: Decimal;
}