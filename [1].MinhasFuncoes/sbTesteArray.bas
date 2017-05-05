Attribute VB_Name = "sbTesteArray"
Sub testeArray()
    Dim a As Range
    Dim arr() As Variant
    
    ReDim arr(0 To 0)                       'Allocate first element
    For Each a In Range("A1:A4").Cells
    arr(UBound(arr)) = a.Value          'Assign the array element
    ReDim Preserve arr(UBound(arr) + 1) 'Allocate next element
    Next
    ReDim Preserve arr(LBound(arr) To UBound(arr) - 1)  'Deallocate the last, unused element

    ' remove from array
    v = "sl2"
    
        For c = 0 To UBound(arr)
            If v = arr(c) Then
                arr(c) = ""
            End If
        Next
    
End Sub

