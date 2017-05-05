Attribute VB_Name = "fxArrendondar"
Function Arredondar(valor As Double, Optional qtdcasas As Integer = 2) As Double
Dim inteiro As Integer
Dim decimais As Double
Dim valor_novo, v1, v2, v3 As Integer

inteiro = Int(valor)
decimais = Mid(valor - inteiro, 3, 999999)

If qtdcasas >= Len(decimais) Then
    Arredondar = Mid(Val(inteiro & "." & decimais), 1, qtdcasas + 2)
Else
    v1 = Mid(decimais, 1, qtdcasas + 1)
    v2 = Right(v1, 1)
    v3 = Right(Mid(decimais, qtdcasas, 1), 1)
    valor_novo = Mid(decimais, 1, qtdcasas - 1)
    If v2 >= 5 Then v3 = v3 + 1
    
    valor_novo = valor_novo & v3
    
    Arredondar = Mid(Val(inteiro & "." & valor_novo), 1, qtdcasas + 2)
End If
End Function
