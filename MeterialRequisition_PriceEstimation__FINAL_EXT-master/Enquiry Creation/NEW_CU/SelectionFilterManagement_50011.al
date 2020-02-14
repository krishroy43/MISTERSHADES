codeunit 50012 SelectionFilterManagement_1
{
    // version NAVW111.00


    trigger OnRun();
    begin
    end;

    local procedure GetSelectionFilter(var TempRecRef: RecordRef; SelectionFieldID: Integer): Text;
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        FirstRecRef: Text;
        LastRecRef: Text;
        SelectionFilter: Text;
        SavePos: Text;
        TempRecRefCount: Integer;
        More: Boolean;
    begin
        IF TempRecRef.ISTEMPORARY THEN BEGIN
            RecRef := TempRecRef.DUPLICATE;
            RecRef.RESET;
        END ELSE
            RecRef.OPEN(TempRecRef.NUMBER);

        TempRecRefCount := TempRecRef.COUNT;
        IF TempRecRefCount > 0 THEN BEGIN
            TempRecRef.ASCENDING(TRUE);
            TempRecRef.FIND('-');
            WHILE TempRecRefCount > 0 DO BEGIN
                TempRecRefCount := TempRecRefCount - 1;
                RecRef.SETPOSITION(TempRecRef.GETPOSITION);
                RecRef.FIND;
                FieldRef := RecRef.FIELD(SelectionFieldID);
                FirstRecRef := FORMAT(FieldRef.VALUE);
                LastRecRef := FirstRecRef;
                More := TempRecRefCount > 0;
                WHILE More DO
                    IF RecRef.NEXT = 0 THEN
                        More := FALSE
                    ELSE BEGIN
                        SavePos := TempRecRef.GETPOSITION;
                        TempRecRef.SETPOSITION(RecRef.GETPOSITION);
                        IF NOT TempRecRef.FIND THEN BEGIN
                            More := FALSE;
                            TempRecRef.SETPOSITION(SavePos);
                        END ELSE BEGIN
                            FieldRef := RecRef.FIELD(SelectionFieldID);
                            LastRecRef := FORMAT(FieldRef.VALUE);
                            TempRecRefCount := TempRecRefCount - 1;
                            IF TempRecRefCount = 0 THEN
                                More := FALSE;
                        END;
                    END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstRecRef = LastRecRef THEN
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef)
                ELSE
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef) + '..' + AddQuotes(LastRecRef);
                IF TempRecRefCount > 0 THEN
                    TempRecRef.NEXT;
            END;
            EXIT(SelectionFilter);
        END;
    end;

    [Scope('Cloud')]
    procedure AddQuotes(inString: Text[1024]): Text;
    begin
        IF DELCHR(inString, '=', ' &|()*') = inString THEN
            EXIT(inString);
        EXIT('''' + inString + '''');
    end;

    [Scope('Cloud')]
    procedure GetSelectionFilterForSalesHeader(var SalesHeader: Record "Sales Header"): Text;
    var
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE(SalesHeader);
        EXIT(GetSelectionFilter(RecRef, SalesHeader.FIELDNO("No.")));
    end;
}

