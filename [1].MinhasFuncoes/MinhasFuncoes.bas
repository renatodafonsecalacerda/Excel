Attribute VB_Name = "MinhasFuncoes"
Function inverte(valor As String)
Dim novo_valor As String
For x = Len(valor) To 1 Step -1
    novo_valor = novo_valor & Mid(valor, x, 1)
Next
inverte = novo_valor
End Function

Function TIRA_ACENTOS(N)
N = Replace(N, "  ", " ")
N = Replace(N, "   ", " ")
N = Replace(N, "    ", " ")
N = UCase(N)
For conta = 1 To Len(N)
    valor = Mid(N, conta, 1)
    Select Case UCase(valor)
        Case "Á"
            LETRA = "A"
        Case "Â"
            LETRA = "A"
        Case "À"
            LETRA = "A"
        Case "Ä"
            LETRA = "A"
        Case "Ã"
            LETRA = "A"
        Case "É"
            LETRA = "E"
        Case "Ê"
            LETRA = "E"
        Case "È"
            LETRA = "E"
        Case "Ë"
            LETRA = "E"
        Case "Í"
            LETRA = "I"
        Case "Î"
            LETRA = "I"
        Case "Ì"
            LETRA = "I"
        Case "Ï"
            LETRA = "I"
        Case "Ó"
            LETRA = "O"
        Case "Ô"
            LETRA = "O"
        Case "Ò"
            LETRA = "O"
        Case "Ö"
            LETRA = "O"
        Case "Õ"
            LETRA = "O"
        Case "Ú"
            LETRA = "U"
        Case "Û"
            LETRA = "U"
        Case "Ù"
            LETRA = "U"
        Case "Ü"
            LETRA = "U"
        Case "Ç"
            LETRA = "C"
        Case "Ñ"
            LETRA = "N"
        Case "'"
            LETRA = " "
        Case Else
            LETRA = Mid(N, conta, 1)
    End Select
    nome = nome & LETRA
    'If InStr(1, NOME, "(ITA)") Then
    '    NOME = Left(NOME, InStr(1, NOME, "(ITA)") - 1)
    '    If Right(NOME, 1) = " " Then NOME = Left(NOME, Len(NOME) - 1)
    'End If
Next
TIRA_ACENTOS = nome
End Function
Public Function UltimaColuna(NomeDaPlanilha As String, Linha As Integer, COLUNA As Integer)
Dim PLAN As Worksheet
Set PLAN = Sheets(NomeDaPlanilha)
    UltimaColuna = PLAN.Cells(Linha, COLUNA).End(xlToLeft).Column
End Function

Public Function UltimaLinha(PLAN As Worksheet, COLUNA As Integer)
    UltimaLinha = PLAN.Cells(65000, COLUNA).End(xlUp).Row
End Function
Public Function GetDados(PLAN As Worksheet, Linha As Integer, COLUNA As Integer)
    GetDados = TIRA_ACENTOS(PLAN.Cells(Linha, COLUNA).Value)
End Function

Public Function GetDados_Pesquisa(PLAN As Worksheet, Linha As Integer, pesquisa As Variant)
    For Each c In PLAN.Cells
        If UCase(c) = UCase(pesquisa) Then
            COLUNA = c.Column
            Exit For
        End If
    Next
    'Plan.Range(Cells(linha, coluna), Cells(linha, coluna)).Select
    GetDados_Pesquisa = PLAN.Cells(Linha, COLUNA).Value
End Function
Public Function AchaColuna(PLAN As Worksheet, valor As Variant) As Integer
    For Each c In PLAN.Cells
        If Trim(UCase(c)) = Trim(UCase(valor)) Then
            COLUNA = c.Column
            Exit For
        End If
    Next
    AchaColuna = COLUNA
End Function
Public Function AchaLinha(PLAN As Worksheet, valor As Variant) As Integer
    For Each c In PLAN.Cells
        If Trim(UCase(c)) = Trim(UCase(valor)) Then
            COLUNA = c.Row
            Exit For
        End If
    Next
    AchaLinha = COLUNA
End Function
Public Function FORMATAR(NomeDaPlanilha As String, COLUNA As Integer, NOMEFORMATO As String, LINHAINICIAL As Integer, COLUNAINICIAL As Integer)
Dim PLAN As Worksheet
Set PLAN = Sheets(NomeDaPlanilha)
Dim ultlinha, ultcoluna
    ultlinha = UltimaLinha(PLAN, COLUNA)
    ultcoluna = UltimaColuna(PLAN.Name, LINHAINICIAL - 1, 200)
    PLAN.Range(NOMEFORMATO).Copy
    PLAN.Range(Cells(LINHAINICIAL, COLUNAINICIAL), Cells(ultlinha, ultcoluna)).Select
    Selection.PasteSpecial xlPasteFormats
End Function
Function NamedRangeExists(strName As String, _
    Optional wbName As String) As Boolean
     'Declare variables
    Dim rngTest As Range, i As Long
     
     'Set workbook name if not set in function, as default/activebook
    If wbName = vbNullString Then wbName = ActiveWorkbook.Name
     
    With Workbooks(wbName)
        On Error Resume Next
         
         'Loop through all sheets in workbook.  In VBA, you MUST specify
         ' the worksheet name which the named range is found on.  Using
         ' Named Ranges in worksheet functions DO work across sheets
         ' without explicit reference.
        For i = 1 To .Sheets.Count Step 1
             
             'Try to set our variable as the named range.
            Set rngTest = .Sheets(i).Range(strName)
             
             'If there is no error then the name exists.
            If Err = 0 Then
                 
                 'Set the function to TRUE & exit
                NamedRangeExists = True
                Exit Function
            Else
                 'Clear the error
                Err.Clear
                 
            End If
             
        Next i
         
    End With
     
End Function
'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= ARRENDODAMENTOS =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
'  AsymDown      Arredonda assimetricamente os números para menos - semelhante a Int().
'                 Os números negativos ficam mais negativos.
'  SymDown       Arredonda simetricamente os números para menos - semelhante a Fix().
'                 Trunca todos os números para 0.
'                 Igual a AsymDown para números positivos.
'
'   AsymUp        Arredonda assimetricamente as frações numéricas para mais.
'                 Igual a SymDown para números negativos.
'                 Semelhante a Ceiling.
'
'   SymUp          Arredonda simetricamente as frações para mais - isto é, além de 0.
'                 Igual a AsymUp para números positivos.
'                 Igual a AsymDown para números negativos.
'
'   AsymArith     Arredondamento aritmético assimétrico - arredonda .5 sempre para mais.
'                 Semelhante à função Round da planilha do Java.
'
'   SymArith      Arredondamento aritmético simétrico - arredonda .5 além de 0.
'                 Igual a AsymArith para números positivos.
'                 Semelhante à função Round da Planilha do Excel.
'
'   BRound Banker       's rounding.
'                 Arredonda .5 para mais ou para menos para chegar a um número par.
'                 Simétrica por definição.
'
'   RandRound     Arredondamento Aleatório.
'                 Arredonda .5 para mais ou para menos de maneira aleatória.
'
'   AltRound      Arredondamento alternativo.
'                 Alterna entre arredondar .5 para mais ou para menos.
'
'   ATruncDigits  Igual a AsyncTrunc, mas com argumentos diferentes.
'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Function AsymDown(ByVal x As Double, _
            Optional ByVal Factor As Double = 1) As Double
     AsymDown = Int(x * Factor) / Factor
   End Function

   Function SymDown(ByVal x As Double, _
            Optional ByVal Factor As Double = 1) As Double
     SymDown = Fix(x * Factor) / Factor
   '  Alternately:
   '  SymDown = AsymDown(Abs(X), Factor) * Sgn(X)
   End Function

   Function AsymUp(ByVal x As Double, _
            Optional ByVal Factor As Double = 1) As Double
   Dim Temp As Double
     Temp = Int(x * Factor)
     AsymUp = (Temp + IIf(x = Temp, 0, 1)) / Factor
   End Function

   Function SymUp(ByVal x As Double, _
            Optional ByVal Factor As Double = 1) As Double
   Dim Temp As Double
     Temp = Fix(x * Factor)
     SymUp = (Temp + IIf(x = Temp, 0, Sgn(x))) / Factor
   End Function

   Function AsymArith(ByVal x As Double, _
            Optional ByVal Factor As Double = 1) As Double
     AsymArith = Int(x * Factor + 0.5) / Factor
   End Function

   Function SymArith(ByVal x As Double, _
            Optional ByVal Factor As Double = 1) As Double
     SymArith = Fix(x * Factor + 0.5 * Sgn(x)) / Factor
   '  Alternately:
   '  SymArith = Abs(AsymArith(X, Factor)) * Sgn(X)
   End Function

   Function BRound(ByVal x As Double, _
            Optional ByVal Factor As Double = 1) As Double
   '  For smaller numbers:
   '  BRound = CLng(X * Factor) / Factor
   Dim Temp As Double, FixTemp As Double
     Temp = x * Factor
     FixTemp = Fix(Temp + 0.5 * Sgn(x))
     ' Handle rounding of .5 in a special manner
     If Temp - Int(Temp) = 0.5 Then
       If FixTemp / 2 <> Int(FixTemp / 2) Then ' Is Temp odd
         ' Reduce Magnitude by 1 to make even
         FixTemp = FixTemp - Sgn(x)
       End If
     End If
     BRound = FixTemp / Factor
   End Function

   Function RandRound(ByVal x As Double, _
            Optional ByVal Factor As Double = 1) As Double
   ' Should Execute Randomize statement somewhere prior to calling.
   Dim Temp As Double, FixTemp As Double
     Temp = x * Factor
     FixTemp = Fix(Temp + 0.5 * Sgn(x))
     ' Handle rounding of .5 in a special manner.
     If Temp - Int(Temp) = 0.5 Then
       ' Reduce Magnitude by 1 in half the cases.
       FixTemp = FixTemp - Int(Rnd * 2) * Sgn(x)
     End If
     RandRound = FixTemp / Factor
   End Function

   Function AltRound(ByVal x As Double, _
            Optional ByVal Factor As Double = 1) As Double
   Static fReduce As Boolean
   Dim Temp As Double, FixTemp As Double
     Temp = x * Factor
     FixTemp = Fix(Temp + 0.5 * Sgn(x))
     ' Handle rounding of .5 in a special manner.
     If Temp - Int(Temp) = 0.5 Then
       ' Alternate between rounding .5 down (negative) and up (positive).
       If (fReduce And Sgn(x) = 1) Or (Not fReduce And Sgn(x) = -1) Then
       ' Or, replace the previous If statement with the following to
       ' alternate between rounding .5 to reduce magnitude and increase
       ' magnitude.
       ' If fReduce Then
         FixTemp = FixTemp - Sgn(x)
       End If
       fReduce = Not fReduce
     End If
     AltRound = FixTemp / Factor
   End Function

   Function ADownDigits(ByVal x As Double, _
            Optional ByVal Digits As Integer = 0) As Double
     ADownDigits = AsymDown(x, 10 ^ Digits)
   End Function
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


