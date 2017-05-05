Attribute VB_Name = "MOD_GETDADO"
Dim D As Worksheet
Function GET_TIPO(V, D As Worksheet)
    'Set D = Sheets("DESCONTOS1")
    For C = 1 To 255
        If D.Cells(1, C) = V Then
            GET_TIPO = C
            Exit Function
        End If
    Next
End Function

Function GET_DADO(V, TIPO) As Variant
    Set D = Sheets("DESCONTOS1")
    C_RETORNO = GET_TIPO(TIPO, D)
    For L = 2 To UltimaLinha(D, 1)
        If Val(D.Cells(L, 3)) = Val(V) Then
            GET_DADO = D.Cells(L, C_RETORNO)
            Exit Function
        End If
    Next
End Function

