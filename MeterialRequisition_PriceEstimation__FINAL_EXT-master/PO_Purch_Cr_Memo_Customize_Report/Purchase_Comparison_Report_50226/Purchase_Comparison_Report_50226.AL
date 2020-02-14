report 50226 "Purchase Comparison"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Inventory Posting Group", "Gen. Prod. Posting Group", "Item Category Code";
            DataItemTableView = sorting ("No.");
            column(No_; "No.") { }
            column(Description; Description) { }
            column(Inventory_Posting_Group; "Inventory Posting Group") { }
            column(Gen__Prod__Posting_Group; "Gen. Prod. Posting Group") { }
            column(Item_Category_Code; "Item Category Code") { }
            //column(Unit_of_Measure_Code; "Base Unit of Measure") { }
            column(CompanyInfoRecG_name; CompanyInfoRecG.Name) { }
            column(PreviousYear3_First; PreviousYear3) { }
            column(PreviousYear2_Mid; PreviousYear2) { }
            column(SelectedYearIntG_Last; SelectedYearIntG) { }
            column(GetFilters_List; GetFilters) { }
            column(ReportHeader__Full; ReportHeader) { }

            column(FilItemNoTxtG; FilItemNoTxtG) { }
            column(FilInvPostingTxtG; FilInvPostingTxtG) { }
            column(FilGenPostingGroupTxtG; FilGenPostingGroupTxtG) { }
            column(FilCategoryTxtG; FilCategoryTxtG) { }




            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = sorting ("Item No.") where ("Entry Type" = const (Purchase));
                DataItemLink = "Item No." = field ("No.");
                column(QuantityYear1; QuantityYear1) { }
                column(QuantityYear2; QuantityYear2) { }
                column(QuantityYear3; QuantityYear3) { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                column(UOMDesc; UOMDesc) { }

                trigger
                OnAfterGetRecord()
                begin
                    Clear(QuantityYear1);
                    Clear(QuantityYear2);
                    Clear(QuantityYear3);

                    //  if (LastItemCodeG <> "Item No.") and (LastUOMCodeG <> "Unit of Measure Code") then begin
                    QuantityYear1 := FindQuantityBaseOnDates("Item No.", "Unit of Measure Code", StartDate1, EndDate1);

                    QuantityYear2 := FindQuantityBaseOnDates("Item No.", "Unit of Measure Code", StartDate2, EndDate2);

                    QuantityYear3 := FindQuantityBaseOnDates("Item No.", "Unit of Measure Code", StartDate3, EndDate3);

                    // LastItemCodeG := "Item No.";
                    // LastUOMCodeG := "Unit of Measure Code";

                    // end;
                    Clear(UOMDesc);
                    UOMRecG.Reset();
                    if UOMRecG.Get("Unit of Measure Code") then
                        UOMDesc := UOMRecG.Description
                    else
                        if UOMRecG.Get(Item."Base Unit of Measure") OR UOMRecG.Get(Item."Purch. Unit of Measure") then
                            UOMDesc := UOMRecG.Description;

                end;

            }

            trigger
            OnPreDataItem()
            begin
                if SelectedYearIntG = 0 then
                    Error('Please Select Year.');

                CompanyInfoRecG.Reset();
                CompanyInfoRecG.Get();

                PreviousYear2 := SelectedYearIntG - 1;
                PreviousYear3 := SelectedYearIntG - 2;

                Evaluate(StartDate1, '0101' + format(SelectedYearIntG));
                Evaluate(StartDate2, '0101' + format(PreviousYear2));
                Evaluate(StartDate3, '0101' + format(PreviousYear3));

                Evaluate(EndDate1, '1231' + format(SelectedYearIntG));
                Evaluate(EndDate2, '1231' + format(PreviousYear2));
                Evaluate(EndDate3, '1231' + format(PreviousYear3));
                ReportHeader := 'PURCHASE COMPARISON  (  ' + Format(PreviousYear3) + '  to  ' + Format(SelectedYearIntG) + '  )';

                if GetFilter("No.") <> '' then
                    FilItemNoTxtG := GetFilter("No.");
                if GetFilter("Inventory Posting Group") <> '' then
                    FilInvPostingTxtG := GetFilter("Inventory Posting Group");
                if GetFilter("Gen. Prod. Posting Group") <> '' then
                    FilGenPostingGroupTxtG := GetFilter("Gen. Prod. Posting Group");
                if GetFilter("Item Category Code") <> '' then
                    FilCategoryTxtG := GetFilter("Item Category Code");


            end;

            trigger
            OnPostDataItem()
            begin
                // Message('%1   %2    %3', SelectedYearIntG, PreviousYear2, PreviousYear3);
                //Message('Start %1 = %2 = %3', StartDate1, StartDate2, StartDate3);
                //Message('End %1  %2  %3', EndDate1, EndDate2, EndDate3);
            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Year Filter")
                {
                    field(" Year"; SelectedYearIntG)
                    {
                        ApplicationArea = All;
                        TableRelation = "Year of Purchase Comp.";
                    }
                }
            }
        }


    }

    labels
    {
        ReportHeaderLBL = 'PURCHASE COMPARISON';
        ItemCodeLBL = 'Item No.';
        ItemDescLBL = 'Description';
        UnitLBL = 'Unit';
        AverageLBL = 'Average';
        B1LBL = '(';
        B2LBL = ')';
        ToLBL = 'to';
        ItemNoLBL = 'Item :';
        InvPostingLBL = 'Posting Group :';
        CategoryLBL = 'Categories :';
        GenPostingGroupLBL = 'Gen.Posting Group :';

    }

    var

        CompanyInfoRecG: Record "Company Information";
        ItemLedgerEntryRecG: Record "Item Ledger Entry";
        UOMRecG: Record "Unit of Measure";
        SelectedYearIntG: Integer;
        PreviousYear2: Integer;
        PreviousYear3: Integer;
        StartDate1: Date;
        StartDate2: Date;
        StartDate3: date;
        EndDate1: Date;
        EndDate2: Date;
        EndDate3: Date;
        QuantityYear1: Decimal;
        QuantityYear2: Decimal;
        QuantityYear3: Decimal;
        ReportHeader: Code[150];
        LastItemCodeG: Code[20];
        LastUOMCodeG: Code[20];
        UOMDesc: Text[100];

        FilItemNoTxtG: Text[250];
        FilInvPostingTxtG: Text[250];
        FilCategoryTxtG: Text[250];
        FilGenPostingGroupTxtG: Text[250];


    procedure FindQuantityBaseOnDates(ItemCodeP: Code[20]; UOMP: Code[20]; StartDateP: Date; EndDateP: Date)
    QtyDecL: Decimal;
    begin
        ItemLedgerEntryRecG.Reset();
        ItemLedgerEntryRecG.SetRange("Item No.", ItemCodeP);
        ItemLedgerEntryRecG.SetRange("Unit of Measure Code", UOMP);
        ItemLedgerEntryRecG.SetFilter("Entry Type", '%1', ItemLedgerEntryRecG."Entry Type"::Purchase);
        ItemLedgerEntryRecG.SetFilter("Posting Date", '%1..%2', StartDateP, EndDateP);
        if ItemLedgerEntryRecG.FindSet() then
            repeat
                QtyDecL += ItemLedgerEntryRecG.Quantity;
            until ItemLedgerEntryRecG.Next() = 0;
    end;


}