Attribute VB_Name = "fxUltimaLinhaComValor"
'xlCellType constants    Value
'xlCellTypeAllFormatConditions. Cells of any format  -4172
'xlCellTypeAllValidation. Cells having validation criteria   -4174
'xlCellTypeBlanks. Empty cells   4
'xlCellTypeComments. Cells containing notes  -4144
'xlCellTypeConstants. Cells containing constants 2
'xlCellTypeFormulas. Cells containing formulas   -4123
'xlCellTypeLastCell. The last cell in the used range 11
'xlCellTypeSameFormatConditions. Cells having the same format    -4173
'xlCellTypeSameValidation. Cells having the same validation criteria -4175
'xlCellTypeVisible. All visible cells

Sub sbSelecionaUltimaLinhaComValor()
    ActiveSheet.Cells.SpecialCells(xlCellTypeLastCell).Activate
End Sub


Sub sbLimpaFormulasPlanilhaAtual()
    ActiveSheet.Cells.SpecialCells(xlCellTypeFormulas).Select '.Activate
    Selection.ClearContents
End Sub

Sub fxLimpaFormulasPlanilhaAtual(Optional p As Worksheet)
    If IsEmpty(p) Then Set p = ActiveSheet
    p.Cells.SpecialCells(xlCellTypeFormulas).Select
    Selection.ClearContents
End Sub

Public Function fxUltimaLinhaComValor(p As Worksheet) As Double
    fxUltimaLinhaComValor = p.Range("a1").SpecialCells(xlCellTypeLastCell).Row
End Function

Public Function fxUltimaColunaComValor() As Double
    fxUltimaColunaComValor = ActiveSheet.Cells.SpecialCells(xlLastCell).Column
End Function

Sub TESTE_sbUltimaColunaComValor()
    lCol = ActiveSheet.Cells.SpecialCells(xlLastCell).Column
    MsgBox lCol
End Sub
