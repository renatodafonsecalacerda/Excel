Attribute VB_Name = "fxRevInStr"
Function RevInStr(findin As String, tofind As String) As Integer
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    Dim findcha As Integer
    For findcha = Len(findin) - Len(tofind) + 1 To 1 Step -1
        If Mid(findin, findcha, Len(tofind)) = tofind Then
            RevInStr = findcha
            Exit Function
        End If
    Next findcha
    ' Defaults to zero anyway (tsk, tsk, etc)
End Function
