pageextension 50022 "Ext. SalesRelationship Mgr. RC" extends "Sales & Relationship Mgr. RC"
{


    actions
    {
        modify(Opportunities)
        {
            Caption = 'Sales Enquiry';
            ApplicationArea = All;
            Promoted = true;
            PromotedIsBig = true;

        }
        addafter(Opportunities)
        {
            action("Estimations")
            {
                Caption = 'Estimation';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = page "Estimation Header Page";
            }
            action("Product/Fabric Type")
            {
                Caption = 'Estimation';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = page "Product Type List";
            }
            action("Job Task Master")
            {
                Caption = 'Estimation';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = page "job task Master";
            }

        }
    }


}

