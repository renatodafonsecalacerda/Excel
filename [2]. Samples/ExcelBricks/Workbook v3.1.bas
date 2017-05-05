Attribute VB_Name = "Workbook"
' version 3.1
'
' sPutWorksheets - puts worksheet names from 1.strFilePath in a column range starting
'       from 2.strTargetAddress
'
' sPutHeaders - puts column headers from 2.strWorksheet in 1.strFilePath in a column
'       range starting from 3.strTargetAddress



' sPutHeaders wrapper
Sub sPutHeadersWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sPutHeaders arrArguments(0), arrArguments(1), arrArguments(2)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub

' sPutWorksheets wrapper
Sub sPutWorksheetsWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sPutWorksheets arrArguments(0), arrArguments(1)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' get worksheets given workbook
Sub sPutWorksheets(strFilePath, strTargetAddress)
On Error GoTo Error_Handler
    
    ' initialize
    With Range(strTargetAddress)
        Set objTargetWorksheet = ThisWorkbook.Worksheets(.Worksheet.Name)
        strTargetAddressLocal = .AddressLocal
    End With
    Set objWorkbook = Application.Workbooks.Open(strFilePath, , True)

    ' put
    For intRow = 1 To objWorkbook.Worksheets.Count
        objTargetWorksheet.Range(strTargetAddressLocal).Offset(intRow - 1, 0).Value = _
            "'" & objWorkbook.Worksheets(intRow).Name
    Next
    
Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' cleanup
    On Error Resume Next
    Set objTargetWorksheet = Nothing
    objWorkbook.Close False
    Set objWorkbook = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' get columns given workbook and worksheet
Sub sPutHeaders(strFilePath, strSheetName, strTargetAddress)
On Error GoTo Error_Handler
    
    ' initialize
    With Range(strTargetAddress)
        Set objTargetWorksheet = ThisWorkbook.Worksheets(.Worksheet.Name)
        strTargetAddressLocal = .AddressLocal
    End With
    Set objWorkbook = Application.Workbooks.Open(strFilePath, , True)
    
    ' put the column names
    intCount = 1
    Do While objWorkbook.Worksheets(strSheetName).Cells(1, intCount) <> ""
        objTargetWorksheet.Range(strTargetAddressLocal).Offset(intCount - 1, 0).Value = _
            objWorkbook.Worksheets(strSheetName).Cells(1, intCount).Value
        intCount = intCount + 1
    Loop

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' cleanup
    On Error Resume Next
    Set objTargetWorksheet = Nothing
    objWorkbook.Close False
    Set objWorkbook = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub
