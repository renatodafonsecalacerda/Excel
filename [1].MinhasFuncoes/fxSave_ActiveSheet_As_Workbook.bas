Attribute VB_Name = "fxSave_ActiveSheet_As_Workbook"
Sub Save_ActiveSheet_As_Workbook(Copysheet As Worksheet, path As String, file As String, sheetname As String)
Set wb = Workbooks.Add
ThisWorkbook.Activate
Copysheet.Activate
ActiveSheet.Copy After:=wb.Sheets(wb.Sheets().Count)
wb.Activate
If Right(path, 1) = "\" Then path = Left(path, Len(path) - 1)
If MsgBox("O nome do arquivo está correto? " & path & "\" & file & ".xls", vbYesNo) = vbYes Then
    wb.SaveAs path & "\" & file & ".xls"
End If
nome = ActiveSheet.Name

Application.DisplayAlerts = False
    For Each e In Worksheets
        If e.Name <> dontdelete Then
            e.Delete
        End If
    Next
Application.DisplayAlerts = True


ActiveSheet.Name = sheetname

wb.Save
End Sub

Function DeleteSheets(ByVal dontdelete As String)
    Application.DisplayAlerts = False
    For Each e In Worksheets
        If e.Name <> dontdelete Then
            e.Delete
        End If
    Next
    Application.DisplayAlerts = True
End Function

Sub testemain()
Call sb_Copy_Save_ActiveSheet_As_Workbook(Sheets("Plan2"), "c:\", "teste", "new_name")
End Sub
