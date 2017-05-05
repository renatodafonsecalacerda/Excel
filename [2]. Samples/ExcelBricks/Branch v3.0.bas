Attribute VB_Name = "Branch"
' version 3.0
'
' sBranch - copies rows from 1.strSourceWorksheet to 2.strTargetWorksheet
'   creating a row for every comma delimited value in 4.strSplitColumn till
'   3.strIDColumn is blank
'
' Requires ExcelHelper



' wrapper function for sBranch
Sub sBranchWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments & Chr(10) & ",", Chr(10))
    Call sBranch(arrArguments(0), arrArguments(1), _
        arrArguments(2), arrArguments(3))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' split rows from source into target sheet based on comma delimited values in split column
' rows with no values in this column are copied as such
Public Sub sBranch(strSourceWorksheet, strTargetWorksheet, _
    strIDColumn, strSplitColumn)
On Error GoTo Error_Handler

    ' initialize
    Set objSourceSheet = ThisWorkbook.Sheets(strSourceWorksheet)
    Set objTargetSheet = ThisWorkbook.Sheets(strTargetWorksheet)
    intIDColumn = ExcelHelper.fGetIntegerFromString(strIDColumn)
    intSplitColumn = ExcelHelper.fGetIntegerFromString(strSplitColumn)
    
    
    ' clear Output sheet and copy the header column
    objTargetSheet.Cells.Clear
    objSourceSheet.Rows("1:1").Copy objTargetSheet.Range("1:1")
    
    
    ' loop through rows in data sheet
    intSourceRow = 2
    intTargetRow = 2
    strSuffix = " of " & Application.WorksheetFunction.CountA(objSourceSheet.Columns(intIDColumn))
    Do While objSourceSheet.Cells(intSourceRow, intIDColumn) <> ""
    
        ' status updates
        Application.StatusBar = "sBranch : " & intSourceRow & strSuffix
    
        ' if there are no values in the split column
        strSplitValue = objSourceSheet.Cells(intSourceRow, intSplitColumn)
        If strSplitValue = "" Then
            objSourceSheet.Rows(intSourceRow).Copy objTargetSheet.Rows(intTargetRow)
            
        Else
            ' copy the row for each split value
            strArray = Split(strSplitValue, ",")
            intArraySize = UBound(strArray)
            
            intStartTargetRow = intTargetRow
            intTargetRow = intTargetRow + intArraySize
            objSourceSheet.Rows(intSourceRow).Copy objTargetSheet.Range(intStartTargetRow & ":" & intTargetRow)
            For j = intStartTargetRow To intTargetRow
                strValue = Trim(strArray(j - intStartTargetRow))
                
                ' handle sub-strings that start with =
                If Left(strValue, 1) = "=" Then
                    strValue = "'" & strValue
                End If
                objTargetSheet.Cells(j, intSplitColumn) = strValue
            Next
        End If
    
        intTargetRow = intTargetRow + 1
        intSourceRow = intSourceRow + 1
    Loop


Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' clean up
    On Error Resume Next
    Set objSourceSheet = Nothing
    Set objTargetSheet = Nothing
    Application.StatusBar = False
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub
