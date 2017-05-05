Attribute VB_Name = "fxDuplicateSheet"
Sub duplicateSheet(plan As Worksheet, sheetname As String)
    plan.Select
    plan.Copy After:=Sheets(ThisWorkbook.Sheets().Count)
    plan.Select
    plan.Name = sheetname
End Sub
Sub testMain()
    Dim p As Worksheet
    Set p = ActiveSheet
    
    Call duplicateSheet(p, "newworkbook")
End Sub
