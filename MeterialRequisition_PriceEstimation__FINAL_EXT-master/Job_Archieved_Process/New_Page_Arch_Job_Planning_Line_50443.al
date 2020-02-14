page 50443 "Arch. Job Planning Lines"
{
    AutoSplitKey = true;
    Caption = 'Archived Job Planning Lines';
    //DataCaptionExpression = Caption;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Outlook';
    SourceTable = "Archieved Job Planning Line";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater("Arch Planning Line")
            {
                field("Archieved Version No."; "Archieved Version No.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the related job.';
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the related job task.';
                    //Visible = JobTaskNoVisible;
                }
                field("Line Type"; "Line Type")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the type of planning line.';
                }
                field("Usage Link"; "Usage Link")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies whether the Usage Link field applies to the job planning line. When this check box is selected, usage entries are linked to the job planning line. Selecting this check box creates a link to the job planning line from places where usage has been posted, such as the job journal or a purchase line. You can select this check box only if the line type of the job planning line is Budget or Both Budget and Billable.';
                    Visible = false;

                    // trigger OnValidate()
                    // begin
                    //     UsageLinkOnAfterValidate;
                    // end;
                }
                field("Planning Date"; "Planning Date")
                {
                    ApplicationArea = Jobs;
                    // Editable = PlanningDateEditable;
                    ToolTip = 'Specifies the date of the planning line. You can use the planning date for filtering the totals of the job, for example, if you want to see the scheduled usage for a specific month of the year.';

                    // trigger OnValidate()
                    // begin
                    //     PlanningDateOnAfterValidate;
                    // end;
                }
                field("Planned Delivery Date"; "Planned Delivery Date")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the date that is planned to deliver the item connected to the job planning line. For a resource, the planned delivery date is the date that the resource performs services with respect to the job.';
                }
                field("Currency Date"; "Currency Date")
                {
                    ApplicationArea = Jobs;
                    //  Editable = CurrencyDateEditable;
                    ToolTip = 'Specifies the date that will be used to find the exchange rate for the currency in the Currency Date field.';
                    Visible = false;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Jobs;
                    //Editable = DocumentNoEditable;
                    ToolTip = 'Specifies a document number for the planning line.';
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the planning line''s entry number.';
                    Visible = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = Jobs;
                    //  Editable = TypeEditable;
                    ToolTip = 'Specifies the type of account to which the planning line relates.';

                    // trigger OnValidate()
                    // begin
                    //     NoOnAfterValidate;
                    // end;
                }
                field("No."; "No.")
                {
                    ApplicationArea = Jobs;
                    //  Editable = NoEditable;
                    ToolTip = 'Specifies the number of the account to which the resource, item or general ledger account is posted, depending on your selection in the Type field.';

                    // trigger OnValidate()
                    // begin
                    //     NoOnAfterValidate;
                    // end;
                }
                field(Description; Description)
                {
                    ApplicationArea = Jobs;
                    // Editable = DescriptionEditable;
                    ToolTip = 'Specifies the name of the resource, item, or G/L account to which this entry applies. You can change the description. A maximum of 50 characters, both numbers and letters, are allowed.';
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = Planning;
                    //  Editable = VariantCodeEditable;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;

                    // trigger OnValidate()
                    // begin
                    //     VariantCodeOnAfterValidate;
                    // end;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Location;
                    //Editable = LocationCodeEditable;
                    ToolTip = 'Specifies a location code for an item.';
                    Visible = false;

                    // trigger OnValidate()
                    // begin
                    //     LocationCodeOnAfterValidate;
                    // end;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    ApplicationArea = Jobs;
                    // Editable = WorkTypeCodeEditable;
                    ToolTip = 'Specifies which work type the resource applies to. Prices are updated based on this entry.';
                    Visible = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = Jobs;
                    //Editable = UnitOfMeasureCodeEditable;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    Visible = false;

                    // trigger OnValidate()
                    // begin
                    //     UnitofMeasureCodeOnAfterValida;
                    // end;
                }
                field(Reserve; Reserve)
                {
                    ApplicationArea = Reservation;
                    ToolTip = 'Specifies whether or not a reservation can be made for items on the current line. The field is not applicable if the Type field is set to Resource, Cost, or G/L Account.';
                    Visible = false;

                    // trigger OnValidate()
                    // begin
                    //     ReserveOnAfterValidate;
                    // end;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of units of the resource, item, or general ledger account that should be specified on the planning line. If you later change the No., the quantity you have entered remains on the line.';

                    // trigger OnValidate()
                    // begin
                    //     QuantityOnAfterValidate;
                    // end;
                }
                field("Reserved Quantity"; "Reserved Quantity")
                {
                    ApplicationArea = Reservation;
                    ToolTip = 'Specifies the quantity of the item that is reserved for the job planning line.';
                    Visible = false;
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the quantity expressed in the base units of measure.';
                    Visible = false;
                }
                field("Remaining Qty."; "Remaining Qty.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the remaining quantity of the resource, item, or G/L Account that remains to complete a job. The quantity is calculated as the difference between Quantity and Qty. Posted.';
                    Visible = false;
                }
                field("Direct Unit Cost (LCY)"; "Direct Unit Cost (LCY)")
                {
                    ApplicationArea = Jobs;
                    Editable = false;
                    ToolTip = 'Specifies the cost, in the local currency, of one unit of the selected item or resource.';
                    Visible = false;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = Jobs;
                    //  Editable = UnitCostEditable;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
                    Visible = false;
                }
                field("Total Cost"; "Total Cost")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the total cost for the planning line. The total cost is in the job currency, which comes from the Currency Code field in the Job Card.';
                }
                field("Remaining Total Cost"; "Remaining Total Cost")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the remaining total cost for the planning line. The total cost is in the job currency, which comes from the Currency Code field in the Job Card.';
                    Visible = false;
                }
                field("Total Cost (LCY)"; "Total Cost (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the total cost for the planning line. The amount is in the local currency.';
                    Visible = false;
                }
                field("Remaining Total Cost (LCY)"; "Remaining Total Cost (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the remaining total cost (LCY) for the planning line. The amount is in the local currency.';
                    Visible = false;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = Jobs;
                    //  Editable = UnitPriceEditable;
                    ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the price, in LCY, of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                    Visible = false;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = Jobs;
                    //Editable = LineAmountEditable;
                    ToolTip = 'Specifies the amount that will be posted to the job ledger.';
                }
                field("Remaining Line Amount"; "Remaining Line Amount")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the amount that will be posted to the job ledger.';
                    Visible = false;
                }
                field("Line Amount (LCY)"; "Line Amount (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the amount in the local currency that will be posted to the job ledger.';
                    Visible = false;
                }
                field("Remaining Line Amount (LCY)"; "Remaining Line Amount (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the amount in the local currency that will be posted to the job ledger.';
                    Visible = false;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    ApplicationArea = Jobs;
                    //  Editable = LineDiscountAmountEditable;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    Visible = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = Jobs;
                    // Editable = LineDiscountPctEditable;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                    Visible = false;
                }
                field("Total Price"; "Total Price")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the total price in the job currency on the planning line.';
                    Visible = false;
                }
                field("Total Price (LCY)"; "Total Price (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the total price on the planning line. The total price is in the local currency.';
                    Visible = false;
                }
                field("Qty. Posted"; "Qty. Posted")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the quantity that has been posted to the job ledger, if the Usage Link check box has been selected.';
                    Visible = false;
                }
                field("Qty. to Transfer to Journal"; "Qty. to Transfer to Journal")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the quantity you want to transfer to the job journal. Its default value is calculated as quantity minus the quantity that has already been posted, if the Apply Usage Link check box has been selected.';
                }
                field("Posted Total Cost"; "Posted Total Cost")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the total cost that has been posted to the job ledger, if the Usage Link check box has been selected.';
                    Visible = false;
                }
                field("Posted Total Cost (LCY)"; "Posted Total Cost (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the total cost (LCY) that has been posted to the job ledger, if the Usage Link check box has been selected.';
                    Visible = false;
                }
                field("Posted Line Amount"; "Posted Line Amount")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the amount that has been posted to the job ledger. This field is only filled in if the Apply Usage Link check box selected on the job card.';
                    Visible = false;
                }
                field("Posted Line Amount (LCY)"; "Posted Line Amount (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the amount in the local currency that has been posted to the job ledger. This field is only filled in if the Apply Usage Link check box selected on the job card.';
                    Visible = false;
                }
                field("Qty. Transferred to Invoice"; "Qty. Transferred to Invoice")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the quantity that has been transferred to a sales invoice or credit memo.';
                    Visible = false;

                    // trigger OnDrillDown()
                    // begin
                    //     DrillDownJobInvoices;
                    // end;
                }
                field("Qty. to Transfer to Invoice"; "Qty. to Transfer to Invoice")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the quantity you want to transfer to the sales invoice or credit memo. The value in this field is calculated as Quantity - Qty. Transferred to Invoice.';
                    Visible = false;
                }
                field("Qty. Invoiced"; "Qty. Invoiced")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the quantity that been posted through a sales invoice.';
                    Visible = false;

                    // trigger OnDrillDown()
                    // begin
                    //     DrillDownJobInvoices;
                    // end;
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                    Visible = false;
                }
                field("Invoiced Amount (LCY)"; "Invoiced Amount (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies, in local currency, the sales amount that was invoiced for this planning line.';

                    // trigger OnDrillDown()
                    // begin
                    //     DrillDownJobInvoices;
                    // end;
                }
                field("Invoiced Cost Amount (LCY)"; "Invoiced Cost Amount (LCY)")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies, in the local currency, the cost amount that was invoiced for this planning line.';
                    Visible = false;

                    // trigger OnDrillDown()
                    // begin
                    //     DrillDownJobInvoices;
                    // end;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                    Visible = false;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = ItemTracking;
                    ToolTip = 'Specifies the serial number that is applied to the posted item if the planning line was created from the posting of a job journal line.';
                    Visible = false;
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = ItemTracking;
                    ToolTip = 'Specifies the lot number that is applied to the posted item if the planning line was created from the posting of a job journal line.';
                    Visible = false;
                }
                field("Job Contract Entry No."; "Job Contract Entry No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the entry number of the job planning line that the sales line is linked to.';
                    Visible = false;
                }
                field("Ledger Entry Type"; "Ledger Entry Type")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the entry type of the job ledger entry associated with the planning line.';
                    Visible = false;
                }
                field("Ledger Entry No."; "Ledger Entry No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the entry number of the job ledger entry associated with the job planning line.';
                    Visible = false;
                }
                field("System-Created Entry"; "System-Created Entry")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies that an entry has been created by Business Central and is related to a job ledger entry. The check box is selected automatically.';
                    Visible = false;
                }
                // field(Overdue; Overdue)
                // {
                //     ApplicationArea = Jobs;
                //     Caption = 'Overdue';
                //     Editable = false;
                //     ToolTip = 'Specifies that the job is overdue. ';
                //     Visible = false;
                // }
            }
        }

    }




}

