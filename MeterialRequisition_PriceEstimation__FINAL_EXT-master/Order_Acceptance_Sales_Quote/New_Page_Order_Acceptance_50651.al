page 50651 "Order Acceptance"
{
    PageType = Card;
    //ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = "Order Acceptance";

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("Sales Quote No."; "Sales Quote No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Acceptance status"; "Order Acceptance status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Acceptance date"; "Acceptance date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Contract)
            {
                field("Contract Documents Verified"; "Contract Documents Verified")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    trigger
                    OnValidate()
                    begin
                        CheckStatus();
                        ContractDepartmentValidation();
                    end;
                }
                field("Warranty Details Confirmed"; "Warranty Details Confirmed")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        ContractDepartmentValidation();
                    end;
                }
                field("Contract Remarks"; "Contract Remarks")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    Caption = 'Remarks By Contract';
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        ContractDepartmentValidation();
                    end;
                }

            }
            group(Finance)
            {
                field("Finance Documents Verified"; "Finance Documents Verified")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        FinanceDepartmentValidation();
                    end;
                }
                field("Customer PO Received"; "Customer PO Received")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        FinanceDepartmentValidation();
                    end;
                }
                field("Advance Received"; "Advance Received")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        FinanceDepartmentValidation();
                    end;
                }
                field("Finance Remarks"; "Finance Remarks")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    Caption = 'Remarks By Finance';
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        FinanceDepartmentValidation();
                    end;
                }
            }
            group(Management)
            {
                field("Terms and conditions approved"; "Terms and conditions approved")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        ManagementDepartmentValidation();

                    end;
                }
                field("Payment Milestones confirmed"; "Payment Milestones confirmed")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        ManagementDepartmentValidation();
                    end;
                }
                field("Profitability confirmed"; "Profitability confirmed")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        ManagementDepartmentValidation();
                    end;
                }
                field("Management Remarks"; "Management Remarks")
                {
                    ApplicationArea = All;
                    Editable = ControlEnableDisableBoolG;
                    Caption = 'Remarks By Management';
                    trigger
                  OnValidate()
                    begin
                        CheckStatus();
                        ManagementDepartmentValidation();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Status as Open")
            {
                ApplicationArea = All;
                Caption = 'ReOpen';
                Image = ReOpen;
                Enabled = ActionEnableG;

                trigger OnAction()
                begin

                    if Not ("Order Acceptance status" = "Order Acceptance status"::Open) then begin
                        if Confirm('Do You Want to Changes Status') then begin
                            "Order Acceptance status" := "Order Acceptance status"::Open;
                            Clear("Acceptance date");
                            CurrPage.Editable := true;
                            CurrPage.Update(true);
                            SalesHeaderRecG.Reset();
                            if SalesHeaderRecG.get(SalesHeaderRecG."Document Type"::Quote, "Sales Quote No.") then begin
                                SalesHeaderRecG."Order Accepted" := false;
                                SalesHeaderRecG.Modify();
                            end;

                        end;
                    end
                    else
                        Error('Status Already Open');

                end;
            }
            action("Update Status as Complete")
            {
                ApplicationArea = All;
                Caption = 'Mark as Completed';
                Image = Completed;
                Enabled = ActionEnableG;

                trigger OnAction()
                begin
                    if Not ("Order Acceptance status" = "Order Acceptance status"::Completed) then begin
                        if Confirm('Do You Want to Changes Status') then begin
                            "Order Acceptance status" := "Order Acceptance status"::Completed;
                            "Acceptance date" := Today();
                            CurrPage.Editable := false;
                            CurrPage.Update(true);

                            SalesHeaderRecG.Reset();
                            if SalesHeaderRecG.get(SalesHeaderRecG."Document Type"::Quote, "Sales Quote No.") then begin
                                SalesHeaderRecG."Order Accepted" := true;
                                SalesHeaderRecG.Modify();
                            end;

                        end;
                    end
                    else
                        Error('Status Already Completed');
                end;
            }
        }
    }

    var
        SalesHeaderRecG: Record "Sales Header";
        UserSetupRecG: Record "User Setup";
        ControlEnableDisableBoolG: Boolean;
        ActionEnableG: Boolean;

    trigger
    OnOpenPage()
    begin
        ControlEnableDisableBoolG := false;
        ActionEnableG := false;

        UserSetupRecG.Reset();
        if UserSetupRecG.Get(UserId) then begin
            if UserSetupRecG.Departments = UserSetupRecG.Departments::Management then
                ActionEnableG := true
            else
                ActionEnableG := false;

        end;


        if "Order Acceptance status" = "Order Acceptance status"::Completed then
            ControlEnableDisableBool(false)
        else
            if "Order Acceptance status" = "Order Acceptance status"::Open then
                ControlEnableDisableBool(true);
    end;


    procedure ControlEnableDisableBool(CurrStatus: Boolean)
    begin
        ControlEnableDisableBoolG := CurrStatus;
    end;

    procedure CheckStatus()
    begin

        if "Order Acceptance status" = "Order Acceptance status"::Completed then
            Error('Status should open to modify records');
    end;

    procedure ManagementDepartmentValidation()
    begin
        UserSetupRecG.Reset();
        if UserSetupRecG.Get(UserId) then
            if NOT (UserSetupRecG.Departments = UserSetupRecG.Departments::Management) then
                Error('Only Management Department should change Records');
    end;

    procedure ContractDepartmentValidation()
    begin
        UserSetupRecG.Reset();
        if UserSetupRecG.Get(UserId) then
            if NOT (UserSetupRecG.Departments = UserSetupRecG.Departments::Contract) then
                Error('Only Contract Department should change Records');
    end;

    procedure FinanceDepartmentValidation()
    begin
        UserSetupRecG.Reset();
        if UserSetupRecG.Get(UserId) then
            if NOT (UserSetupRecG.Departments = UserSetupRecG.Departments::Finance) then
                Error('Only Finance Department should change Records');
    end;

}