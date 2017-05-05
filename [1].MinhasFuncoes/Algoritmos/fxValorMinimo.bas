Attribute VB_Name = "fxValorMinimo"
Public Function fxValorMinimo(matrix As Range) As Integer
    m = matrix
    valorMinimo = matrix(1)
    For i = LBound(m) To UBound(m)
        If valorMinimo >= matrix(i) Then
            valorMinimo = matrix(i)
        End If
    Next
    fxValorMinimo = valorMinimo
End Function
Sub main_teste()
    Range("b2") = fxValorMinimo(Range("A1:A5"))
End Sub
