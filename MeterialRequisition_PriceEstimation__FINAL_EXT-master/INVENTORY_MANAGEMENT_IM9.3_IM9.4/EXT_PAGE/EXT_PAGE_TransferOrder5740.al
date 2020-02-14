pageextension 50012 "Ext. Transfer Order" extends "Transfer Order"
{
    layout
    {
        addafter(General)
        {
            group("Job")
            {
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job description"; "Job description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Task No"; "Job Task No")
                {
                    ApplicationArea = All;
                }
                field("Job Task Description"; "Job Task Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        addlast(General)
        {
            field(Creator; Creator)
            {
                ApplicationArea = All;
            }
            field(Receiver; Receiver)
            {
                ApplicationArea = All;
            }
        }

    }

}