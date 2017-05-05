<Variant:List> = 'Array("b", "a")
Dim First As Long, Last As Long
Dim i As Long, j As Long
Dim Temp As String
First = LBound(<Variant:List>)
Last = UBound(<Variant:List>)
For i = First To Last - 1
    For j = i + 1 To Last
        If UCase(<Variant:List>(i)) > UCase(<Variant:List>(j)) Then
            Temp = <Variant:List>(j)
            <Variant:List>(j) = <Variant:List>(i)
            <Variant:List>(i) = Temp
        End If
    Next j
Next i