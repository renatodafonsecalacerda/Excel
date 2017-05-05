Attribute VB_Name = "fxContarValoresUnicos"
Public Function ContarDistinct(intervalo As Range, Optional opcao As Integer = -1) As Long
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
   ContarDistinct = valores.Count
   Set valores = Nothing
End Function

