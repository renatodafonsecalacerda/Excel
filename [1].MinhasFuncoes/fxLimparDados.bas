Attribute VB_Name = "fxLimparDados"
Sub limparDados(p As Worksheet, ByVal l_ini As Integer, ByVal c_Ini As Integer, ByVal c_Fim As Integer)
Dim l_fim As Integer
    l_fim = UltimaLinha(p, c_Ini)
    If l_fim > l_ini Then
        p.Range(p.Cells(l_ini, c_Ini), p.Cells(l_fim, c_Fim)).ClearContents
    End If
End Sub
