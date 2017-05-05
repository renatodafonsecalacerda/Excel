Attribute VB_Name = "fxUltimaColuna"
Public Function UltimaColuna(NomeDaPlanilha As String, Linha As Integer, COLUNA As Integer)
Dim PLAN As Worksheet
Set PLAN = Sheets(NomeDaPlanilha)
    UltimaColuna = PLAN.Cells(Linha, COLUNA).End(xlToLeft).Column
End Function
