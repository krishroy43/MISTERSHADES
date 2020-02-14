// page 50440 "Archieved Job Card"
// {
//     SourceTable = "Archieved Job";
//     PageType = Card;
//     InsertAllowed = false;
//     DelayedInsert = false;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     Editable = false;
//     Caption = 'Archieved Job';

//     layout
//     {
        


//         field("No.";"No.")
//         {
//             Caption = 'No.';

//         }
//         field("Search Description";"Search Description")
//         {
//             Caption = 'Search Description';
//         }
//         field(Description;Description)
//         {
//             Caption = 'Description';

//         }
//         field("Description "; )
//         {
//             Caption = 'Description ';
//         }
//         field("Bill-to Customer No."; )
//         {
//             Caption = 'Bill-to Customer No.';
//             TableRelation = Customer;


//         }
//         field("Creation ";"Creation " )
//         {
//             Caption = 'Creation ';
//             Editable = false;
//         }
//         field("Starting "; "Starting ")
//         {
//             Caption = 'Starting ';


//         }
//         field("Ending Date";"Ending Date")
//         {
//             Caption = 'Ending ';


//         }
//         field(Status; )
//         {
//             Caption = 'Status';
           


//         }
//         field("Person Responsible";)
//         {
//             Caption = 'Person Responsible';
          
//         }
//         field( "Global Dimension  Code"; )
//         {
//             CaptionClass = ',,';
//             Caption = 'Global Dimension  Code';



//         }
//         field(; "Global Dimension  Code"; )
//         {
//             CaptionClass = ',,';
//             Caption = 'Global Dimension  Code';



//         }
//         field(; "Job Posting Group"; )
//         {
//             Caption = 'Job Posting Group';
//             TableRelation = "Job Posting Group";
//         }
//         field(; Blocked; )
//         {
//             Caption = 'Blocked';
//             Caption = ' ,Posting,All';
//             Members = " ",Posting,All;
//         }
//         field(; "Last  Modified"; )
//         {
//             Caption = 'Last  Modified';
//             Editable = false;
//         }
//         field(; Comment; )
//         {
//             CalcFormula = Exist ("Comment Line" WHERE ("Table Name" = CONST (Job), "No." = FIELD ("No.")));
//             Caption = 'Comment';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Customer Disc. Group"; )
//         {
//             Caption = 'Customer Disc. Group';
//             TableRelation = "Customer Discount Group";
//         }
//         field(; "Customer Price Group"; )
//         {
//             Caption = 'Customer Price Group';
//             TableRelation = "Customer Price Group";
//         }
//         field(; "Language Code"; )
//         {
//             Caption = 'Language Code';
//             TableRelation = Language;
//         }
//         field(; "Scheduled Res. Qty."; )
//         {

//             Caption = 'Scheduled Res. Qty.';
//             Places =  : ;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Resource Filter"; )
//         {
//             Caption = 'Resource Filter';
//             FieldClass = FlowFilter;
//             TableRelation = Resource;
//         }
//         field(; "Posting  Filter"; )
//         {
//             Caption = 'Posting  Filter';
//             FieldClass = FlowFilter;
//         }
//         field(; "Resource Gr. Filter"; )
//         {
//             Caption = 'Resource Gr. Filter';
//             FieldClass = FlowFilter;
//             TableRelation = "Resource Group";
//         }
//         field(; "Scheduled Res. Gr. Qty."; )
//         {

//             Caption = 'Scheduled Res. Gr. Qty.';
//             Places =  : ;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; Picture; )
//         {
//             Caption = 'Picture';
//             ObsoleteReason = 'Replaced by Image field';
//             ObsoleteState = Pending;
//             SubType = Bitmap;
//         }
//         field(; "Bill-to Name"; )
//         {
//             Caption = 'Bill-to Name';
//         }
//         field(; "Bill-to Address"; )
//         {
//             Caption = 'Bill-to Address';
//         }
//         field(; "Bill-to Address "; )
//         {
//             Caption = 'Bill-to Address ';
//         }
//         field(; "Bill-to City"; )
//         {
//             Caption = 'Bill-to City';

//         }
//         field(; "Bill-to County"; )
//         {

//             Caption = 'Bill-to County';
//         }
//         field(; "Bill-to Post Code"; )
//         {
//             Caption = 'Bill-to Post Code';

//         }
//         field(; "No. Series"; )
//         {
//             Caption = 'No. Series';
//             Editable = false;
//             TableRelation = "No. Series";
//         }
//         field(; "Bill-to Country/Region Code"; )
//         {
//             Caption = 'Bill-to Country/Region Code';
//             Editable = true;

//         }
//         field(; "Bill-to Name "; )
//         {
//             Caption = 'Bill-to Name ';
//         }
//         field(; Reserve; )
//         {
//             AccessByPermission = TableData  = R;
//             Caption = 'Reserve';
//             Caption = 'Never,al,Always';
//             Members = Never,al,Always;
//         }
//         field(; Image; Media)
//         {
//             Caption = 'Image';
//         }
//         field(; "WIP Method"; )
//         {
//             Caption = 'WIP Method';

//         }
//         field(; "Currency Code"; )
//         {
//             Caption = 'Currency Code';
//             TableRelation = Currency;


//         }
//         field(; "Bill-to Contact No."; )
//         {
//             AccessByPermission = TableData  = R;
//             Caption = 'Bill-to Contact No.';


//         }
//         field(; "Bill-to Contact"; )
//         {
//             Caption = 'Bill-to Contact';
//         }
//         field(; "Planning  Filter"; )
//         {
//             Caption = 'Planning  Filter';
//             FieldClass = FlowFilter;
//         }
//         field(; "Total WIP Cost Amount"; )
//         {
//             AutoFormatType = ;
//             Caption = 'Total WIP Cost Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Total WIP Cost G/L Amount"; )
//         {
//             Caption = 'Total WIP Cost G/L Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "WIP Entries Exist"; )
//         {

//             Caption = 'WIP Entries Exist';
//             FieldClass = FlowField;
//         }
//         field(; "WIP Posting "; )
//         {
//             Caption = 'WIP Posting ';
//             Editable = false;
//         }
//         field(; "WIP G/L Posting "; )
//         {

//             Caption = 'WIP G/L Posting ';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Invoice Currency Code"; )
//         {
//             Caption = 'Invoice Currency Code';
//             TableRelation = Currency;

//             trigger OnVali()
//             begin
//                 IF "Invoice Currency Code" <> '' THEN
//                     VALI("Currency Code", '');
//             end;
//         }
//         field(; "Exch. Calculation (Cost)"; )
//         {
//             Caption = 'Exch. Calculation (Cost)';
//             Caption = 'Fixed FCY,Fixed LCY';
//             Members = "Fixed FCY","Fixed LCY";
//         }
//         field(; "Exch. Calculation (Price)"; )
//         {
//             Caption = 'Exch. Calculation (Price)';
//             Caption = 'Fixed FCY,Fixed LCY';
//             Members = "Fixed FCY","Fixed LCY";
//         }
//         field(; "Allow Schedule/Contract Lines"; )
//         {
//             Caption = 'Allow Budget/Billable Lines';
//         }
//         field(; Complete; )
//         {
//             Caption = 'Complete';


//         }
//         field(; "Recog. Sales Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Recog. Sales Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Recog. Sales G/L Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Recog. Sales G/L Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Recog. Costs Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Recog. Costs Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Recog. Costs G/L Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Recog. Costs G/L Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field( "Total WIP Sales Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Total WIP Sales Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Total WIP Sales G/L Amount"; )
//         {
//             AutoFormatType = ;
//             Caption = 'Total WIP Sales G/L Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "WIP Completion Calculated"; )
//         {

//             Caption = 'WIP Completion Calculated';
//             FieldClass = FlowField;
//         }
//         field(; "Next Invoice "; )
//         {

//             Caption = 'Next Invoice ';
//             FieldClass = FlowField;
//         }
//         field(; "Apply Usage Link"; )
//         {
//             Caption = 'Apply Usage Link';


//         }
//         field(; "WIP Warnings"; )
//         {

//             Caption = 'WIP Warnings';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "WIP Posting Method"; )
//         {
//             Caption = 'WIP Posting Method';
//             Caption = 'Per Job,Per Job Ledger Entry';
//             Members = "Per Job","Per Job Ledger Entry";


//         }
//         field(; "Applied Costs G/L Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Applied Costs G/L Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Applied Sales G/L Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Applied Sales G/L Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Calc. Recog. Sales Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Calc. Recog. Sales Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Calc. Recog. Costs Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Calc. Recog. Costs Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Calc. Recog. Sales G/L Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Calc. Recog. Sales G/L Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "Calc. Recog. Costs G/L Amount"; )
//         {
//             AutoFormatType = ;

//             Caption = 'Calc. Recog. Costs G/L Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(; "WIP Completion Posted"; )
//         {

//             Caption = 'WIP Completion Posted';
//             FieldClass = FlowField;
//         }
//         field(; "Over Budget"; )
//         {
//             Caption = 'Over Budget';
//         }
//         field(; "Project Manager"; Code[])
//         {
//             Caption = 'Project Manager';
//             TableRelation = "User Setup";
//         }

//         field(; "Customer PO No."; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Project Location"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Recipients Name"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Product Type"; )
//         {
//             TableRelation = "Product Type";
//         }

//         field(; "Sales Quote"; )
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Sales Header"."No." where ("Document Type" = const (Quote));
//         }
//         field(; "Sales Enquiry"; )
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Opportunity;
//         }

//         field(; "Approved Drawing"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Material Mill Certificat"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Painting Technical Data"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Operation and Maintnc Manual"; )
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Operation & Maintenance Manual';
//         }
//         field(; "As Built Drawing"; )
//         {
//             DataClassification = ToBeClassified;
//         }

//         field(; "Apprv. Struct. Design Calc."; )
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Approved Structural Design Calculation';
//         }
//         field(; "Welding Statement"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Elcomtr Calibrt. Certi. Paint"; )
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Elcometer Calibration Certificate for Painting';
//         }
//         field(; "Erection Method Statement"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Painting Method Statement"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Magnetic Particle Test Report"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Painting Report DFT"; )
//         {
//             DataClassification = ToBeClassified;
//         }

//         field(; Finance; )
//         {
//             DataClassification = ToBeClassified;



//         }
//         field(; "Site Project manager"; )
//         {
//             DataClassification = ToBeClassified;

//         }

//         field(; Procurement; )
//         {
//             DataClassification = ToBeClassified;

//         }
//         field( "Quantity Surveyor"; )
//         {
//             DataClassification = ToBeClassified;

//         }


//         field(; " Material Finalization"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Phy. and Material Approval"; )
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Physical and Material Approval';
//         }
//         field(; "Shop Drawing Approval"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Prototype Requested"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Proforma Invoice created"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Standard"; )
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(; "Standard "; )
//         {
//             DataClassification = ToBeClassified;
//         }

//         field(; "Job Type"; )
//         {
//             Members = " ","Job in Hand",Project,"Tender Job","General Jobs",Trading;
//         }

//         field(; "Scope Of Work "; )
//         {
//             Caption = 'Scope Of Work';

//         }
//         field(; "Scope Of Work "; )
//         {

//         }
//         field(; "Contract Ref."; )
//         {

//         }
//         field(; "Customer Po. ."; )
//         {

//         }
//         field(; "Workflow Status"; )
//         {

//             Members = "Open","Pending for Approval","Released";

//         }
//         // Stop SRNo.
//         field(; "Salesperson Code"; )
//         {
//             TableRelation = "Salesperson/Purchaser";
//         }
//         field(; "Completion "; )
//         {

//         }
//         field(; "Project Amount (Planned)"; )
//         {
//             Caption = 'Project Amount (Planned)';
            
//         }

//         field(; "Advance Received"; )
//         {
//             Editable = false;
//         }

//         field(; "Advance Amount"; )
//         {

//         }
//         field(; "Archieved Version No."; Integer)
//         {

//         }



    
//     }


// }