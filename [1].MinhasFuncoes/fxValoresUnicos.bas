Attribute VB_Name = "fxValoresUnicos"
Public Function ValoresUnicos(intervalo As Range, Optional opcao As Integer = -1) As Collection
   Dim celula, valores As New Collection, valor As Variant, achou As Boolean
   For Each celula In intervalo
      If Trim(celula) <> "" And _
         ((opcao = -1) Or (opcao = 0 And Not IsNumeric(celula)) Or (opcao = 1 And IsNumeric(celula))) Then
         achou = False
         For Each valor In valores
            If valor = celula Then
               achou = True
               Exit For
            End If
         Next
         If Not achou Then valores.Add celula.Value
      End If
   Next
   Set ValoresUnicos = valores
   Set valores = Nothing
End Function

Sub sample()
    Dim dados As Collection
    Dim r As Range
    Set p = Sheets("DADOS")
    Set c = Sheets("CONFIG")
    p.Activate
    Set r = p.Range("B2:B" & UltimaLinha(p, 2))
    
    Set dados = ValoresUnicos(r)
    c_datas = GET_COLUNA(c, "Datas de Pesquisas", 1)
    Linha = 2
    c.Activate
    For Each d In dados
        c.Cells(Linha, c_datas) = d: Linha = Linha + 1
    Next
End Sub
