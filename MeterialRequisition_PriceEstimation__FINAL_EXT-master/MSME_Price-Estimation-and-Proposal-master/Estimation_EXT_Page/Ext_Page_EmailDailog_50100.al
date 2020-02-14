/*

pageextension 50112 "Ext Email Dailog" extends "Email Dialog"
{
    var
        DocNoCodeG: Code[20];
        DocTypeCodeG: Code[20];

    trigger
    OnOpenPage()
    begin
        Message('on open page fun   %1     %2', DocNoCodeG, DocTypeCodeG);
    end;

    procedure SetValueGlobal(DocNo: Code[20]; DocType: Code[20])
    begin
        Message('inside fun   %1     %2', DocNoCodeG, DocTypeCodeG);
        DocNoCodeG := DocNo;
        DocTypeCodeG := DocType;
    end;

    trigger
    OnQueryClosePage(CloseAction: Action): Boolean
    var
        OppRecL: Record Opportunity;
        SalesHeaderRecL: Record "Sales Header";
    begin
        Message(' on Qry closed %1     %2', DocNoCodeG, DocTypeCodeG);
        SalesHeaderRecL.Reset();
        if SalesHeaderRecL.Get(DocTypeCodeG, DocNoCodeG) then begin
            OppRecL.Reset();
            if OppRecL.Get(SalesHeaderRecL."Opportunity No.") then begin
                OppRecL."MSME Status" := OppRecL."MSME Status"::"Quotation sent";
                OppRecL.Modify();
                Message('Satus updates');
            end;
        end;
    end;

}
*/