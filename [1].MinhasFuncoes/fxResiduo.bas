Attribute VB_Name = "fxResiduo"
Function Residuo(numero As Double)
inteiro = Int(numero)
Residuo = numero - inteiro
End Function

Function MesesFaltantes(numero As Double)
    MesesFaltantes = Residuo(numero) * 30
End Function


