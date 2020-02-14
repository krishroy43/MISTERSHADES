page 50028 "Sales MSME RC"
{
    // version NAVW113.00

    Caption = 'Sales RC', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part("Headline RC Relationship Mgt."; "Headline RC Relationship Mgt.")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("Sales Pipeline Chart"; "Sales Pipeline Chart")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("Opportunity Chart"; "Opportunity Chart")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("Sales & Relationship Mgr. Act."; "Sales & Relationship Mgr. Act.")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("Team Member Activities"; "Team Member Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("Relationship Performance"; "Relationship Performance")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("Power BI Report Spinner Part"; "Power BI Report Spinner Part")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Customer - &Order Summary")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Customer - &Order Summary';
                Image = "Report";
                RunObject = Report "Customer - Order Summary";
                ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
            }
            action("Customer - &Top 10 List")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Customer - &Top 10 List';
                Image = "Report";
                RunObject = Report "Customer - Top 10 List";
                ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
            }

            action("S&ales Statistics")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'S&ales Statistics';
                Image = "Report";
                RunObject = Report "Sales Statistics";
                ToolTip = 'View detailed information about sales to your customers.';
            }
            action("Salesperson - Sales &Statistics")
            {
                ApplicationArea = Suite, RelationshipMgmt;
                Caption = 'Salesperson - Sales &Statistics';
                Image = "Report";
                RunObject = Report "Salesperson - Sales Statistics";
                ToolTip = 'View amounts for sales, profit, invoice discount, and payment discount, as well as profit percentage, for each salesperson for a selected period. The report also shows the adjusted profit and adjusted profit percentage, which reflect any changes to the original costs of the items in the sales.';
            }
            action("Salesperson - &Commission")
            {
                ApplicationArea = Suite, RelationshipMgmt;
                Caption = 'Salesperson - &Commission';
                Image = "Report";
                RunObject = Report "Salesperson - Commission";
                ToolTip = 'View a list of invoices for each salesperson for a selected period. The following information is shown for each invoice: Customer number, sales amount, profit amount, and the commission on sales amount and profit amount. The report also shows the adjusted profit and the adjusted profit commission, which are the profit figures that reflect any changes to the original costs of the goods sold.';
            }

            action("Campaign - &Details")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Campaign - &Details';
                Image = "Report";
                RunObject = Report "Campaign - Details";
                ToolTip = 'Show detailed information about the campaign.';
            }
        }
        area(embedding)
        {
            action(Contactes)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Contacts';
                Image = CustomerContact;
                RunObject = Page "Contact List";
                ToolTip = 'View a list of all your contacts.';
            }
            action(Opportunitiese)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Opportunities';
                RunObject = Page "Opportunity List";
                ToolTip = 'View the sales opportunities that are handled by salespeople for the contact. Opportunities must involve a contact and can be linked to campaigns.';
            }
            action("Sales Quotese")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
            }
            action("Sales Orderes")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
            }
            action(Customeres)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action(Itemes)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Active Segments")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Active Segments';
                RunObject = Page "Segment List";
                ToolTip = 'View the list of active segments. Segments represent a grouping of contacts, so that you can interact with several contacts at once, for example by direct mail.';
            }
            action("Logged Segments")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Logged Segments';
                RunObject = Page 5139;
                ToolTip = 'View the list of segments containing contacts for which you have logged interactions. Segments represent a grouping of contacts, so that you can interact with several contacts at once, for example by direct mail.';
            }
            action(Campaignes)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Campaigns';
                Image = Campaign;
                RunObject = Page "Campaign List";
                ToolTip = 'View a list of all your campaigns.';
            }
            action("Cases - Dynamics 365 for Customer Service")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Cases - Dynamics 365 for Customer Service';
                RunObject = Page "CRM Case List";
                ToolTip = 'View the list of cases that you manage with Microsoft Dynamics 365 for Customer Service.';
            }
            action(Salespersones)
            {
                ApplicationArea = Suite, RelationshipMgmt;
                Caption = 'Salespersons';
                RunObject = Page "Salespersons/Purchasers";
                ToolTip = 'View or edit information about the sales people that work for you and which customers they are assigned to.';
            }
            action(Jobes)
            {
                ApplicationArea = Jobs;
                Caption = 'Jobs';
                Image = Job;
                RunObject = Page "Job List";
                ToolTip = 'Define a project activity by creating a job card with integrated job tasks and job planning lines, structured in two layers. The job task enables you to set up job planning lines and to post consumption to the job. The job planning lines specify the detailed use of resources, items, and various general ledger expenses.';
            }
            action(JobsOnOrder)
            {
                ApplicationArea = Jobs;
                Caption = 'Open';
                RunObject = Page "Job List";
                RunPageView = WHERE (Status = FILTER (Open));
                ToolTip = 'Open the card for the selected record.';
            }
            action(JobsPlannedAndQuoted)
            {
                ApplicationArea = Jobs;
                Caption = 'Planned and Quoted';
                RunObject = Page "Job List";
                RunPageView = WHERE (Status = FILTER (Quote | Planning));
                ToolTip = 'View all planned and quoted jobs.';
            }
            action(JobsCompleted)
            {
                ApplicationArea = Jobs;
                Caption = 'Completed';
                RunObject = Page "Job List";
                RunPageView = WHERE (Status = FILTER (Completed));
                ToolTip = 'View all completed jobs.';
            }
            action(JobsUnassigned)
            {
                ApplicationArea = Jobs;
                Caption = 'Unassigned';
                RunObject = Page "Job List";
                RunPageView = WHERE ("Person Responsible" = FILTER (''));
                ToolTip = 'View all unassigned jobs.';
            }
            action("Job Tasks")
            {
                ApplicationArea = Suite;
                Caption = 'Job Tasks';
                RunObject = Page "Job Task List";
                ToolTip = 'Define the various tasks involved in a job. You must create at least one job task per job because all posting refers to a job task. Having at least one job task in your job enables you to set up job planning lines and to post consumption to the job.';
            }
            action("Sales Invoices")
            {
                ApplicationArea = Jobs;
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
            }
            action("Sales Credit Memos")
            {
                ApplicationArea = Jobs;
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
                ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
            }
            action("Purchase Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Purchase Invoices")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Purchase Credit Memos")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Credit Memos';
                RunObject = Page "Purchase Credit Memos";
                ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
            }
            action(Resources)
            {
                ApplicationArea = Jobs;
                Caption = 'Resources';
                RunObject = Page "Resource List";
                ToolTip = 'Manage your resources'' job activities by setting up their costs and prices. The job-related prices, discounts, and cost factor rules are set up on the respective job card. You can specify the costs and prices for individual resources, resource groups, or all available resources of the company. When resources are used or sold in a job, the specified prices and costs are recorded for the project.';
            }
            action("Resource Groups")
            {
                ApplicationArea = Suite;
                Caption = 'Resource Groups';
                RunObject = Page "Resource Groups";
                ToolTip = 'View all resource groups.';
            }
            action(Iteems)
            {
                ApplicationArea = Jobs;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action(Customeers)
            {
                ApplicationArea = Jobs;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("Time Sheets")
            {
                ApplicationArea = Jobs;
                Caption = 'Time Sheets';
                RunObject = Page "Time Sheet List";
                ToolTip = 'Enable resources to register time. When approved, if approval is required, time sheet entries can be posted to the relevant job journal or resource journal as part of project progress reporting. To save setup time and to ensure data correctness, you can copy job planning lines into time sheets.';
            }
            action("Page Manager Time Sheets")
            {
                ApplicationArea = Jobs;
                Caption = 'Manager Time Sheets';
                RunObject = Page "Manager Time Sheet List";
                ToolTip = 'Approve or reject your resources'' time sheet entries in a window that contains lines for all time sheets that resources have submitted for review.';
            }
        }
        area(sections)
        {
            group(Sales)
            {
                Caption = 'Sales';
                action(Conteacts)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Contacts';
                    Image = CustomerContact;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Contact List";
                    ToolTip = 'View or edit detailed information about the contact persons at your business partners that you use to communicate business activities with or that you target marketing activities towards.';
                }
                action(Opportunities)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Opportunities';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Opportunity List";
                    ToolTip = 'View the sales opportunities that are handled by salespeople for the contact. Opportunities must involve a contact and can be linked to campaigns.';
                }
                action("Sales Quotes")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Sales Quotes';
                    Image = Quote;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Quotes";
                    ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
                }
                action("Sales Orders")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Sales Orders';
                    Image = "Order";
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action("Blanket Sales Orders")
                {
                    ApplicationArea = Suite, RelationshipMgmt;
                    Caption = 'Blanket Sales Orders';
                    Image = Reminder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Blanket Sales Orders";
                    ToolTip = 'Use blanket sales orders as a framework for a long-term agreement between you and your customers to sell large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a sales order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
                }
                action(Cusetomers)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Customers';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action(Items)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Items';
                    Image = Item;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
                }
                action(Segments)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Segments';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Segment List";
                    ToolTip = 'View the list of segments that are currently used in active campaigns. Segments represent a grouping of contacts, so that you can interact with several contacts at once, for example by direct mail.';
                }
                action(Campaigns)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Campaigns';
                    Image = Campaign;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Campaign List";
                    ToolTip = 'View the list of your marketing campaigns. A campaign organizes all the sales and marketing activities involving your contacts, such as a sales promotion campaign.';
                }
                action(Salespersons)
                {
                    ApplicationArea = Suite, RelationshipMgmt;
                    Caption = 'Salespersons';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Salespersons/Purchasers";
                    ToolTip = 'View or edit information about the sales people that work for you and which customers they are assigned to.';
                }
            }
            group("Administration Sales/Purchase")
            {
                Caption = 'Administration Sales/Purchase';
                Image = AdministrationSalesPurchases;
                action("Salespeople/Purchasers")
                {
                    ApplicationArea = Suite, RelationshipMgmt;
                    Caption = 'Salespeople/Purchasers';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Salespersons/Purchasers";
                    ToolTip = 'View or edit information about the sales people and purchasers that work for you and which customers and vendors they are assigned to.';
                }
                action("Customer Price Groups")
                {
                    ApplicationArea = Suite, RelationshipMgmt;
                    Caption = 'Customer Price Groups';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Price Groups";
                    ToolTip = 'View a list of your customer price groups.';
                }
                action("Cust. Invoice Discounts")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Cust. Invoice Discounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Cust. Invoice Discounts";
                    ToolTip = 'View or edit invoice discounts that you grant to certain customers.';
                }
                action("Vend. Invoice Discounts")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Vend. Invoice Discounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vend. Invoice Discounts";
                    ToolTip = 'View the invoice discounts that your vendors grant you.';
                }
                action("Item Disc. Groups")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Item Disc. Groups';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Disc. Groups";
                    ToolTip = 'View or edit discount group codes that you can use as criteria when you grant special discounts to customers.';
                }
                action("Sales Cycles")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Sales Cycles';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Cycles";
                    ToolTip = 'View the different sales cycles that you use to manage sales opportunities.';
                }
            }
            group(Analysis)
            {
                Caption = 'Analysis';
                action("Sales Analysis Reports")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Analysis Reports';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Analysis Report Sale";
                    ToolTip = 'Analyze the dynamics of your sales according to key sales performance indicators that you select, for example, sales turnover in both amounts and quantities, contribution margin, or progress of actual sales against the budget. You can also use the report to analyze your average sales prices and evaluate the sales performance of your sales force.';
                }
                action("Sales Analysis by Dimensions")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Sales Analysis by Dimensions';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Analysis View List Sales";
                    ToolTip = 'View sales amounts in G/L accounts by their dimension values and other filters that you define in an analysis view and then show in a matrix window.';
                }
                action("Sales Budgets")
                {
                    ApplicationArea = SalesBudget;
                    Caption = 'Sales Budgets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Budget Names Sales";
                    ToolTip = 'Enter item sales values of type amount, quantity, or cost for expected item sales in different time periods. You can create sales budgets by items, customers, customer groups, or other dimensions in your business. The resulting sales budgets can be reviewed here or they can be used in comparisons with actual sales data in sales analysis reports.';
                }
                action(Contacts)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Contacts';
                    Image = CustomerContact;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Contact List";
                    ToolTip = 'View a list of all your contacts.';
                }
                action(Customers)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Customers';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
            }
            group(Jeoebs)
            {
                Caption = 'Jobs';
                Image = Job;
                ToolTip = 'Create, plan, and execute tasks in project management. ';
                action(Jeobs)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Jobs';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Job List";
                    ToolTip = 'Define a project activity by creating a job card with integrated job tasks and job planning lines, structured in two layers. The job task enables you to set up job planning lines and to post consumption to the job. The job planning lines specify the detailed use of resources, items, and various general ledger expenses.';
                }
                action(Open)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Open';
                    RunObject = Page "Job List";
                    RunPageView = WHERE (Status = FILTER (Open));
                    ToolTip = 'Open the card for the selected record.';
                }
                action(JobsPlannedAndQuotd)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Planned and Quoted';
                    RunObject = Page "Job List";
                    RunPageView = WHERE (Status = FILTER (Quote | Planning));
                    ToolTip = 'Open the list of all planned and quoted jobs.';
                }
                action(JobsComplet)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Completed';
                    RunObject = Page "Job List";
                    RunPageView = WHERE (Status = FILTER (Completed));
                    ToolTip = 'Open the list of all completed jobs.';
                }
                action(JobsUnassign)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Unassigned';
                    RunObject = Page "Job List";
                    RunPageView = WHERE ("Person Responsible" = FILTER (''));
                    ToolTip = 'Open the list of all unassigned jobs.';
                }
                action("Job Task's")
                {
                    ApplicationArea = Suite;
                    Caption = 'Job Tasks';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Job Task List";
                    ToolTip = 'Open the list of ongoing job tasks. Job tasks represent the actual work that is performed in a job, and they enable you to set up job planning lines and to post consumption to the job.';
                }
                action("Job Register's")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Job Registers';
                    Image = JobRegisters;
                    RunObject = Page "Job Registers";
                    ToolTip = 'View auditing details for all job ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
                action("Job Planning Lines")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Job Planning Lines';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Job Planning Lines";
                    ToolTip = 'Open the list of ongoing job planning lines for the job. You use this window to plan what items, resources, and general ledger expenses that you expect to use on a job (budget) or you can specify what you actually agreed with your customer that he should pay for the job (billable).';
                }
                action(JobJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Job Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Job Journal Batches";
                    RunPageView = WHERE (Recurring = CONST (false));
                    ToolTip = 'Record job expenses or usage in the job ledger, either by reusing job planning lines or by manual entry.';
                }
                action(JobGLJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Job G/L Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE ("Template Type" = CONST (Jobs),
                                        Recurring = CONST (false));
                    ToolTip = 'Record job expenses or usage in job accounts in the general ledger. For expenses or usage of type G/L Account, use the job G/L journal instead of the job journal.';
                }
                action(RecurringJobJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Recurring Job Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Job Journal Batches";
                    RunPageView = WHERE (Recurring = CONST (true));
                    ToolTip = 'Reuse preset journal lines to record recurring job expenses or usage in the job ledger.';
                }
                action("Sales Invoice's")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Sales Invoices';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
                }
                action("Purchase Invoice's")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Invoices';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Invoices";
                    ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
            }
            group(Resourcese)
            {
                Caption = 'Resources';
                Image = Journals;
                ToolTip = 'Manage the people or machines that are used to perform job tasks. ';
                action(Resourcees)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resources';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource List";
                    ToolTip = 'Manage your resources'' job activities by setting up their costs and prices. The job-related prices, discounts, and cost factor rules are set up on the respective job card. You can specify the costs and prices for individual resources, resource groups, or all available resources of the company. When resources are used or sold in a job, the specified prices and costs are recorded for the project.';
                }
                action("Resource Groupse")
                {
                    ApplicationArea = Suite;
                    Caption = 'Resource Groups';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource Groups";
                    ToolTip = 'Organize resources in groups, such as Consultants, for easier assignment of common values and to analyze financial figures by groups.';
                }
                action(ResourceJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resource Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource Jnl. Batches";
                    RunPageView = WHERE (Recurring = CONST (false));
                    ToolTip = 'Post usage and sales of your resources for internal use and statistics. Use time sheet entries as input. Note that unlike with job journals, entries posted with resource journals are not posted to G/L accounts.';
                }
                action(RecurringResourceJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Recurring Resource Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource Jnl. Batches";
                    RunPageView = WHERE (Recurring = CONST (true));
                    ToolTip = 'Post recurring usage and sales of your resources for internal use and statistics in a journal that is preset for your usual posting.';
                }
                action("Resource Registerfs")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resource Registers';
                    Image = ResourceRegisters;
                    RunObject = Page "Resource Registers";
                    ToolTip = 'View auditing details for all resource ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
            }
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                ToolTip = 'Post entries directly to G/L accounts.';
                action(ItemJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Item Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE ("Template Type" = CONST (Item), Recurring = CONST (false));
                    ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
                }
                action(RecurringItemJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Recurring Item Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE ("Template Type" = CONST (Item), Recurring = CONST (true));
                    ToolTip = 'Post recurring item transactions directly to the item ledger in a journal that is preset for your usual posting.';
                }
            }
            group("Timee Sheet's")
            {
                Caption = 'Time Sheets';
                Image = Journals;
                ToolTip = 'Manage time sheets for resources.';
                action("Tieme Sheet's")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Time Sheets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Time Sheet List";
                    ToolTip = 'Approve or reject your resources'' time sheet entries in a window that contains lines for all time sheets that resources have submitted for review.';
                }
                action("Manager Time Sheets")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Manager Time Sheets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Manager Time Sheet List";
                    ToolTip = 'Open the list of your time sheets.';
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View the posting history for sales, shipments, and inventory.';
                action("Posted Shipments")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Posted Shipments';
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Open the list of posted shipments.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("G/L Registers")
                {
                    ApplicationArea = Jobs;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                    ToolTip = 'View auditing details for all G/L entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
                action("Job Registers")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Job Registers';
                    Image = JobRegisters;
                    RunObject = Page "Job Registers";
                    ToolTip = 'View auditing details for all item ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
                action("Item Registers")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Item Registers';
                    Image = ItemRegisters;
                    RunObject = Page "Item Registers";
                    ToolTip = 'View auditing details for all item ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
                action("Resource Registers")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resource Registers';
                    Image = ResourceRegisters;
                    RunObject = Page "Resource Registers";
                    ToolTip = 'View auditing details for all resource ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
            }
            group("Self-Service")
            {
                Caption = 'Self-Service';
                Image = HumanResources;
                ToolTip = 'Manage your time sheets and assignments.';
                action("Time Sheet's")
                {
                    ApplicationArea = Suite;
                    Caption = 'Time Sheets';
                    Gesture = None;
                    RunObject = Page "Time Sheet List";
                    ToolTip = 'Approve or reject your resources'' time sheet entries in a window that contains lines for all time sheets that resources have submitted for review.';
                }
                action("Page Time Sheet List Open")
                {
                    ApplicationArea = Suite;
                    Caption = 'Open';
                    RunObject = Page "Time Sheet List";
                    RunPageView = WHERE ("Open Exists" = CONST (true));
                    ToolTip = 'Open the card for the selected record.';
                }
                action("Page Time Sheet List Submitted")
                {
                    ApplicationArea = Suite;
                    Caption = 'Submitted';
                    RunObject = Page "Time Sheet List";
                    RunPageView = WHERE ("Submitted Exists" = CONST (true));
                    ToolTip = 'Open the list of submitted time sheets.';
                }
                action("Page Time Sheet List Rejected")
                {
                    ApplicationArea = Suite;
                    Caption = 'Rejected';
                    RunObject = Page "Time Sheet List";
                    RunPageView = WHERE ("Rejected Exists" = CONST (true));
                    ToolTip = 'Open the list of rejected time sheets.';
                }
                action("Page Time Sheet List Approved")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approved';
                    RunObject = Page "Time Sheet List";
                    RunPageView = WHERE ("Approved Exists" = CONST (true));
                    ToolTip = 'Open the list of approved time sheets.';
                }
            }
        }
        area(processing)
        {
            group(New)
            {
                Caption = 'New';
                action(NewContact)
                {
                    AccessByPermission = TableData Contact = IMD;
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Contact';
                    Image = AddContacts;
                    RunObject = Page "Contact Card";
                    RunPageMode = Create;
                    ToolTip = 'Create a new contact. Contacts are persons at your business partners that you use to communicate business activities with or that you target marketing activities towards.';
                }
                action(NewOpportunity)
                {
                    AccessByPermission = TableData Opportunity = IMD;
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Opportunity';
                    Image = NewOpportunity;
                    RunObject = Page "Opportunity Card";
                    RunPageMode = Create;
                    ToolTip = 'View the sales opportunities that are handled by salespeople for the contact. Opportunities must involve a contact and can be linked to campaigns.';
                }
                action(NewSegment)
                {
                    AccessByPermission = TableData "Segment Header" = IMD;
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Segment';
                    Image = Segment;
                    RunObject = Page "Segment";
                    RunPageMode = Create;
                    ToolTip = 'Create a new segment where you manage interactions with a contact.';
                }
                action(NewCampaign)
                {
                    AccessByPermission = TableData Campaign = IMD;
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Campaign';
                    Image = Campaign;
                    RunObject = Page "Campaign Card";
                    RunPageMode = Create;
                    ToolTip = 'Create a new campaign';
                }
            }
            group("Sales Prices")
            {
                Caption = 'Sales Prices';
                action("Sales Price &Worksheet")
                {
                    AccessByPermission = TableData "Sales Price Worksheet" = IMD;
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Sales Price &Worksheet';
                    Image = PriceWorksheet;
                    RunObject = Page 7023;
                    ToolTip = 'Manage sales prices for individual customers, for a group of customers, for all customers, or for a campaign.';
                }
                action("Sales &Prices")
                {
                    AccessByPermission = TableData 1304 = IMD;
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Sales &Prices';
                    Image = SalesPrices;
                    RunObject = Page 7002;
                    ToolTip = 'Define how to set up sales price agreements. These sales prices can be for individual customers, for a group of customers, for all customers, or for a campaign.';
                }
                action("Sales Line &Discounts")
                {
                    AccessByPermission = TableData 1304 = IMD;
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Sales Line &Discounts';
                    Image = SalesLineDisc;
                    RunObject = Page 7004;
                    ToolTip = 'View or edit sales line discounts that you grant when certain conditions are met, such as customer, quantity, or ending date. The discount agreements can be for individual customers, for a group of customers, for all customers or for a campaign.';
                }
            }
            group(Flow)
            {
                Caption = 'Flow';
                action("Manage Flows")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Manage Flows';
                    Image = Flow;
                    RunObject = Page 6401;
                    ToolTip = 'View or edit automated workflows created with Microsoft Flow.';
                }
            }
        }
    }
}

