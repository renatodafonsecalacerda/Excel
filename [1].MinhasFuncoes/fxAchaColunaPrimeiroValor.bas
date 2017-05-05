Attribute VB_Name = "fxAchaColunaPrimeiroValor"
Public Function AchaColuna(PLAN As Worksheet, valor As Variant) As Integer
    For Each C In PLAN.Cells
        If Trim(UCase(C)) = Trim(UCase(valor)) Then
            COLUNA = C.Column
            Exit For
        End If
    Next
    AchaColuna = COLUNA
End Function
