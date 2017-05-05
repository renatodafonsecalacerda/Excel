Attribute VB_Name = "Export"
' version 3.1
'
' sExportSheets - moves all sheets listed (comma separated) in 2.strInputSheetList
'   into a workbook named 1.strOutputWorkbookName. The user is prompted to choose
'   the path if the optional 3.strOutputPath (with a trailing \) is blank

'   all formulas will be converted to values during the export. if <date[:format]> is
'   included in the workbook name it will be replaced by the date in the format
'   specified. Exported worksheets cannot be named Sheet1, Sheet2 or Sheet3



' wrapper function for sExportSheets
Sub sExportSheetsWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments + Chr(10), Chr(10))
    Call sExportSheets(arrArguments(0), arrArguments(1), arrArguments(2))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' extract worksheets (as text) into an excel file
Sub sExportSheets(strOutputWorkbookName, strInputSheetList, strOutputPath)
On Error GoTo Error_Handler
    
    ' initialize
    Application.DisplayAlerts = False
    Set objNewWorkBook = Application.Workbooks.Add
    
    ' excel 2007 has only one sheet in a new workbook
    intDefaultSheetCount = objNewWorkBook.Worksheets.Count
    
    ' copy the sheets
    arrInputSheet = Split(strInputSheetList, ",")
    For i = UBound(arrInputSheet) To 0 Step -1
        strWorksheetName = Trim(arrInputSheet(i))
        If strWorksheetName = "Sheet1" Or strWorksheetName = "Sheet2" Or strWorksheetName = "Sheet3" Then
            Err.Raise ExcelBricks.lngFullError, , "Exported worksheets cannot be named Sheet1, Sheet2 or Sheet3."
        End If
        
        Set objNewWorksheet = objNewWorkBook.Sheets.Add
        ThisWorkbook.Worksheets(arrInputSheet(i)).Cells.Copy
        ' if we just copy the values directly the formatting won't move
        ' so we first copy everything then change it to values
        objNewWorksheet.Paste
        objNewWorksheet.Cells.Copy
        ' copying will change the formulas to be relative to the original sheet (so no problem there)
        objNewWorksheet.Cells.PasteSpecial xlPasteValues
        objNewWorksheet.Cells(1, 1).Select
        objNewWorksheet.Name = strWorksheetName
    Next
    
    ' delete the existing sheets
    For i = 1 To intDefaultSheetCount
        objNewWorkBook.Worksheets("Sheet" & i).Delete
    Next
    
    ' build the workbook name
    Set objRegExp = CreateObject("VBScript.RegExp")
    objRegExp.Pattern = "^.*<date:(.*?)>.*$"
    objRegExp.Global = True
    If objRegExp.Test(strOutputWorkbookName) Then
        strDateFormat = objRegExp.Replace(strOutputWorkbookName, "$1")
        strOutputWorkbookName = Replace(strOutputWorkbookName, "<date:" & strDateFormat & ">", Format(Now(), strDateFormat))
    End If
    
    ' save the workbook
    If strOutputPath <> "" Then
        If Left(strOutputPath, 2) = ".\" Or Left(strOutputPath, 3) = "..\" Then
            strOutputPath = ThisWorkbook.Path & "\" & strOutputPath
        End If
        
        objNewWorkBook.SaveAs strOutputPath & strOutputWorkbookName
    Else
        With Excel.Application.FileDialog(msoFileDialogSaveAs)
            .InitialFileName = strOutputWorkbookName
            
            Application.ScreenUpdating = True
            .Show
            Application.ScreenUpdating = False
            
            If .SelectedItems.Count = 0 Then
                Err.Raise ExcelBricks.lngShowMessage, , "No output path selected. Cancelling run."
            End If
            objNewWorkBook.SaveAs .SelectedItems(1)
        End With
    End If
        
Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    On Error Resume Next
    Application.DisplayAlerts = True
    Application.CutCopyMode = False
    Set objNewWorksheet = Nothing
    objNewWorkBook.Close False
    Set objNewWorkBook = Nothing
    Set objRegExp = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub
