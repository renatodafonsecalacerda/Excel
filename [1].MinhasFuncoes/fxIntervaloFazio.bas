Attribute VB_Name = "fxIntervaloFazio"
Function ÈFazio(intervalo As Range) As String
If WorksheetFunction.CountA(intervalo) = 0 Then
    ÈFazio = "Empty"
Else
    ÈFazio = "Not Empty"
End If
End Function
