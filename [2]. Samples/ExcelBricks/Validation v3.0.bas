Attribute VB_Name = "Validation"
' version 3.0
'
' sSetValidFlag - loops using 1.<worksheet>!<ID column><start row> and validates 2.strInputColumn
'   based on the regular expression 4.strValidationString. 5.strFailMessage [value] is appended
'   to 3.strOutputColumn if validation fails
'
' Requires ExcelHelper.bas



' sSetValidFlag wrapper
Sub sSetValidFlagWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sSetValidFlag arrArguments(0), arrArguments(1), arrArguments(2), arrArguments(3), arrArguments(4)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' check if the column matches a validation string
Sub sSetValidFlag(strIDAddress, strInputColumn, strOutputColumn, strValidationString, strFailMessage)
On Error GoTo Error_Handler

    ' initialize
    With ExcelBricks.fGetRange(strIDAddress)
        Set objWorksheet = .Worksheet
        intIDColumn = .Column
        intRow = .Row
    End With
    
    intInputColumn = ExcelHelper.fGetIntegerFromString(strInputColumn)
    intOutputColumn = ExcelHelper.fGetIntegerFromString(strOutputColumn)

    Set revValidation = CreateObject("VBScript.RegExp")
    With revValidation
        .Global = False
        .IgnoreCase = True
        .Pattern = "^" & strValidationString & "$"
    End With

    
    ' validate
    With objWorksheet
        Do While .Cells(intRow, intIDColumn).Text <> ""
            strTestValue = .Cells(intRow, intInputColumn).Text
            If Not revValidation.Test(strTestValue) Then
                With .Cells(intRow, intOutputColumn)
                    If .Value = "" Then
                        .Value = strFailMessage & " [" & strTestValue & "]"
                    Else
                        .Value = .Value & Chr(10) & strFailMessage & " [" & strTestValue & "]"
                    End If
                End With
            End If
            
            intRow = intRow + 1
        Loop
    End With

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If

    On Error Resume Next
    Set revValidation = Nothing
    Set objWorksheet = Nothing
    On Error GoTo 0

    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub

