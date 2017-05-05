Attribute VB_Name = "fxValorMaximo"
Option Explicit
Dim matrix As Range
Dim i, m, t, valorMaximo
Public Function fxValorMaximo(matrix As Range) As Double
    m = matrix
    valorMaximo = matrix(1)
    For i = LBound(m) To UBound(m)
        If valorMaximo <= matrix(i) Then
            valorMaximo = matrix(i)
        End If
    Next
    fxValorMaximo = valorMaximo
End Function
Sub main_teste()

    t = fxValorMaximo(Range("A1:A5"))
End Sub
