Attribute VB_Name = "fxShape"
Sub CheckForShape()
    Dim sHape As sHape
     
    On Error Resume Next
    Set sHape = Sheet1.Shapes("Box 1")
    On Error GoTo 0
     
    If sHape Is Nothing Then
        MsgBox "Box 1 does not exist on " & Sheet1.Name
        Exit Sub
    End If
     
     'YOUR CODE
End Sub
Sub MainTest()
Dim p As Worksheet
Set p = Sheets("Plan1")
valor = ChkShape(p, "star1")
MsgBox valor
End Sub
Sub MainTest2()
'Dim sh As sHape
For Each sh In ActiveWindow.Selection.ShapeRange
    
    If Not IsEmpty(sh) Then
        sh.TextFrame2.TextRange = "Initially selected"
    End If
Next
End Sub



Public Function ChkShape(p As Worksheet, nome_do_shape As String) As Boolean
Dim sHape As sHape
     
    On Error Resume Next
    Set sHape = p.Shapes(nome_do_shape)
    On Error GoTo 0
     
    If sHape Is Nothing Then
        ChkShape = False
    Else
        ChkShape = True
    End If
End Function

