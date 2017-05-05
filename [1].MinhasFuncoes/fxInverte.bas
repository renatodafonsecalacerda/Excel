Attribute VB_Name = "fxInverte"
Function inverte(valor As String)
Dim novo_valor As String
For x = Len(valor) To 1 Step -1
    novo_valor = novo_valor & Mid(valor, x, 1)
Next
inverte = novo_valor
End Function
