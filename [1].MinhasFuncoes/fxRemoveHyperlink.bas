Attribute VB_Name = "fxRemoveHyperlink"
Function fxRemovingHyperLink(aba As Worksheet, intervalo As String)
    aba.Range(intervalo).Hyperlinks.Delete
End Function
Sub exemplo()
Dim aba As Worksheet
Dim r As Range
Set aba = Sheets("plan1")
Set r = Range("a1")
Call fxRemovingHyperLink(aba, "a1")
End Sub
