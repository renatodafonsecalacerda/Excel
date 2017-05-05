Attribute VB_Name = "fxDiaDaSemana"
Public Function DiaDaSemana(DIA As Integer, MES As Integer, Optional ANO As Integer) As String
Application.Volatile
Dim mydate As Date
Dim d As Integer
If (IsEmpty(DIA) Or IsEmpty(MES)) Or (DIA = 0 Or MES = 0) Then
    DiaDaSemana = ""
Else
    If ANO <> 0 Then
    mydate = DIA & "/" & MES & "/" & ANO
    Else
        mydate = DIA & "/" & MES & "/" & Year(Now)
    End If
    
    d = WorksheetFunction.Weekday(d)
    
    DiaDaSemana = WeekdayName(Weekday(mydate))
End If
End Function
