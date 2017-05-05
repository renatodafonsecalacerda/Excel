Attribute VB_Name = "fxInRange"
'Verifica se a célula está no intervalo se sim retorna true
Function inRange(ByVal celula As Range, intervalo As Range) As Boolean
    For Each e In intervalo
        If e.Value = celula Then inRange = True: Exit For
    Next
End Function
