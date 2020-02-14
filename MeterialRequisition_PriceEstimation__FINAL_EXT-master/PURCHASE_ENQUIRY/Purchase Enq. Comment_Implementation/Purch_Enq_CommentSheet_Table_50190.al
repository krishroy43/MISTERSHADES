table 50190 "Purchase Enq. Comment Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = "","Purchase Enquiry";
            DataClassification = ToBeClassified;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; code; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Comment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Term/Condition"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Text" where ("Term/Condition" = const (true));
            Caption = 'Terms Code';
        }
    }

    keys
    {
        key(PK; "Document Type", "No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure SetUpNewLine()
    var
        PurchEnqCommentLine: Record "Purchase Enq. Comment Line";
    begin
        PurchEnqCommentLine.SETRANGE("Document Type", "Document Type");
        PurchEnqCommentLine.SETRANGE("No.", "No.");
        PurchEnqCommentLine.SETRANGE("Document Line No.", "Document Line No.");
        PurchEnqCommentLine.SETRANGE(Date, WORKDATE);
        IF NOT PurchEnqCommentLine.FINDFIRST THEN
            Date := WORKDATE;
    end;

    procedure CopyComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        PurchCommentLine: Record "Purchase Enq. Comment Line";
        PurchCommentLine2: Record "Purchase Enq. Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := FALSE;
        OnBeforeCopyComments(PurchCommentLine, ToDocumentType, IsHandled);
        IF IsHandled THEN
            EXIT;

        PurchCommentLine.SETRANGE("Document Type", FromDocumentType);
        PurchCommentLine.SETRANGE("No.", FromNumber);
        IF PurchCommentLine.FINDSET THEN
            REPEAT
                PurchCommentLine2 := PurchCommentLine;
                PurchCommentLine2."Document Type" := ToDocumentType;
                PurchCommentLine2."No." := ToNumber;
                PurchCommentLine2.INSERT;
            UNTIL PurchCommentLine.NEXT = 0;
    end;

    procedure DeleteComments(DocType: Option; DocNo: Code[20])
    var
        myInt: Integer;
    begin
        SETRANGE("Document Type", DocType);
        SETRANGE("No.", DocNo);
        IF NOT ISEMPTY THEN
            DELETEALL;
    end;

    procedure ShowComments(DocType: Option; DocNo: Code[20]; DocLineNo: Integer)
    var
        PurchCommentSheet: Page "Purchase Enq. Comment Sheet";
    begin
        SETRANGE("Document Type", DocType);
        SETRANGE("No.", DocNo);
        SETRANGE("Document Line No.", DocLineNo);
        CLEAR(PurchCommentSheet);
        PurchCommentSheet.SETTABLEVIEW(Rec);
        PurchCommentSheet.RUNMODAL;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetUpNewLineVAR(VAR PurchCommentLineRec: Record "Purchase Enq. Comment Line"; VAR PurchCommentLineFilter: Record "Purchase Enq. Comment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyComments(VAR PurchCommentLine: Record "Purchase Enq. Comment Line"; ToDocumentType: Integer; VAR IsHandled: Boolean)
    begin
    end;
}