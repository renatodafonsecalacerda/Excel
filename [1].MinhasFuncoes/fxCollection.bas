Attribute VB_Name = "fxCollection"
Public Function ExistsIn(item As Variant, lots As Collection)
    Dim e As Variant
    ExistsIn = False
    For Each e In lots
        If item = e Then
            ExistsIn = True
            Exit For
        End If
    Next
End Function
Public Function RangeToCollection(r As Range, o As Object) As Collection
Dim c As New Collection


End Function
Sub teste()
Dim c As New Collection
Dim p As New oPessoa

p.Nome = "renato"
p.SobreNome = "jose"
p.DataNascimento = "10/11/1978"

c.Add p

Valor = DoesItemExist(c, "jose")
End Sub

Public Function DoesItemExist(mySet As Collection, myCheck As String) As Boolean
    On Error Resume Next
      
    Dim myNum As Integer
        
    DoesItemExist = False
    For myNum = 1 To mySet.Count - 1
        If myCheck = mySet(myNum) Then
            DoesItemExist = True
        End If
    Next
    On Error GoTo 0
End Function
