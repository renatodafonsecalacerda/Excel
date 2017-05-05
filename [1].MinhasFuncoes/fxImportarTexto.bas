Attribute VB_Name = "fxImportarTexto"
Public Sub ImportarTexto()
    Dim Ficheiro As String
    Ficheiro = "D:\DOCUMENTOS\Texto.txt"
    
    Dim rg As Range
    Set rg = Range("A1")
    
    Open Ficheiro For Input As #1
    
    Dim S As String, N As Integer, C As Integer, X As Variant
    Do Until EOF(1)
        Line Input #1, S
        C = 0
        X = Split(S, " ")
        For N = 0 To UBound(X)
            If X(N) <> "" Then
                rg.Offset(0, C) = X(N)
                C = C + 1
            End If
        Next N
        Set rg = rg.Offset(1, 0)
    Loop
    
    Close #1
End Sub
