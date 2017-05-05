Dim sep as String: sep = ";"
If Len(<String:List1>) = 0 Then
    <String:NewList> = <String:List2>
Else
    If Len(<String:List2>) = 0 Then
        <String:NewList> = <String:List1>
    Else
        <String:NewList> = <String:List1> & sep & <String:List2>
    End If
End If