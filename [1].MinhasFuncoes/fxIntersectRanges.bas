Attribute VB_Name = "fxIntersectRanges"
Private Sub UseIntersection()
    IntersectRanges Range("A1:D5"), Range("C3:C10")
End Sub
 
Private Sub IntersectRanges(range1 As Range, range2 As Range)
    Dim intRange As Range
 
    ' Application.Intersect Method
    Set intRange = Application.Intersect(range1, range2)
 
    If intRange Is Nothing Then
        ' No Intersection
        MsgBox "Ranges Do Not Intersect!"
    Else
        range1.Select
        range2.Select
        
        ' Show new Range's address
        MsgBox (intRange.Address)
        
        ' Select new Range
        intRange.Select
    End If
End Sub
