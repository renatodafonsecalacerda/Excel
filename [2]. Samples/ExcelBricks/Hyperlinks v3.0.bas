Attribute VB_Name = "Hyperlinks"
' version 3.0
'
' sAddHyperlink - adds hyperlink to range 1.strRangeAddress. 2.strLinkTarget (optional  - same
'   cells address)



' sAddHyperlink wrapper
Sub sAddHyperlinkWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments & Chr(10), Chr(10))
    sAddHyperlink arrArguments(0), arrArguments(1)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' adds hyperlinks to strRange
Sub sAddHyperlink(strRangeAddress, strTargetType)
    ' add hyperlinks to each cell in range
    For Each objCell In ExcelBricks.fGetRange(strRangeAddress)
       objCell.Worksheet.Hyperlinks.Add objCell, ""
    Next
End Sub
