
xmlport 50001 "BOQ-Import"

{

    Format = VariableText;
    Direction = Import;
    //FieldSeparator = '<<NewLine>>';
    UseRequestPage = false;
    schema
    {
        textelement("Root")
        {
            tableelement(Estimation; "BOQ Tbl")
            {
                AutoSave = true;
                fieldattribute(RowType; Estimation."Row Type")
                {
                    trigger OnBeforePassField()
                    var
                        myInt: Integer;
                    begin

                        IF firstline then begin
                            firstline := false;
                            currxmlport.skip;

                        End;
                    end;

                }
                fieldattribute(Lineno; Estimation."Line No.")
                { }
                fieldattribute(CompanyCode; Estimation."Company Item Code")
                { }
                fieldattribute(ItemDescSpefic; Estimation.Description)
                { }
                fieldattribute(UnitMeas; Estimation."Unit of measure")
                { }
                fieldattribute(LengthType; Estimation."Length Type")
                { }
                fieldattribute(Qty; Estimation.Quantity)
                { }
                fieldattribute(DrawingNumber; Estimation."Drawing Number")
                { }
                fieldattribute(JobTaskNo; Estimation."Job Task")
                { }
                fieldattribute(EstQty; Estimation."Estimated Qty.")
                { }
                fieldattribute(TotalQty; Estimation."Total Qty.")
                { }
                trigger OnBeforeInsertRecord()
                var
                    EstimationRec: Record "BOQ Tbl";
                    EstimatinRec_13: Record "BOQ Tbl";
                begin
                    /*
                    IF firstline then begin
                        firstline := false;
                        currxmlport.skip;

                    End;
                    */

                    EstimationRec.Reset();
                    EstimationRec.SetRange("Quote No.", QuoteVar);
                    EstimationRec.SetRange("Version No.", Version_No);
                    EstimationRec.SetFilter("Line No.", '<>%1', 0);
                    If EstimationRec.FindLast then begin
                        Estimation."Quote No." := EstimationRec."Quote No.";
                        //Estimation."Line No." := EstimationRec."Line No." + 10000;

                        Estimation."Version No." := EstimationRec."Version No.";
                        if EstimationRec."Row Type" = EstimationRec."Row Type"::Total then
                            Estimation.Description := Estimation."Company Item Code";

                    end else begin
                        //Estimation."Line No." := 10000;
                        if Estimation."Row Type" = Estimation."Row Type"::Total then
                            Estimation.Description := Estimation."Company Item Code";

                        Estimation."Quote No." := GetValue();
                        if GetVersionValue() = 0 then
                            Estimation."Version No." := 1
                        else
                            Estimation."Version No." := GetVersionValue();
                    end;


                end;

                trigger OnAfterInsertRecord()
                var
                    EstimationRec_1: Record "BOQ Tbl";
                    ItemRec: Record Item;
                begin
                    /*
                    EstimationRec_1.Reset();
                    EstimationRec_1.SetRange("Quote No.", QuoteVar);
                    EstimationRec_1.SetRange("Line No.", Estimation."Line No.");
                    If EstimationRec_1.FindFirst then begin
                        ItemRec.Reset();
                        ItemRec.SetRange("No. 2", EstimationRec_1."Company Item Code");
                        if ItemRec.FindFirst then begin
                            EstimationRec_1."Item Code" := 'test';
                            EstimationRec_1.Modify();
                        end;
                    end;
                    */
                end;
            }

        }

    }



    requestpage

    {

        layout

        {

            area(content)

            {

                group(GroupName)

                { }

            }

        }



        actions

        {

            area(processing)

            {

                action(ActionName)

                {
                    ApplicationArea = all;


                }

            }

        }

    }

    trigger OnPreXmlPort()
    var
        myInt: Integer;
        BOQRec: Record "BOQ Tbl";
    begin
        FirstLine := true;
        BOQRec.DeleteAll();
    end;

    procedure SetValue(QuoteNo: Code[20]; VersionNo: Integer)
    var
        myInt: Integer;
    begin
        QuoteVar := QuoteNo;
        Version_No := VersionNo;

    end;

    procedure GetValue(): Code[20]
    var
        myInt: Integer;
    begin
        exit(QuoteVar);

    end;

    procedure GetVersionValue(): Integer
    var
        myInt: Integer;
    begin
        exit(Version_No);
    end;

    var

        FirstLine: Boolean;
        QuoteVar: Code[20];
        Version_No: Integer;

}
