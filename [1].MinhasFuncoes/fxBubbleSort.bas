Attribute VB_Name = "fxBubbleSort"
Sub BubbleSort(ToSort As Variant, Optional SortAscending As Boolean = True)
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    ' By Chris Rae, 19/5/99. My thanks to
    ' Will Rickards and Roemer Lievaart
    ' for some fixes.
    Dim AnyChanges As Boolean
    Dim BubbleSort As Long
    Dim SwapFH As Variant
    Do
        AnyChanges = False
        For BubbleSort = LBound(ToSort) To UBound(ToSort) - 1
            If (ToSort(BubbleSort) > ToSort(BubbleSort + 1) And SortAscending) _
               Or (ToSort(BubbleSort) < ToSort(BubbleSort + 1) And Not SortAscending) Then
                ' These two need to be swapped
                SwapFH = ToSort(BubbleSort)
                ToSort(BubbleSort) = ToSort(BubbleSort + 1)
                ToSort(BubbleSort + 1) = SwapFH
                AnyChanges = True
            End If
        Next BubbleSort
    Loop Until Not AnyChanges
End Sub

