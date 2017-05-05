Dim strIllegalChars As String: strIllegalChars = "?[]/\=+<>:;,*" & Chr(34) & Chr(39)  'add/remove characters you need removed to this string
Dim i As Integer
Dim strChar As String * 1
Dim strIllegalCharsRemoved As String
For i = 1 To Len(<String:Input>)
    strChar = Mid(<String:Input>, i, 1)
    If InStr(strIllegalChars, strChar) = 0 Then strIllegalCharsRemoved = strIllegalCharsRemoved & strChar
Next i