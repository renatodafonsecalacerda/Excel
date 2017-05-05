Attribute VB_Name = "fxShowHide"
Public Function ShowHide(nome As String)
Dim p As Worksheet
Set p = Sheets(nome)
If p.Visible = True Then
    p.Visible = xlSheetHidden: Exit For
Else
    p.Visible = xlSheetVisible: Exit For
End If
End Function
