Attribute VB_Name = "Extract"
' version 3.1
'
' sTableFromFileRegEx - Parses 1.strFilePath using regular expression 2.strRegExTable to
'   extract table text. This is then parsed with regular expression 3.strRegExRow to
'   extract rows' text. Each row string is then parsed with 4.strRegExField to extract
'   fields' text. The parsed values are output to 5.strTargetAddress
'
'   only grouped (with parentheses) content is passed on to the next regular
'   expression. the pattern is converted to be non-greedy by default
'
' TableFromFile - Get table from 1.strFilePath starting at 2.intStartRow. Use
'   3.strFieldDelimiter as field delimiter (can be one of \t , ; <space>. The fields are
'   output to 4.strTargetAddress



' wrapper function for sTableFromFileRegEx
Sub sTableFromFileRegExWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    Call sTableFromFileRegEx(arrArguments(0), _
        arrArguments(1), arrArguments(2), arrArguments(3), _
        arrArguments(4))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub

' wrapper function for TableFromFile
Sub TableFromFileWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    Call TableFromFile(arrArguments(0), _
        CInt(arrArguments(1)), arrArguments(2), arrArguments(3))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' extract data in tabular format from a text file
Sub sTableFromFileRegEx(strFilePath, strRegExTable, strRegExRow, strRegExField, strTargetAddress)
On Error GoTo Error_Handler

    ' intialize
    Set objRegExp = CreateObject("VBScript.RegExp")
    objRegExp.IgnoreCase = True
    objRegExp.Global = True
    With ExcelBricks.fGetRange(strTargetAddress)
        Set objTargetWorksheet = .Worksheet
        intStartRow = .Row
        intStartColumn = .Column
    End With

    ' make patterns non-greedy
    If (boolIsNonGreedy) Then
        strRegExTable = fMakeNonGreedy(strRegExTable)
        strRegExRow = fMakeNonGreedy(strRegExRow)
        strRegExField = fMakeNonGreedy(strRegExField)
    End If
    
    ' handle relative paths
    If Left(strFilePath, 3) = "..\" Or _
        Left(strFilePath, 2) = ".\" Then
        strFilePath = ThisWorkbook.Path & "\" & strFilePath
    End If

    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set objFile = objFSO.OpenTextFile(strFilePath, 1, False)
    strFileContent = objFile.ReadAll
    
    
    ' get tables
    intRow = intStartRow
    objRegExp.Pattern = strRegExTable
    Set arrTables = objRegExp.Execute(Replace(strFileContent, vbCrLf, ""))
    For Each strTable In arrTables
        objRegExp.Pattern = strRegExTable
        strTable = objRegExp.Replace(strTable, "$1")
    
        ' get row(s)
        objRegExp.Pattern = strRegExRow
        Set arrRows = objRegExp.Execute(strTable)
        For Each strRow In arrRows
            objRegExp.Pattern = strRegExRow
            strRow = objRegExp.Replace(strRow, "$1")
            
            ' get field(s)
            objRegExp.Pattern = strRegExField
            Set arrFields = objRegExp.Execute(strRow)
            intColumn = intStartColumn
            For Each strField In arrFields
                objTargetWorksheet.Cells(intRow, intColumn).Value = objRegExp.Replace(strField, "$1")
                intColumn = intColumn + 1
            Next
            
            intRow = intRow + 1
        Next
    Next
    
Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    On Error Resume Next
    objFile.Close
    Set arrFields = Nothing
    Set arrRows = Nothing
    Set arrTable = Nothing
    Set objFile = Nothing
    Set objFSO = Nothing
    Set objRegExp = Nothing
    Set objTargetWorksheet = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub

' extract data in tabular format from a text file
Sub TableFromFile(strFilePath, intStartRow, strFieldDelimiter, strTargetAddress)
On Error GoTo Error_Handler
    Set rngTarget = ExcelBricks.fGetRange(strTargetAddress)
    
    ' handle relative paths
    If Left(strFilePath, 3) = "..\" Or _
        Left(strFilePath, 2) = ".\" Then
        strFilePath = ThisWorkbook.Path & "\" & strFilePath
    End If

    Set queryTableTemp = rngTarget.Worksheet.QueryTables.Add(Connection:="TEXT;" + strFilePath, Destination:=rngTarget)
    With queryTableTemp
        .FieldNames = True
        .RowNumbers = False
        .FillAdjacentFormulas = False
        .PreserveFormatting = True
        .RefreshOnFileOpen = False
        .RefreshStyle = xlOverwriteCells
        .SavePassword = False
        .SaveData = True
        .AdjustColumnWidth = True
        .RefreshPeriod = 0
        .TextFilePromptOnRefresh = False
        .TextFilePlatform = 437
        .TextFileStartRow = intStartRow
        .TextFileParseType = xlDelimited
        .TextFileTextQualifier = xlTextQualifierDoubleQuote
        .TextFileConsecutiveDelimiter = False
        .TextFileColumnDataTypes = Array(1, 1, 1)
        .TextFileTrailingMinusNumbers = True
        .Refresh BackgroundQuery:=False
        
        .TextFileTabDelimiter = False
        .TextFileSemicolonDelimiter = False
        .TextFileCommaDelimiter = False
        .TextFileSpaceDelimiter = False
        Select Case (strFieldDelimiter)
        Case "\t":
            .TextFileTabDelimiter = True
        Case ";":
            .TextFileSemicolonDelimiter = False
        Case ",":
            .TextFileCommaDelimiter = False
        Case " ":
            .TextFileSpaceDelimiter = False
        End Select
    End With
    queryTableTemp.Delete

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    On Error Resume Next
    Set queryTableTemp = Nothing
    Set rngTarget = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' make strPattern non-greedy
Function fMakeNonGreedy(strPattern)
    strCleanedPattern = ""
    boolEscNext = False
    For i = 1 To Len(strPattern)
        strChar = Mid(strPattern, i, 1)
        
        ' we need to add it only for quantifiers that are not literals
        If Not boolEscNext Then
            ' make pattern non-greedy.
            If InStr(1, "*+?", strChar) <> 0 Then
                strChar = strChar & "?"
            ElseIf strChar = "\" Then
                boolEscNext = True
            End If
        Else
            boolEscNext = False
        End If
    
        strCleanedPattern = strCleanedPattern & strChar
    Next
    fMakeNonGreedy = strCleanedPattern
End Function
