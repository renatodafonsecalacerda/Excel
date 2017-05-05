Attribute VB_Name = "fxAchaColuna"
Public Function AchaColuna(PLAN As Worksheet, valor As Variant) As Integer
    For Each c In PLAN.Range("A1:IV1")
        If Trim(UCase(c)) = Trim(UCase(valor)) Then
            COLUNA = c.Column
            Exit For
        End If
    Next
    AchaColuna = COLUNA
End Function
