Attribute VB_Name = "fxColumn"
Function fxColumnLetter(ColumnNumber As Long) As String
    Dim n As Long
    Dim c As Byte
    Dim s As String

    n = ColumnNumber
    Do
        c = ((n - 1) Mod 26)
        s = Chr(c + 65) & s
        n = (n - c) \ 26
    Loop While n > 0
    ColumnLetter = s
End Function
