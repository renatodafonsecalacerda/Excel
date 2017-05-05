Attribute VB_Name = "Merge"
' version 3.0
'
' sMerge - copies 1.strSourceAddress (Worksheet!StartColumn:EndColumn) columns to
'   2.strTargetWorksheet. if rows have the same values for all the columns then values
'   in each column in the comma separated list 3.strMergeColumns will be concatenated
'   (with commas) so that there is only one row
'
' Requires ExcelHelper



' wrapper function for sMerge
Sub sMergeWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    Call sMerge(arrArguments(0), arrArguments(1), arrArguments(2))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' merge rows from source into target sheet based on common columns
Public Sub sMerge(strSourceAddress, strTargetWorksheet, strMergeColumns)
On Error GoTo Error_Handler

    ' initialize
    With ExcelBricks.fGetRange(strSourceAddress)
        Set objSourceSheet = .Worksheet
        intIDColumnStart = .Column
        intIDColumnEnd = intIDColumnStart + .Columns.Count - 1
    End With
    Set objTargetSheet = ThisWorkbook.Sheets(strTargetWorksheet)
    
    ' get the merge columns as numbers instead of column names (A, B, C...)
    arrMergeColumnsStrings = Split(strMergeColumns, ",")
    strMergeColumnsIndex = ""
    For i = 0 To UBound(arrMergeColumnsStrings)
        strMergeColumnsIndex = strMergeColumnsIndex & "," & ExcelHelper.fGetIntegerFromString(arrMergeColumnsStrings(i))
    Next
    strMergeColumnsIndex = Mid(strMergeColumnsIndex, 2)
    
    
    ' clear Output sheet and copy the ID columns
    objTargetSheet.Cells.ClearContents
    Set objCopyRange = objSourceSheet.Range(Cells(1, intIDColumnStart).Address & ":" & Cells(1, intIDColumnEnd).Address)
    Set objPasteRange = objTargetSheet.Range(Cells(1, 1).Address & ":" & Cells(1, intIDColumnEnd - intIDColumnStart + 1).Address)
    objPasteRange.Value = objCopyRange.Value
    
    ' copy the merge column
    arrMergeColumns = Split(strMergeColumnsIndex, ",")
    For i = 0 To UBound(arrMergeColumns)
        objTargetSheet.Cells(1, intIDColumnEnd - intIDColumnStart + i + 2).Value = objSourceSheet.Cells(1, CInt(arrMergeColumns(i))).Value
    Next
        
    
    ' loop till all rows are blank
    intSourceRow = 2
    intTargetRow = 2
    Do While Application.WorksheetFunction.CountBlank(objSourceSheet.Range(Cells(intSourceRow, intIDColumnStart).Address & ":" & Cells(intSourceRow, intIDColumnEnd).Address)) <> intIDColumnEnd - intIDColumnStart + 1
    
        ' loop thorough the target sheet to see if it matches any row
        For i = 2 To intTargetRow - 1
            boolMatch = True
            For j = intIDColumnStart To intIDColumnEnd
                
                ' if there is a mismatch move on to the next row
                If objSourceSheet.Cells(intSourceRow, j) <> objTargetSheet.Cells(i, j - intIDColumnStart + 1) Then
                    boolMatch = False
                    Exit For
                End If
            Next
            
            ' break the loop if a match is found
            If boolMatch Then
                Exit For
            End If
        Next
        
        ' no matches were found
        If i = intTargetRow Then
            
            ' copy ID cells
            Set objCopyRange = objSourceSheet.Range(Cells(intSourceRow, intIDColumnStart).Address & ":" & Cells(intSourceRow, intIDColumnEnd).Address)
            Set objPasteRange = objTargetSheet.Range(Cells(intTargetRow, 1).Address & ":" & Cells(intTargetRow, intIDColumnEnd - intIDColumnStart + 1).Address)
            objPasteRange.Value = objCopyRange.Value
            
            intTargetRow = intTargetRow + 1
        End If
        
        ' copy merge columns
        For j = 0 To UBound(arrMergeColumns)
            
            With objTargetSheet.Cells(i, intIDColumnEnd - intIDColumnStart + j + 2)
                If .Value = "" Then
                    .Value = objSourceSheet.Cells(intSourceRow, CInt(arrMergeColumns(j))).Value
                ElseIf objSourceSheet.Cells(intSourceRow, CInt(arrMergeColumns(j))).Value <> "" Then
                    .Value = .Value & ", " & objSourceSheet.Cells(intSourceRow, CInt(arrMergeColumns(j))).Value
                End If
            End With
        Next
                
        intSourceRow = intSourceRow + 1
    Loop

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' clean up
    On Error Resume Next
    Set objCopyRange = Nothing
    Set objPasteRange = Nothing
    Set objSourceSheet = Nothing
    Set objTargetSheet = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub
