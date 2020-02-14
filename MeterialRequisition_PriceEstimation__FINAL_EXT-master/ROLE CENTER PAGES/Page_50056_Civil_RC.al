page 50056 "Civil RC"
{
    Caption = 'Production Planner', Comment = '{Dependency=Match,"ProfileDescription_PRODUCTIONPLANNER"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part("Headline RC Prod. Planner"; "Headline RC Prod. Planner")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Production Planner Activities"; "Production Planner Activities")
            {
                ApplicationArea = Manufacturing;
            }
            part("My Job Queue"; "My Job Queue")
            {
                ApplicationArea = Manufacturing;
                Visible = false;
            }
            part("My Items"; "My Items")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Team Member Activities No Msgs"; "Team Member Activities No Msgs")
            {
                ApplicationArea = Suite;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                ApplicationArea = Manufacturing;
                Visible = false;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = Manufacturing;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Capacity)
            {
                Caption = 'Capacity';
                action("Routing Sheet")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Routing Sheet';
                    Image = "Report";
                    RunObject = Report "Routing Sheet";
                    ToolTip = 'View basic information for routings, such as send-ahead quantity, setup time, run time and time unit. This report shows you the operations to be performed in this routing, the work or machine centers to be used, the personnel, the tools, and the description of each operation.';
                }
                action("Inventory - &Availability Plan")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Inventory - &Availability Plan';
                    Image = ItemAvailability;
                    RunObject = Report "Inventory - Availability Plan";
                    ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
                }
                action("Planning Availability")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Planning Availability';
                    Image = "Report";
                    RunObject = Report "Planning Availability";
                    ToolTip = 'View all known existing requirements and receipts for the items that you select on a specific date. You can use the report to get a quick picture of the current demand-supply situation for an item. The report displays the item number and description plus the actual quantity in inventory.';
                }
                action("Capacity Task List")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Capacity Task List';
                    Image = "Report";
                    RunObject = Report "Capacity Task List";
                    ToolTip = 'View the production orders that are waiting to be processed at the work centers and machine centers. Printouts are made for the capacity of the work center or machine center). The report includes information such as starting and ending time, date per production order and input quantity.';
                }
                action("Subcontractor - Dispatch List")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Subcontractor - Dispatch List';
                    Image = "Report";
                    RunObject = Report "Subcontractor - Dispatch List";
                    ToolTip = 'View the list of material to be sent to manufacturing subcontractors.';
                }
            }
            group(Production)
            {
                Caption = 'Production';
                action("Production Order - &Shortage List")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Production Order - &Shortage List';
                    Image = "Report";
                    RunObject = Report "Prod. Order - Shortage List";
                    ToolTip = 'View a list of the missing quantity per production order. The report shows how the inventory development is planned from today until the set day - for example whether orders are still open.';
                }
                action("D&etailed Calculation")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'D&etailed Calculation';
                    Image = "Report";
                    RunObject = Report "Detailed Calculation";
                    ToolTip = 'View a cost list per item taking into account the scrap.';
                }
                action("P&roduction Order - Calculation")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'P&roduction Order - Calculation';
                    Image = "Report";
                    RunObject = Report "Prod. Order - Calculation";
                    ToolTip = 'View a list of the production orders and their costs, such as expected operation costs, expected component costs, and total costs.';
                }
                action("Sta&tus")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Sta&tus';
                    Image = "Report";
                    RunObject = Report "Status";
                    ToolTip = 'View production orders by status.';
                }
                action("Inventory &Valuation WIP")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Inventory &Valuation WIP';
                    Image = "Report";
                    RunObject = Report "Inventory Valuation - WIP";
                    ToolTip = 'View inventory valuation for selected production orders in your WIP inventory. The report also shows information about the value of consumption, capacity usage and output in WIP.';
                }
            }
        }
        area(embedding)
        {
            action("Demand Forecast")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Demand Forecast';
                RunObject = Page "Demand Forecast Names";
                ToolTip = 'View or edit a demand forecast for your sales items, components, or both.';
            }
            action("Transfer Orders")
            {
                ApplicationArea = Location;
                Caption = 'Transfer Orders';
                Image = Document;
                RunObject = Page "Transfer Orders";
                ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
            }
        }
        area(sections)
        {
            group("Production Orders")
            {
                Caption = 'Production Orders';
                action("Simulated Production Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Simulated Production Orders';
                    RunObject = Page "Simulated Production Orders";
                    ToolTip = 'View the list of ongoing simulated production orders.';
                }
                action("Planned Production Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Planned Production Orders';
                    RunObject = Page "Planned Production Orders";
                    ToolTip = 'View the list of production orders with status Planned.';
                }
                action("Firm Planned Production Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Firm Planned Production Orders';
                    RunObject = Page "Firm Planned Prod. Orders";
                    ToolTip = 'View completed production orders. ';
                }
                action("Released Production Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Released Production Orders';
                    RunObject = Page "Released Production Orders";
                    ToolTip = 'View the list of released production order that are ready for warehouse activities.';
                }
                action("Finished Production Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Finished Production Orders';
                    RunObject = Page "Finished Production Orders";
                    ToolTip = 'View completed production orders. ';
                }
            }
            group("Sales & Purchases")
            {
                Caption = 'Sales & Purchases';
                action("Blanket Sales Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Blanket Sales Orders';
                    RunObject = Page "Blanket Sales Orders";
                    ToolTip = 'Use blanket sales orders as a framework for a long-term agreement between you and your customers to sell large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a sales order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
                }
                action("Sales Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Sales Orders';
                    Image = "Order";
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action("Blanket Purchase Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Blanket Purchase Orders';
                    RunObject = Page "Blanket Purchase Orders";
                    ToolTip = 'Use blanket purchase orders as a framework for a long-term agreement between you and your vendors to buy large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a purchase order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
                }
                action("Purchase Orders")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Purchase Orders';
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
            }
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                action(ItemJournals)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Item Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Item), Recurring = CONST(false));
                    ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
                }
                action(ItemReclassificationJournals)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Item Reclassification Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Transfer), Recurring = CONST(false));
                    ToolTip = 'Change information recorded on item ledger entries. Typical inventory information to reclassify includes dimensions and sales campaign codes, but you can also perform basic inventory transfers by reclassifying location and bin codes. Serial or lot numbers and their expiration dates must be reclassified with the Item Tracking Reclassification journal.';
                }
                action(RevaluationJournals)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Revaluation Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Revaluation), Recurring = CONST(false));
                    ToolTip = 'Change the inventory value of items, for example after doing a physical inventory.';
                }
            }
            group(Worksheets)
            {
                Caption = 'Worksheets';
                Image = Worksheets;
                action(PlanningWorksheets)
                {
                    ApplicationArea = Planning;
                    Caption = 'Planning Worksheets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Req. Wksh. Names";
                    RunPageView = WHERE("Template Type" = CONST(Planning),
                                        Recurring = CONST(false));
                    ToolTip = 'Plan supply orders automatically to fulfill new demand.';
                }
                action(RequisitionWorksheets)
                {
                    ApplicationArea = Planning;
                    Caption = 'Requisition Worksheets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Req. Wksh. Names";
                    RunPageView = WHERE("Template Type" = CONST("Req."), Recurring = CONST(false));
                    ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
                }
                action(SubcontractingWorksheets)
                {
                    ApplicationArea = Planning;
                    Caption = 'Subcontracting Worksheets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Req. Wksh. Names";
                    RunPageView = WHERE("Template Type" = CONST("For. Labor"), Recurring = CONST(false));
                    ToolTip = 'Calculate the needed production supply, find the production orders that have material ready to send to a subcontractor, and automatically create purchase orders for subcontracted operations from production order routings.';
                }
                action("Standard Cost Worksheet")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Standard Cost Worksheet';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Standard Cost Worksheet Names";
                    ToolTip = 'Review or update standard costs. Purchasers, production or assembly managers can use the worksheet to simulate the effect on the cost of the manufactured or assembled item if the standard cost for consumption, production capacity usage, or assembly resource usage is changed. You can set a cost change to take effect on a specified date.';
                }
            }
            group("Product Design")
            {
                Caption = 'Product Design';
                Image = ProductDesign;
                action(ProductionBOM)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Production BOM';
                    Image = BOM;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Production BOM List";
                    ToolTip = 'Open the item''s production bill of material to view or edit its components.';
                }
                action(ProductionBOMCertified)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Certified';
                    RunObject = Page "Production BOM List";
                    RunPageView = WHERE("Status" = CONST(Certified));
                    ToolTip = 'View the list of certified production BOMs.';
                }
                action(Routings)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Routings';
                    Image = Route;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Routing List";
                    ToolTip = 'View or edit operation sequences and process times for produced items.';
                }
                action("Routing Links")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Routing Links';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Routing Links";
                    ToolTip = 'View or edit links that are set up between production BOM lines and routing lines to ensure just-in-time flushing of components.';
                }
                action("Standard Tasks")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Standard Tasks';
                    Image = TaskList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Standard Tasks";
                    ToolTip = 'View or edit standard production operations.';
                }
                action(Families)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Families';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Family List";
                    ToolTip = 'View or edit a grouping of production items whose relationship is based on the similarity of their manufacturing processes. By forming production families, some items can be manufactured twice or more in one production, which will optimize material consumption.';
                }
                action(ProdDesign_Items)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Items';
                    Image = Item;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
                }
                action(ProdDesign_ItemsProduced)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Produced';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                    RunPageView = WHERE("Replenishment System" = CONST("Prod. Order"));
                    ToolTip = 'View the list of production items.';
                }
                action(ProdDesign_ItemsRawMaterials)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Raw Materials';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item List";
                    RunPageView = WHERE("Low-Level Code" = FILTER(> 0), "Replenishment System" = CONST(Purchase));
                    ToolTip = 'View the list of items that are not bills of material.';
                }
                action("Stockkeeping Units")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Stockkeeping Units';
                    Image = SKU;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Stockkeeping Unit List";
                    ToolTip = 'Open the list of item SKUs to view or edit instances of item at different locations or with different variants. ';
                }
            }
            group(Capacities)
            {
                Caption = 'Capacities';
                Image = Capacities;
                action(WorkCenters)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Work Centers';
                    Image = WorkCenter;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Work Center List";
                    ToolTip = 'View or edit the list of work centers.';
                }
                action(WorkCentersInternal)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Internal';
                    Image = Comment;
                    RunObject = Page "Work Center List";
                    RunPageView = WHERE("Subcontractor No." = FILTER(= ''));
                    ToolTip = 'View or register internal comments for the service item. Internal comments are for internal use only and are not printed on reports.';
                }
                action(WorkCentersSubcontracted)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Subcontracted';
                    RunObject = Page "Work Center List";
                    RunPageView = WHERE("Subcontractor No." = FILTER(<> ''));
                    ToolTip = 'View the list of ongoing purchase orders for subcontracted production orders.';
                }
                action("Machine Centers")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Machine Centers';
                    Image = MachineCenter;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Machine Center List";
                    ToolTip = 'View the list of machine centers.';
                }
                action("Registered Absence")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Registered Absence';
                    Image = Absence;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Registered Absences";
                    ToolTip = 'View absence hours for work or machine centers.';
                }
                action(Vendors)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Vendors';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
            }
            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                }
                // action("Manual Setup")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Manual Setup';
                //     RunObject = Page "Business Setup";
                //     ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                // }
                // action(General)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'General';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name) WHERE (Area = FILTER (General));
                //     ToolTip = 'Fill in your official company information, and define general codes and information that is used across the business functionality, such as currencies and languages. ';
                // }
                // action(Finance)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Finance';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER (Finance));
                //     ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                // }
                // action(Sales)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Sales';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER (Sales));
                //     ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                // }
                // action(Purchasing)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Purchasing';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER (Purchasing));
                //     ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                // }
                // action(Jobs)
                // {
                //     ApplicationArea = Jobs;
                //     Caption = 'Jobs';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER (Jobs));
                //     ToolTip = 'Define a project activity by creating a job card with integrated job tasks and job planning lines, structured in two layers. The job task enables you to set up job planning lines and to post consumption to the job. The job planning lines specify the detailed use of resources, items, and various general ledger expenses.';
                // }
                // action("Fixed Assets")
                // {
                //     ApplicationArea = FixedAssets;
                //     Caption = 'Fixed Assets';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER ("Fixed Assets"));
                //     ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                // }
                // action(HR)
                // {
                //     ApplicationArea = BasicHR;
                //     Caption = 'HR';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER (HR));
                //     ToolTip = 'Set up number series for creating new employee cards and define if employment time is measured by days or hours.';
                // }
                // action(Inventory)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Inventory';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER (Inventory));
                //     ToolTip = 'Define your general inventory policies, such as whether to allow negative inventory and how to post and adjust item costs. Set up your number series for creating new inventory items or services.';
                // }
                // action(Service)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Service';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER (Service));
                //     ToolTip = 'Configure your company policies for service management.';
                // }
                // action(System)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'System';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER (System));
                //     ToolTip = 'System';
                // }
                // action("Relationship Management")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Relationship Management';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER ("Relationship Mngt"));
                //     ToolTip = 'Set up business relations, configure sales cycles, campaigns, and interactions, and define codes for various marketing communication.';
                // }
                // action(Intercompany)
                // {
                //     ApplicationArea = Intercompany;
                //     Caption = 'Intercompany';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING (Name)
                //                   WHERE (Area = FILTER (Intercompany));
                //     ToolTip = 'Configure intercompany processes, such as the inbox and outbox for business documents exchanged within your group.';
                // }
                action("Service Connections")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Connections';
                    Image = ServiceTasks;
                    RunObject = Page "Service Connections";
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                }
                // action(Extensions)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Extensions';
                //     Image = NonStockItemSetup;
                //     RunObject = Page "Extension Management";
                //     ToolTip = 'Install Extensions for greater functionality of the system.';
                // }
                action(Workflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Workflows';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Workflows";
                    ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                }
            }
        }
        area(creation)
        {
            action("&Item")
            {
                ApplicationArea = Manufacturing;
                Caption = '&Item';
                Image = Item;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Item Card";
                RunPageMode = Create;
                ToolTip = 'View the list of items that you trade in.';
            }
            action("Production &Order")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production &Order';
                Image = "Order";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Planned Production Order";
                RunPageMode = Create;
                ToolTip = 'Create a new production order to supply a produced item.';
            }
            action("Production &BOM")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production &BOM';
                Image = BOM;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Production BOM";
                RunPageMode = Create;
                ToolTip = 'Create a new bill of material for a produced item.';
            }
            action("&Routing")
            {
                ApplicationArea = Manufacturing;
                Caption = '&Routing';
                Image = Route;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Routing";
                RunPageMode = Create;
                ToolTip = 'Create a routing defining the operations that are required to produce an end item.';
            }
            action("&Purchase Order")
            {
                ApplicationArea = Manufacturing;
                Caption = '&Purchase Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Purchase goods or services from a vendor.';
            }
        }
        area(processing)
        {
            group(Tasks)
            {
                Caption = 'Tasks';
                action("Item &Journal")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Item &Journal';
                    Image = Journals;
                    RunObject = Page "Item Journal";
                    ToolTip = 'Adjust the physical quantity of items on inventory.';
                }
                action("Re&quisition Worksheet")
                {
                    ApplicationArea = Planning;
                    Caption = 'Re&quisition Worksheet';
                    Image = Worksheet;
                    RunObject = Page "Req. Worksheet";
                    ToolTip = 'Plan supply orders automatically to fulfill new demand. This worksheet can plan purchase and transfer orders only.';
                }
                action("Planning Works&heet")
                {
                    ApplicationArea = Planning;
                    Caption = 'Planning Works&heet';
                    Image = PlanningWorksheet;
                    RunObject = Page "Planning Worksheet";
                    ToolTip = 'Plan supply orders automatically to fulfill new demand.';
                }
                action("Item Availability by Timeline")
                {
                    ApplicationArea = Planning;
                    Caption = 'Item Availability by Timeline';
                    Image = Timeline;
                    RunObject = Page "Item Availability by Timeline";
                    ToolTip = 'Get a graphical view of an item''s projected inventory based on future supply and demand events, with or without planning suggestions. The result is a graphical representation of the inventory profile.';
                }
                action("Subcontracting &Worksheet")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Subcontracting &Worksheet';
                    Image = SubcontractingWorksheet;
                    RunObject = Page "Subcontracting Worksheet";
                    ToolTip = 'Calculate the needed production supply, find the production orders that have material ready to send to a subcontractor, and automatically create purchase orders for subcontracted operations from production order routings.';
                }
                action("Change Pro&duction Order Status")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Change Pro&duction Order Status';
                    Image = ChangeStatus;
                    RunObject = Page "Change Production Order Status";
                    ToolTip = 'Change the production order to another status, such as Released.';
                }
                action("Order Pla&nning")
                {
                    ApplicationArea = Planning;
                    Caption = 'Order Pla&nning';
                    Image = Planning;
                    RunObject = Page "Order Planning";
                    ToolTip = 'Plan supply orders order by order to fulfill new demand.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                action("Order Promising S&etup")
                {
                    ApplicationArea = OrderPromising;
                    Caption = 'Order Promising S&etup';
                    Image = OrderPromisingSetup;
                    RunObject = Page "Order Promising Setup";
                    ToolTip = 'Configure your company''s policies for calculating delivery dates.';
                }
                action("&Manufacturing Setup")
                {
                    ApplicationArea = Manufacturing;
                    Caption = '&Manufacturing Setup';
                    Image = ProductionSetup;
                    RunObject = Page "Manufacturing Setup";
                    ToolTip = 'Define company policies for manufacturing, such as the default safety lead time and whether warnings are displayed in the planning worksheet.';
                }
            }
            group(History)
            {
                Caption = 'History';
                action("Item &Tracing")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Item &Tracing';
                    Image = ItemTracing;
                    RunObject = Page "Item Tracing";
                    ToolTip = 'Trace where a lot or serial number assigned to the item was used, for example, to find which lot a defective component came from or to find all the customers that have received items containing the defective component.';
                }
                action("Navi&gate")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Navi&gate';
                    Image = Navigate;
                    RunObject = Page "Navigate";
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                }
            }
            action(JobsOnOrder)
            {
                ApplicationArea = Jobs;
                Caption = 'Open';
                RunObject = Page "Job List";
                RunPageView = WHERE(Status = FILTER(Open));
                ToolTip = 'Open the card for the selected record.';
            }
            action(JobsPlannedAndQuoted)
            {
                ApplicationArea = Jobs;
                Caption = 'Planned and Quoted';
                RunObject = Page "Job List";
                RunPageView = WHERE(Status = FILTER(Quote | Planning));
                ToolTip = 'View all planned and quoted jobs.';
            }
            action(JobsCompleted)
            {
                ApplicationArea = Jobs;
                Caption = 'Completed';
                RunObject = Page "Job List";
                RunPageView = WHERE(Status = FILTER(Completed));
                ToolTip = 'View all completed jobs.';
            }
            action(JobsUnassigned)
            {
                ApplicationArea = Jobs;
                Caption = 'Unassigned';
                RunObject = Page "Job List";
                RunPageView = WHERE("Person Responsible" = FILTER(''));
                ToolTip = 'View all unassigned jobs.';
            }
            action("Job Tasks")
            {
                ApplicationArea = Suite;
                Caption = 'Job Tasks';
                RunObject = Page "Job Task List";
                ToolTip = 'Define the various tasks involved in a job. You must create at least one job task per job because all posting refers to a job task. Having at least one job task in your job enables you to set up job planning lines and to post consumption to the job.';
            }
            action(Customers)
            {
                ApplicationArea = Jobs;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action(Items)
            {
                ApplicationArea = Jobs;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action(Resources)
            {
                ApplicationArea = Jobs;
                Caption = 'Resources';
                RunObject = Page "Resource List";
                ToolTip = 'Manage your resources'' job activities by setting up their costs and prices. The job-related prices, discounts, and cost factor rules are set up on the respective job card. You can specify the costs and prices for individual resources, resource groups, or all available resources of the company. When resources are used or sold in a job, the specified prices and costs are recorded for the project.';
            }
            group("Sales & Purchases1")
            {
                Caption = 'Sales & Purchases';
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
                // action("Purchase Orders")
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Purchase Orders';
                //     RunObject = Page "Purchase Order List";
                //     ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                // }
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
            }
            group(Jobs1)
            {
                Caption = 'Jobs';
                Image = Job;
                ToolTip = 'Create, plan, and execute tasks in project management. ';
                // action(Jobs)
                // {
                //     ApplicationArea = Jobs;
                //     Caption = 'Jobs';
                //     Image = Job;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Job List";
                //     ToolTip = 'Define a project activity by creating a job card with integrated job tasks and job planning lines, structured in two layers. The job task enables you to set up job planning lines and to post consumption to the job. The job planning lines specify the detailed use of resources, items, and various general ledger expenses.';
                // }
                action(Open)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Open';
                    RunObject = Page "Job List";
                    RunPageView = WHERE(Status = FILTER(Open));
                    ToolTip = 'Open the card for the selected record.';
                }
                action(JobsPlannedAndQuotd)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Planned and Quoted';
                    RunObject = Page "Job List";
                    RunPageView = WHERE(Status = FILTER(Quote | Planning));
                    ToolTip = 'Open the list of all planned and quoted jobs.';
                }
                action(JobsComplet)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Completed';
                    RunObject = Page "Job List";
                    RunPageView = WHERE(Status = FILTER(Completed));
                    ToolTip = 'Open the list of all completed jobs.';
                }
                action(JobsUnassign)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Unassigned';
                    RunObject = Page "Job List";
                    RunPageView = WHERE("Person Responsible" = FILTER(''));
                    ToolTip = 'Open the list of all unassigned jobs.';
                }
                // action("Job Tasks")
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Job Tasks';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page 1004;
                //                     ToolTip = 'Open the list of ongoing job tasks. Job tasks represent the actual work that is performed in a job, and they enable you to set up job planning lines and to post consumption to the job.';
                // }
                // action("Job Registers")
                // {
                //     ApplicationArea = Jobs;
                //     Caption = 'Job Registers';
                //     Image = JobRegisters;
                //     RunObject = Page 278;
                //                     ToolTip = 'View auditing details for all job ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                // }
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
                    RunPageView = WHERE("Recurring" = CONST(false));
                    ToolTip = 'Record job expenses or usage in the job ledger, either by reusing job planning lines or by manual entry.';
                }
                action(JobGLJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Job G/L Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Jobs),
                                        Recurring = CONST(false));
                    ToolTip = 'Record job expenses or usage in job accounts in the general ledger. For expenses or usage of type G/L Account, use the job G/L journal instead of the job journal.';
                }
                action(RecurringJobJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Recurring Job Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Job Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Reuse preset journal lines to record recurring job expenses or usage in the job ledger.';
                }
            }
            group(Resources1)
            {
                Caption = 'Resources';
                Image = Journals;
                ToolTip = 'Manage the people or machines that are used to perform job tasks. ';
                // action(Resources)
                // {
                //     ApplicationArea = Jobs;
                //     Caption = 'Resources';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page 77;
                //     ToolTip = 'Manage your resources'' job activities by setting up their costs and prices. The job-related prices, discounts, and cost factor rules are set up on the respective job card. You can specify the costs and prices for individual resources, resource groups, or all available resources of the company. When resources are used or sold in a job, the specified prices and costs are recorded for the project.';
                // }
                action("Resource Groups")
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
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post usage and sales of your resources for internal use and statistics. Use time sheet entries as input. Note that unlike with job journals, entries posted with resource journals are not posted to G/L accounts.';
                }
                action(RecurringResourceJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Recurring Resource Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource Jnl. Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Post recurring usage and sales of your resources for internal use and statistics in a journal that is preset for your usual posting.';
                }
                // action("Resource Registers")
                // {
                //     ApplicationArea = Jobs;
                //     Caption = 'Resource Registers';
                //     Image = ResourceRegisters;
                //     RunObject = Page 274;
                //     ToolTip = 'View auditing details for all resource ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                // }
            }
            group(Journals1)
            {
                Caption = 'Journals';
                Image = Journals;
                ToolTip = 'Post entries directly to G/L accounts.';
                action(RecurringItemJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Recurring Item Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Item),
                                        Recurring = CONST(true));
                    ToolTip = 'Post recurring item transactions directly to the item ledger in a journal that is preset for your usual posting.';
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
                // action("Assisted Setup")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Assisted Setup';
                //     Image = QuestionaireSetup;
                //     RunObject = Page 1801;
                //     ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                // }
                // action(JobSetup)
                // {
                //     ApplicationArea = Jobs;
                //     Caption = 'Jobs';
                //     RunObject = Page "Business Setup";
                //     RunPageView = SORTING(Name)
                //                   WHERE(Area = FILTER(Jobs));
                //     ToolTip = 'Define a project activity by creating a job card with integrated job tasks and job planning lines, structured in two layers. The job task enables you to set up job planning lines and to post consumption to the job. The job planning lines specify the detailed use of resources, items, and various general ledger expenses.';
                // }
                // action("Service Connections")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Service Connections';
                //     Image = ServiceTasks;
                //     RunObject = Page 1279;
                //     ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                // }
                // action(Extensions)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Extensions';
                //     Image = NonStockItemSetup;
                //     RunObject = Page 2500;
                //     ToolTip = 'Install Extensions for greater functionality of the system.';
                // }
                // action(Workflows)
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Workflows';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page 1500;
                //     ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                // }
            }
            group(NewGroup)
            {
                Caption = 'New';
                action("Page Job")
                {
                    AccessByPermission = TableData 167 = IMD;
                    ApplicationArea = Jobs;
                    Caption = 'Job';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Job Creation Wizard";
                    RunPageMode = Create;
                    ToolTip = 'Create a new job.';
                }
                action("Job J&ournal")
                {
                    AccessByPermission = TableData "Job Journal Template" = IMD;
                    ApplicationArea = Jobs;
                    Caption = 'Job J&ournal';
                    Image = JobJournal;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Job Journal";
                    ToolTip = 'Prepare to post a job activity to the job ledger.';
                }
                action("Job G/L &Journal")
                {
                    AccessByPermission = TableData "Gen. Journal Template" = IMD;
                    ApplicationArea = Jobs;
                    Caption = 'Job G/L &Journal';
                    Image = GLJournal;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Job G/L Journal";
                    ToolTip = 'Prepare to post a job activity to the general ledger.';
                }
                action("R&esource Journal")
                {
                    AccessByPermission = TableData "Res. Journal Template" = IMD;
                    ApplicationArea = Suite;
                    Caption = 'R&esource Journal';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Resource Journal";
                    ToolTip = 'Prepare to post resource usage.';
                }
                action("Job &Create Sales Invoice")
                {
                    AccessByPermission = TableData "Job Task" = IMD;
                    ApplicationArea = Jobs;
                    Caption = 'Job &Create Sales Invoice';
                    Image = CreateJobSalesInvoice;
                    RunObject = Report "Job Create Sales Invoice";
                    ToolTip = 'Use a function to automatically create a sales invoice for one or more jobs.';
                }
                action("Update Job I&tem Cost")
                {
                    ApplicationArea = Suite;
                    Caption = 'Update Job I&tem Cost';
                    Image = "Report";
                    RunObject = Report "Update Job Item Cost";
                    ToolTip = 'Use a function to automatically update the cost of items used in jobs.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Job Reports")
                {
                    Caption = 'Job Reports';
                    Image = ReferenceData;
                    action("Job &Analysis")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Job &Analysis';
                        Image = "Report";
                        RunObject = Report "Job Analysis";
                        ToolTip = 'Analyze your jobs. For example, you can create a report that shows you the scheduled prices, usage prices, and contract prices, and then compares the three sets of prices.';
                    }
                    action("Job Actual To &Budget")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Job Actual To &Budget';
                        Image = "Report";
                        RunObject = Report "Job Actual To Budget";
                        ToolTip = 'Compare scheduled and usage amounts for selected jobs. All lines of the selected job show quantity, total cost, and line amount.';
                    }
                    action("Job - Pla&nning Line")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Job - Pla&nning Line';
                        Image = "Report";
                        RunObject = Report "Job - Planning Lines";
                        ToolTip = 'Define job tasks to capture any information that you want to track for a job. You can use planning lines to add information such as what resources are required or to capture what items are needed to perform the job.';
                    }

                    action("Job Su&ggested Billing")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Job Su&ggested Billing';
                        Image = "Report";
                        RunObject = Report "Job Suggested Billing";
                        ToolTip = 'View a list of all jobs, grouped by customer, how much the customer has already been invoiced, and how much remains to be invoiced, that is, the suggested billing.';
                    }
                    action("Jobs per &Customer")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Jobs per &Customer';
                        Image = "Report";
                        RunObject = Report "Jobs per Customer";
                        ToolTip = 'View a list of all jobs, grouped by customer where you can compare the scheduled price, the percentage of completion, the invoiced price, and the percentage of invoiced amounts for each bill-to customer.';
                    }
                    action("Items per &Job")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Items per &Job';
                        Image = "Report";
                        RunObject = Report "Items per Job";
                        ToolTip = 'View which items are used for which jobs.';
                    }
                    action("Jobs per &Item")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Jobs per &Item';
                        Image = "Report";
                        RunObject = Report "Jobs per Item";
                        ToolTip = 'View on which job a specific item is used.';
                    }
                }
                group("Absence Reports")
                {
                    Caption = 'Absence Reports';
                    Image = ReferenceData;
                    ToolTip = 'Analyze employee absence.';
                    action("Employee - Staff Absences")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Employee - Staff Absences';
                        Image = "Report";
                        RunObject = Report "Employee - Staff Absences";
                        ToolTip = 'View a list of employee absences by date. The list includes the cause of each employee absence.';
                    }
                    action("Employee - Absences by Causes")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Employee - Absences by Causes';
                        Image = "Report";
                        RunObject = Report "Employee - Absences by Causes";
                        ToolTip = 'View a list of all your employee absences categorized by absence code.';
                    }
                }
            }
            group(Manage)
            {
                Caption = 'Manage';
                group(Timesheet)
                {
                    Caption = 'Time Sheet';
                    Image = Worksheets;
                    action("Create Time Sheets")
                    {
                        AccessByPermission = TableData "Time Sheet Header" = IMD;
                        ApplicationArea = Jobs;
                        Caption = 'Create Time Sheets';
                        Image = JobTimeSheet;
                        RunObject = Report "Create Time Sheets";
                        ToolTip = 'As the time sheet administrator, create time sheets for resources that have the Use Time Sheet check box selected on the resource card. Afterwards, view the time sheets that you have created in the Time Sheets window.';
                    }
                    action("Manage Time Sheets")
                    {
                        AccessByPermission = TableData "Time Sheet Header" = IMD;
                        ApplicationArea = Jobs;
                        Caption = 'Manager Time Sheets';
                        Image = JobTimeSheet;
                        RunObject = Page "Manager Time Sheet";
                        ToolTip = 'Approve or reject your resources'' time sheet entries in a window that contains lines for all time sheets that resources have submitted for review.';
                    }
                    action("Manager Time Sheet by Job")
                    {
                        AccessByPermission = TableData "Time Sheet Line" = IMD;
                        ApplicationArea = Jobs;
                        Caption = 'Manager Time Sheet by Job';
                        Image = JobTimeSheet;
                        RunObject = Page "Manager Time Sheet by Job";
                        ToolTip = 'Open the list of time sheets for which your name is filled into the Person Responsible field on the related job card.';
                    }
                    // separator()
                    // {
                    // }
                    // separator()
                    // {
                    // }
                }
                group(WIP)
                {
                    Caption = 'Job Closing';
                    Image = Job;
                    ToolTip = 'Perform various post-processing of jobs.';
                    action("Job Calculate &WIP")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Job Calculate &WIP';
                        Image = CalculateWIP;
                        RunObject = Report "Job Calculate WIP";
                        ToolTip = 'Calculate the general ledger entries needed to update or close the job.';
                    }
                    action("Jo&b Post WIP to G/L")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Jo&b Post WIP to G/L';
                        Image = PostOrder;
                        RunObject = Report "Job Post WIP to G/L";
                        ToolTip = 'Post to the general ledger the entries calculated for your jobs.';
                    }
                    action("Job WIP")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Job WIP';
                        Image = WIP;
                        RunObject = Page "Job WIP Cockpit";
                        ToolTip = 'Overview and track work in process for all of your projects. Each line contains information about a job, including calculated and posted WIP.';
                    }
                }
            }
            group(History1)
            {
                Caption = 'History';
                // action("Navi&gate")
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Navi&gate';
                //     Image = Navigate;
                //     RunObject = Page 344;
                //     ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                // }
            }
        }
    }
}

