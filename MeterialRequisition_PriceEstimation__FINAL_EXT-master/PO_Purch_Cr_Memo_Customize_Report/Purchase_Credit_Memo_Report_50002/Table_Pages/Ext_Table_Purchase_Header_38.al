// tableextension 50900 "Ext Purchase Header" extends "Purchase Header"
// {
//     fields
//     {
//         field(50900; Narration; text[250])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }
// // // }
// // pageextension 50900 "Purchase Credit Memo" extends "Purchase Credit Memo"
// // {
// //     layout
// //     {
// //         addafter("Expected Receipt Date")
// //         {
// //             field(Narration; Narration)
// //             {
// //                 ApplicationArea = All;
// //             }
// //         }
// //     }
// // }