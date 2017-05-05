Dim i As Integer
Dim strChar As String * 1
Dim strNumericOnly As String
For i = 1 To Len(<String:Input>)
  strChar = Mid(<String:Input>, i, 1)
  If (strChar >= "0") And (strChar <= "9") Then
    strNumericOnly = strNumericOnly & strChar
  End If
Next i