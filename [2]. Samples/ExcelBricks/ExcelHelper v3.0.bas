Attribute VB_Name = "ExcelHelper"
' version 3.0
'
' fGetIntegerFromString (public) - return the column number for the excel column ordinal
'      1.charS
'
' fGetIntegerFromHeader (public) - return the column number for the excel column with header
'      2.strHeader in 1.strWorksheet
'
' sSetFormat - sets the format of 1.strRange to 2.strFormat



' sSetFormat wrapper
Sub sSetFormatWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sSetFormat arrArguments(0), arrArguments(1)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' set format for range
Sub sSetFormat(strRange, strFormat)
    Application.Range(strRange).NumberFormat = strFormat
End Sub


' get column from Excel ordinal
Public Function fGetIntegerFromString(charS)
    fGetIntegerFromString = Application.Range(charS & ":" & charS).Column
End Function


' get column from Excel header
Public Function fGetIntegerFromHeader(strWorksheet, strHeader)
    fGetIntegerFromHeader = Excel.WorksheetFunction.Match(strHeader, Application.Range(strWorksheet & "!1:1"), False)
End Function
