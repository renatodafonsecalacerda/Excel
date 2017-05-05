Attribute VB_Name = "fxMeses"
Function GetValorMes(MES As String) As Integer
    Select Case UCase(MES)
    Case "JANEIRO"
        GetMes = 1
    Case "FEVEREIRO"
        GetMes = 2
    Case "MARÇO"
        GetMes = 3
    Case "MARCO"
        GetMes = 3
    Case "ABRIL"
        GetMes = 4
    Case "MAIO"
        GetMes = 5
    Case "JUNHO"
        GetMes = 6
    Case "JULHO"
        GetMes = 7
    Case "AGOSTO"
        GetMes = 8
    Case "SETEMBRO"
        GetMes = 9
    Case "OUTUBRO"
        GetMes = 10
    Case "NOVEMBRO"
        GetMes = 11
    Case "DEZEMBRO"
        GetMes = 12
End Function
Function GetNomeMes(MES As Integer) As String
    Select Case UCase(MES)
    Case 1
        GetNomeMes = "JANEIRO"
    Case 2
        GetNomeMes = "FEVEREIRO"
    Case 3
        GetNomeMes = "MARÇO"
    Case 4
        GetNomeMes = "ABRIL"
    Case 5
        GetNomeMes = "MAIO"
    Case 6
        GetNomeMes = "JUNHO"
    Case 7
        GetNomeMes = "JULHO"
    Case 8
        GetNomeMes = "AGOSTO"
    Case 9
        GetNomeMes = "SETEMBRO"
    Case 10
        GetNomeMes = "OUTUBRO"
    Case 11
        GetNomeMes = "NOVEMBRO"
    Case 12
        GetNomeMes = "DEZEMBRO"
End Function
