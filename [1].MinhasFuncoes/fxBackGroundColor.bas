Attribute VB_Name = "fxBackGroundColor"
Function GET_BACKGROUNDCOLOR()
    GET_BACKGROUNDCOLOR = ActiveCell.Interior.Color
End Function

Function GET_RANGE_BACKGROUNDCOLOR(R As Range)
    GET_RANGE_BACKGROUNDCOLOR = R.Interior.Color
End Function

Sub FormataLinha(R As Range, OrigemCor As Range)
    R.Interior.Color = GET_RANGE_BACKGROUNDCOLOR(OrigemCor)
End Sub

Function SetBackGroundColor(R As Range, cor As Integer)
    R.Interior.Color = cor
End Function

Sub teste()
    Call FormataLinha(Range("H4:aa4"), Range("d1"))
End Sub
Sub GetBackColor()
 Debug.Print GET_RANGE_BACKGROUNDCOLOR(Sheets("Resumo Pedagogico").Range("g8"))
End Sub
