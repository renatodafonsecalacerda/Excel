Attribute VB_Name = "fxSaveFileAsPicture"
Sub As_Picture()
'Oct 27, 2014
If MsgBox("select a range ?", vbOKCancel) = vbCancel Then Exit Sub
Selection.CopyPicture xlScreen, xlBitmap
Application.ScreenUpdating = False
Sheets.Add
ActiveSheet.Name = "pic"
ActiveSheet.Paste Destination:=ActiveSheet.Range("A1")
Dim fPath
fPath = ThisWorkbook.Path & "\picture"   '<<< path and wb name
Dim ws As Worksheet
Set ws = ActiveSheet
ws.Copy
Application.DisplayAlerts = False
With ActiveWorkbook
.SaveAs fPath
.Close
End With
ActiveSheet.Delete
Application.DisplayAlerts = True
Application.ScreenUpdating = True
MsgBox "done"
End Sub
