Attribute VB_Name = "Pivots"
' version 3.0
'
' fPageFilter - sets the page filters for the pivot table at 1.strPivotTableAddress using
'   the ; delimited set of filter conditions (field=value) in 2.strFilters. Returns the
'   data table range



' fPageFilter template
Function fPageFilterWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    fPageFilterWrapper = fPageFilter(arrArguments(0), arrArguments(1))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Function



' sets the page filter for a pivot table and returns the data range
Function fPageFilter(strPivotTableAddress, strFilters)
    arrConditions = Split(strFilters, ";")
    With ExcelBricks.fGetRange(strPivotTableAddress)
        ' clear all page filters
        For Each i In .PivotTable.PageFields
            i.CurrentPage = "(All)"
        Next
    
        ' check each condition
        For Each i In arrConditions
            arrCondition = Split(i, "=")
            
            ' check if the value is available
            boolFound = False
            For Each j In .PivotTable.PageFields(arrCondition(0)).PivotItems
                If j.Value = arrCondition(1) Then
                    .PivotTable.PivotFields(arrCondition(0)).CurrentPage = j.Value
                    boolFound = True
                    Exit For
                End If
            Next
            
            ' raise error if value is missing
            If Not boolFound Then
                Err.Raise ExcelBricks.lngFullError, , "Could not find [" & arrCondition(1) & "] in pivot page filter [" & arrCondition(0) & "]"
            End If
        Next
        
        fPageFilter = .PivotTable.TableRange1.Address
    End With
    
    ' toggle screen updates once to force screen-refresh
    Application.ScreenUpdating = (Application.ScreenUpdating = False)
    Application.ScreenUpdating = (Application.ScreenUpdating = False)
End Function
