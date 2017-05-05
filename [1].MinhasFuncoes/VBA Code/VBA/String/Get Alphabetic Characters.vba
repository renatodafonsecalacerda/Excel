Const AllLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
Dim i As Integer
Dim strChar As String * 1
Dim strAlphaOnly As String
For i = 1 To Len(<String:Input>)
    strChar = Mid(<String:Input>, i, 1)
    If InStr(AllLetters, strChar) > 0 Then strAlphaOnly = strAlphaOnly & strChar
Next i