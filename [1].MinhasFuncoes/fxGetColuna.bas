Attribute VB_Name = "fxGetColuna"
Function GET_COLUNA(Planilha As Worksheet, Valor As Variant, Linha As Integer) As Integer
Dim p As Worksheet
Set p = Planilha
For C = 1 To 255
    If p.Cells(Linha, C) = Valor Then GET_COLUNA = C: Exit Function
Next
End Function
