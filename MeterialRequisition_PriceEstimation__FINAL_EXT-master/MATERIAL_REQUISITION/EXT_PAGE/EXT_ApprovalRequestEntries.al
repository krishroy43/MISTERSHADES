pageextension 50035 "Ext. Approval Request Entries" extends "Approval Request Entries"
{
    actions
    {
        // Add changes to page actions here
        addafter(Record)
        {
            action("View MR Records")
            {
                ApplicationArea = All;
                Image = Document;
                //RunObject = page "Material Requisition" ;
                //RunPageLink = "Requisition No." = field ("Document No.");
                trigger
                OnAction()
                var
                    MaterialRequisitionHeaderRecL: Record "Material Requisition Header";
                    RecRef: RecordRef;
                begin
                    RecRef.Get("Record ID to Approve");
                    MaterialRequisitionHeaderRecL.Reset();
                    MaterialRequisitionHeaderRecL.SetRange("Requisition No.", RecRef.FieldIndex(1).Value());
                    if MaterialRequisitionHeaderRecL.FindFirst() then
                        Page.RunModal(50005, MaterialRequisitionHeaderRecL);

                end;

            }
        }
    }

}