// tableextension 50901 "Ext Purch. Cr. Memo Hdr." extends "Purch. Cr. Memo Hdr."
// {
//     fields
//     {
//         field(50900; Narration; text[250])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }
// }
pageextension 50901 "Ext Posted Purch Credit Memo" extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Vendor Cr. Memo No.")
        {
            field(Narration; Narration)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}