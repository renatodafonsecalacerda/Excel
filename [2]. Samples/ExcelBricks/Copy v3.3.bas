Attribute VB_Name = "Copy"
' version 3.3
'
' sCopy - if a cell is given, copies a table with top-left corner 1.strSource to 2.strTarget. 
'       if 4.boolTranspose (optional - false) is true, the content is transposed. If a range is given 
'       the range is copied. 2. xlPasteType tells what to copy (optional - Values) - values, formulas
'       or formats
'



' wrapper function for fCopyValue
Function sCopyWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments & Chr(10) & "values" & Chr(10) & "False", Chr(10))
    sCopyWrapper = sCopy(arrArguments(0), arrArguments(1), _
        arrArguments(2), CBool(arrArguments(3)))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Function



' copies source to target. transpose if required
Public Function sCopy(strSource, strTarget, strPasteType, boolTranspose)
On Error GoTo Error_Handler

    ' initialize
    Set objSourceStart = ExcelBricks.fGetRange(strSource)
    Set objTargetStart = ExcelBricks.fGetRange(strTarget)
    
    
    ' get source range
    If objSourceStart.Cells.Count <> 1 Then
        Set objSource = objSourceStart
    Else
        intColOffset = 0
        Do While objSourceStart.Offset(0, intColOffset) <> ""
            intColOffset = intColOffset + 1
        Loop
        intColOffset = intColOffset - 1
        
        intRowOffset = 0
        Do While objSourceStart.Offset(intRowOffset, 0) <> ""
            intRowOffset = intRowOffset + 1
        Loop
        intRowOffset = intRowOffset - 1
        
        Set objSourceEnd = objSourceStart.Offset(intRowOffset, intColOffset)
        Set objSource = Range(objSourceStart, objSourceEnd)
    End If
    
    
    ' copy source to target
    objSource.Copy
    Select Case LCase(strPasteType)
	Case "formulas"
		pasteType = xlPasteFormulas
	Case "formats"
		pasteType = xlPasteFormats
	Case "values"
		pasteType = xlPasteValues
    End Select
    objTargetStart.PasteSpecial pasteType, , , boolTranspose
    
    ' this may fail if the cell is a merged cell
    On Error Resume Next
    With objTargetStart.Worksheet.Range("IV1")
        .Copy
        .PasteSpecial xlPasteAll
    End With
    On Error GoTo Error_Handler
    
    ' clear the clipboard
    Application.CutCopyMode = False
    
Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    On Error Resume Next
    Set objSourceStart = Nothing
    Set objTargetStart = Nothing
    Set objSourceEnd = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Function
