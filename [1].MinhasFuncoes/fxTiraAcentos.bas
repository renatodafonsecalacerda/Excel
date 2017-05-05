Attribute VB_Name = "fxTiraAcentos"
Function TIRA_ACENTOS(N)
N = Replace(N, "  ", " ")
N = Replace(N, "   ", " ")
N = Replace(N, "    ", " ")
N = UCase(N)
For conta = 1 To Len(N)
    valor = Mid(N, conta, 1)
    Select Case UCase(valor)
        Case "Á"
            Letra = "A"
        Case "Â"
            Letra = "A"
        Case "À"
            Letra = "A"
        Case "Ä"
            Letra = "A"
        Case "Ã"
            Letra = "A"
        Case "É"
            Letra = "E"
        Case "Ê"
            Letra = "E"
        Case "È"
            Letra = "E"
        Case "Ë"
            Letra = "E"
        Case "Í"
            Letra = "I"
        Case "Î"
            Letra = "I"
        Case "Ì"
            Letra = "I"
        Case "Ï"
            Letra = "I"
        Case "Ó"
            Letra = "O"
        Case "Ô"
            Letra = "O"
        Case "Ò"
            Letra = "O"
        Case "Ö"
            Letra = "O"
        Case "Õ"
            Letra = "O"
        Case "Ú"
            Letra = "U"
        Case "Û"
            Letra = "U"
        Case "Ù"
            Letra = "U"
        Case "Ü"
            Letra = "U"
        Case "Ç"
            Letra = "C"
        Case "Ñ"
            Letra = "N"
        Case "'"
            Letra = " "
        Case Else
            Letra = Mid(N, conta, 1)
    End Select
    nome = nome & Letra
Next
TIRA_ACENTOS = nome
End Function

Function TiraAcento(Palavra)
    CAcento = "àáâãäèéêëìíîïòóôõöùúûüÀÁÂÃÄÈÉÊËÌÍÎÒÓÔÕÖÙÚÛÜçÇñÑ"
    SAcento = "aaaaaeeeeiiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcCnN"
    Texto = ""
    If Palavra <> "" Then
        For X = 1 To Len(Palavra)
            Letra = Mid(Palavra, X, 1)
            Pos_Acento = InStr(CAcento, Letra)
            
            If Pos_Acento > 0 Then
                Letra = Mid(SAcento, Pos_Acento, 1)
            End If
            
            Texto = Texto & Letra
        Next
    TiraAcento = Texto
End If
End Function

Function VerificaPalavra(atributo)

Dim i
Dim id
Dim Auxiliar
Dim Resultado

Auxiliar = Split(atributo, " ", -1, vbBinaryCompare)

For i = LBound(Auxiliar) To UBound(Auxiliar)
    Resultado = Resultado & " " & TiraAcento(Auxiliar(i))
Next

VerificaPalavra = Trim(Resultado)

End Function

