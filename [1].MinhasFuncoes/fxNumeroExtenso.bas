Attribute VB_Name = "fxNumeroExtenso"
Function NumeroExtenso(ByVal numero) ''Escreve numero por extenso
Dim Reais, Centavos, Temp
Dim PontoDecimal, Contar
ReDim lugar(9) As String
lugar(2) = " Mil "
lugar(3) = " Milhões "
lugar(4) = " Bilhões"
lugar(5) = " Trilhões"

numero = Trim(Str(numero))
''Posição da casa decimal se 0 numero inteiro
PontoDecimal = InStr(numero, ".")
''Converter centavos
If PontoDecimal > 0 Then
Centavos = GetDez(Left(Mid(numero, PontoDecimal + 1) & "00", 2))
numero = Trim(Left(numero, PontoDecimal - 1))
End If
Contar = 1
Do While numero <> ""
Temp = GetCem(Right(numero, 3))
If Temp <> "" Then Reais = Temp & lugar(Contar) & Reais
If Len(numero) > 3 Then
numero = Left(numero, Len(numero) - 3)
Else
numero = ""
End If
Contar = Contar + 1
Loop
Select Case Reais
Case ""
Reais = ""
Case " Um"
Reais = " Um Real"
Case Else
Reais = Reais & " Reais"
End Select
Select Case Centavos
Case ""
Centavos = ""
Case " Um"
Centavos = "Um centavo"
Case Else
Centavos = Centavos & " Centavos"
End Select
If Reais <> "" And Centavos <> "" Then
NumeroExtenso = Reais & " e " & Centavos
ElseIf Reais <> "" Then
NumeroExtenso = Reais
Else
NumeroExtenso = Centavos
End If
End Function

'' Converter um numero entre 100 e 999 em texto
Function GetCem(ByVal numero)
Dim resultado As String
If Val(numero) = 0 Then Exit Function
numero = Right("000" & numero, 3)
If Mid(numero, 1, 1) <> "0" Then
resultado = GetDigit(Mid(numero, 1, 1)) '' ALTERAR ESTÁ FUNÇÃO SE 1=CEM ; 2 = DUZENTOS
Select Case resultado
Case " Um": resultado = " Cento e "
Case " Dois": resultado = " Duzentos "
Case " Três": resultado = " Trezentos "
Case " Quatro": resultado = " Quatrocentos "
Case " Cinco": resultado = " Quinhentos "
Case " Seis": resultado = " Seiscentos "
Case " Sete": resultado = " Setecentos "
Case " Oito": resultado = " Oitocentos "
Case " Nove": resultado = " Novecentos "
End Select


End If
'' Converte um numero entre 01 e 10 em texto
If Mid(numero, 2, 1) <> "0" Then
resultado = resultado & GetDez(Mid(numero, 2))
Else
resultado = resultado & GetDigit(Mid(numero, 3))
End If
GetCem = resultado
End Function

'' Converte um numero de 10 a 99 em texto
Function GetDez(DezTXT)
Dim result As String
result = "" ''Nulo
If Val(Left(DezTXT, 1)) = 1 Then ''Se valor entre 10-19
Select Case Val(DezTXT)
Case 10: result = "Dez"
Case 11: result = "Onze"
Case 12: result = "Doze"
Case 13: result = "Treze"
Case 14: result = "Quatorze"
Case 15: result = "Quinze"
Case 16: result = "Dezesseis"
Case 17: result = "Dezesete"
Case 18: result = "Dezoito"
Case 19: result = "Dezenove"
Case Else
End Select
Else '' Valores entre 20-99
Select Case Val(Left(DezTXT, 1))
Case 2: result = " Vinte"
Case 3: result = " Trinta"
Case 4: result = " Quarenta"
Case 5: result = " Cinquenta"
Case 6: result = " Sessenta"
Case 7: result = " Setenta"
Case 8: result = " Oitenta"
Case 9: result = " Noventa"
Case Else
End Select
result = result & GetDigit(Right(DezTXT, 1)) '' retorna um unico valor
End If
GetDez = result
End Function
''Converte numeros entre 1 e 9 em texto
Function GetDigit(Digit)
Select Case Val(Digit)
Case 1: GetDigit = " Um"
Case 2: GetDigit = " Dois"
Case 3: GetDigit = " Três"
Case 4: GetDigit = " Quatro"
Case 5: GetDigit = " Cinco"
Case 6: GetDigit = " Seis"
Case 7: GetDigit = " Sete"
Case 8: GetDigit = " Oito"
Case 9: GetDigit = " Nove"
Case Else: GetDigit = ""
End Select
End Function

