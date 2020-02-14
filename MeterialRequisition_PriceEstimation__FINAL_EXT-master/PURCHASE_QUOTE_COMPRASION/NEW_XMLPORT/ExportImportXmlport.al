xmlport 50010 "Import/Export Xmlport"
{
    Format = VariableText;
    Direction = Import;
    FieldSeparator = '<TAB>';
    UseRequestPage = false;


    schema
    {
        textelement("Root")
        {
            tableelement(ImportExportXmlport; "Import/Export Xmlport")
            {
                fieldattribute(Drawingnumber; ImportExportXmlport."Drawing number")
                {

                }
                fieldattribute(CompanyCode; ImportExportXmlport."Company Code")
                {

                }
                fieldattribute(ItemDescSpefic; ImportExportXmlport."Item desc. and Specification")
                {

                }
                fieldattribute(UnitMeas; ImportExportXmlport."Unit of measure")
                {

                }
                fieldattribute(Qty; ImportExportXmlport.Quantity)
                {

                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        myInt: Integer;
}