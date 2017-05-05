Attribute VB_Name = "fxAchaLinha"
Public Function AchaLinha(PLAN As Worksheet, valor As Variant) As Integer
    For Each C In PLAN.Cells
        If Trim(UCase(C)) = Trim(UCase(valor)) Then
            COLUNA = C.Row
            Exit For
        End If
    Next
    AchaLinha = COLUNA
End Function
