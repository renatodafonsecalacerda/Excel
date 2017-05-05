Attribute VB_Name = "fxDoesItemExist"
' Retirado de:
' http://www.mrexcel.com/forum/excel-questions/277889-visual-basic-applications-check-if-string-exists-within-collection.html
Function DoesItemExist(set1 As Range, set2 As Range) As Boolean
Dim cfind As Range
Dim myNum As Integer

DoesItemExist = False

Dim x
x = set1.Value

With set2
    Set cfind = .Cells.Find(what:=x, lookat:=xlPart)
    If Not cfind Is Nothing Then DoesItemExist = True
End With

End Function

Public Function fxDoesItemExist1(mySet As Collection, myCheck As String) As Boolean
Dim myNum As Integer
    DoesItemExist = False
    For myNum = 1 To mySet.Count
        If myCheck = mySet(myNum) Then
            DoesItemExist = True
            Exit Function
        End If
    Next
End Function
Public Function fxDoesItemExist2(mySet As Collection, myCheck As String) As Boolean
    DoesItemExist = False
    For Each elm In mySet
        If myCheck = elm Then
            DoesItemExist = True
            Exit Function
        End If
    Next
End Function


Sub test()
Dim set1 As Range
Dim set2 As Range
Dim c As Range
Dim y As Boolean

Set set1 = Range("a1:a12")
Set set2 = Range("B1:B12")

For Each c In set1
    y = DoesItemExist(c, set2)

    MsgBox "existence of  " & c & " " & y
Next
End Sub
