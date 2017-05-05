Attribute VB_Name = "fxTempoGasto"
Sub TempoGastoOnOpen()
On Error Resume Next
Dim p As Worksheet

If Sheets("tempogasto") Is Nothing Then
    Sheets.Add.Name = "tempogasto"
    Set p = Sheets("tempogasto")
    p.Cells(1, C) = "dia": C = C + 1
    p.Cells(1, C) = "mês": C = C + 1
    p.Cells(1, C) = "ano": C = C + 1
    p.Cells(1, C) = "hora-open": C = C + 1
    p.Cells(1, C) = "hora-close": C = C + 1
Else
    Set p = Sheets("tempogasto")
End If
    C = 1
    p.Cells(UltimaLinha(p, 1) + 1, C) = Day(TODAY()): C = C + 1
    p.Cells(UltimaLinha(p, 1) + 1, C) = Month(TODAY()): C = C + 1
    p.Cells(UltimaLinha(p, 1) + 1, C) = Year(TODAY()): C = C + 1
    p.Cells(UltimaLinha(p, 1) + 1, C) = Hour(TODAY()): C = C + 1
    
End Sub
