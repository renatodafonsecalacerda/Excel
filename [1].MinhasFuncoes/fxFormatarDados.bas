Attribute VB_Name = "fxFormatarDados"
Function fxformataGeral(coluna As String)
'
' Função para Formatar para o formato de Geral
'

    Columns(coluna & ":" & coluna).Select
    Selection.NumberFormat = "General"
End Function

Function fxFormataParaData(coluna As String)
'
' Função para Formatar para o formato de Data
'

'
    Columns(coluna & ":" & coluna).Select
    Selection.NumberFormat = "m/d/yyyy"
End Function
Function fxFormataCentraliza(r As String)
'
' FormataCentraliza Macro
'

'
    Columns(r).Select
    With Selection
        .VerticalAlignment = xlCenter
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
End Function
Function fxFormataEsquerda(r As String)
'
' fxFormataEsquerda Macro
'

'
    Columns(r).Select
    With Selection
        .HorizontalAlignment = xlLeft
        .VerticalAlignment = xlCenter
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    With Selection
        .HorizontalAlignment = xlLeft
        .VerticalAlignment = xlCenter
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
End Function
Sub fxFormataCentralizadoRange(colunaInicial As String, colunaFinal As String)
'
' fxFormataCentralizadoRange Macro
'

'
    Columns(colunaInicial & ":" & colunaFinal).Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlBottom
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
End Sub
Sub fxFormataLargura(colunaInicial As String, colunaFinal As String, largura As Double)
'
' fxFormataLargura Macro
'

'
    Columns(colunaInicial & ":" & colunaFinal).ColumnWidth = largura
End Sub
