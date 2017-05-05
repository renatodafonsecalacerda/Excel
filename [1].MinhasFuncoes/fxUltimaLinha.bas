Attribute VB_Name = "fxUltimaLinha"
Public Function UltimaLinha(PLAN As Worksheet, COLUNA As Integer)
    UltimaLinha = PLAN.Cells(65000, COLUNA).End(xlUp).Row
End Function
