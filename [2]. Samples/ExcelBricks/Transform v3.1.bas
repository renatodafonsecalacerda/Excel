Attribute VB_Name = "Transform"
' version 3.1
'
' sExtractfromColumn - searches 2.strSourceColumn in <worksheet> for matches to regular expression
'   4.strPattern and not matching 5.strNotPattern. The search uses 1.<worksheet>!<column><row>
'   as a guide (from <row> till <column> is blank). The matches are put as separator delimited
'   values in 3.strTargetColumn. The regular expression 6.strDelimiters is the string of delimiter
'   characters (like .,:). The first of these is used as the separator
'
' sTransformColumn - converts 2.strColumn in <worksheet>. Uses 1.<worksheet>!<column>:<column> as
'   a guide (i.e. till <column> is blank) using the rule grid (2 columns - find pattern and end
'   pattern) at 3.strRulesAddress
'
' Requires ExcelHelper.bas



' wrapper function for sExtractfromColumn
Sub sExtractfromColumnWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    Call sExtractfromColumn(arrArguments(0), _
        arrArguments(1), arrArguments(2), _
        arrArguments(3), arrArguments(4), _
        arrArguments(5))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub


' wrapper function for sTransformColumn
Sub sTransformColumnWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    Call sTransformColumn(arrArguments(0), arrArguments(1), _
        arrArguments(2))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' extract words from column
Sub sExtractfromColumn(strIDColumnAddress, _
    strSourceColumn, strTargetColumn, _
    strPattern, strNotPattern, _
    strDelimiters)
On Error GoTo Error_Handler

    ' initialize
    With ExcelBricks.fGetRange(strIDColumnAddress)
        Set objWorksheet = .Worksheet
        intIDColumn = .Column
        intRow = .Row
    End With
    intSourceColumn = ExcelHelper.fGetIntegerFromString(strSourceColumn)
    intTargetColumn = ExcelHelper.fGetIntegerFromString(strTargetColumn)
    
    
    ' the separator is the first of the delimiters
    strSeparator = Left(strDelimiters, 1)
    
    ' build delimiter regular expression string
    strDelimiterRegExp = ""
    For i = 1 To Len(strDelimiters)
        strChar = Mid(strDelimiters, i, 1)
        
        ' escape the character only if it is a special character
        ' anchors and escaped characters
        If InStr(1, "^$?*+.|{}[]()\", strChar) Then
            strChar = "\" & strChar
        End If
        
        ' since these are single characters they don't need to be parenthesized
        strDelimiterRegExp = strDelimiterRegExp & strChar
    Next
    
    ' review pattern for delimiters at the beginning and end
    Set revBorderDelimiters = CreateObject("VBScript.RegExp")
    revBorderDelimiters.IgnoreCase = True
    revBorderDelimiters.Global = True
    revBorderDelimiters.Pattern = "(^[" & strDelimiterRegExp & "]+)|([" & strDelimiterRegExp & "]+$)"
    
    
    ' build pattern and NOT pattern regular expression
    Set revPattern = CreateObject("VBScript.RegExp")
    revPattern.IgnoreCase = True
    revPattern.Global = True
    
    Set revNotPattern = CreateObject("VBScript.RegExp")
    revNotPattern.IgnoreCase = True
    revNotPattern.Global = True
    
    ' if strPattern is blank set it to a non-empty string of non-delimiter characters
    If strPattern = "" Then strPattern = "[^" & strDelimiterRegExp & "]+"
    
    ' the pattern should be non-greedy by default
    ' delimiters inclusion must be explicit, so make the any-character-wildcard (.) ignore delimiters
    strPattern = fNonGreedyClear(strPattern, strDelimiterRegExp)
    strNotPattern = fNonGreedyClear(strNotPattern, strDelimiterRegExp)
    
    ' if the pattern is not parenthesized | symbols inside the pattern will make one of the delimiters optional
    ' so ^(abc)|(def)$ will be treated as ^(abc) or (def)$ [not what we want], instead of ^ (abc)or(def) $
    revPattern.Pattern = "([" & strDelimiterRegExp & "](" & strPattern & ")[" & strDelimiterRegExp & "])|" & _
        "([" & strDelimiterRegExp & "](" & strPattern & ")$)|" & _
        "(^(" & strPattern & ")[" & strDelimiterRegExp & "])|" & _
        "(^(" & strPattern & ")$)"
    
    revNotPattern.Pattern = "^(" & strNotPattern & ")$"
    
    
    ' extract the patterns
    Do While objWorksheet.Cells(intRow, intIDColumn) <> ""
        strText = objWorksheet.Cells(intRow, intSourceColumn).Text
        
        ' a single .execute won't handle shared delimiters
        ' "abc def" will return only abc because def's left delimiter is used up
        strOutput = ""
        Do
            Set arrOccurences = revPattern.Execute(strText)
        
            ' so we shorten the string for each match
            If arrOccurences.Count <> 0 Then
                With arrOccurences(0)
                    ' then start searching after the match
                    strText = Mid(strText, .FirstIndex + .Length + 1)
                    ' the match will have delimiters at the start and end - remove them
                    strInstance = revBorderDelimiters.Replace(.Value, "")
                End With
            
                ' add this only if doesn't already exist
                ' the separator must NOT be in strPattern; other delimiters can be
                If InStr(1, strOutput & strSeparator, strSeparator & strInstance & strSeparator) = 0 _
                    And Not revNotPattern.Test(strInstance) Then
                    strOutput = strOutput & strSeparator & strInstance
                End If
            End If
        Loop While arrOccurences.Count <> 0
        
        ' this also cleans out the cell if there is no output
        objWorksheet.Cells(intRow, intTargetColumn).Value = Mid(strOutput, 2)
        intRow = intRow + 1
    Loop
    
Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    On Error Resume Next
    ' clean up
    Set objWorksheet = Nothing
    Set revBorderDelimiters = Nothing
    Set revPattern = Nothing
    Set revNotPattern = Nothing
    Set arrOccurences = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription & " [" & intRow & "]"
End Sub


' extract words from column
Sub sTransformColumn(strIDColumnAddress, strColumn, _
    strRulesAddress)
On Error GoTo Error_Handler

    ' intialize
    With ExcelBricks.fGetRange(strIDColumnAddress)
        Set objWorksheet = .Worksheet
        intIDColumn = .Column
    End With
    intColumn = ExcelHelper.fGetIntegerFromString(strColumn)
    
    
    ' apply each rule
    Set revPattern = CreateObject("VBScript.RegExp")
    revPattern.IgnoreCase = True
    revPattern.Global = False
    For Each objRowRange In ExcelBricks.fGetRangeFromCell(strRulesAddress).Rows()
        
        ' initialize pattern
        revPattern.Pattern = "^" & objRowRange.Cells(1, 1).Text & "$"
        strReplaceWith = objRowRange.Cells(1, 2).Text
        
        ' replace
        With objWorksheet
            intRow = 2
            Do While Not IsEmpty(.Cells(intRow, intIDColumn).Value2)
                strValue = revPattern.Replace(.Cells(intRow, intColumn).Text, strReplaceWith)
                If Left(strValue, 1) = "=" Then
                    strValue = "'" & strValue
                End If
                .Cells(intRow, intColumn).Value = strValue
                intRow = intRow + 1
            Loop
        End With
    Next
    
Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    On Error Resume Next
    Set objWorksheet = Nothing
    Set revPattern = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription & " [" & intRow & "]"
End Sub



' make strPattern non-greedy and specifically indicate delimiters
' i.e. make the any-character-wildcard (.) ignore delimiters
Function fNonGreedyClear(strPattern, strDelimiterRegExp)
    
    strCleanedPattern = ""
    boolEscNext = False
    
    For i = 1 To Len(strPattern)
        strChar = Mid(strPattern, i, 1)
        
        ' we need to add it only for quantifiers that are not literals
        If Not boolEscNext Then
            ' make pattern non-greedy.
            If InStr(1, "*+?", strChar) <> 0 Then
                strChar = strChar & "?"
            ' replace . with not(delimiters)
            ElseIf strChar = "." Then
                strChar = "[^" & strDelimiterRegExp & "]"
            ElseIf strChar = "\" Then
                boolEscNext = True
            End If
        Else
            boolEscNext = False
        End If
    
        strCleanedPattern = strCleanedPattern & strChar
    Next
    
    fNonGreedyClear = strCleanedPattern
End Function
