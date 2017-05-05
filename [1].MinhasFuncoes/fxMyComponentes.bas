Attribute VB_Name = "fxMyComponentes"
Dim WBCodeMod
Public Function MyComponentes(componente As String) As Boolean
 For Each c In ActiveWorkbook.VBProject.VBComponents
        If (c.Properties("Name") = componente) Then
            Set WBCodeMod = c.CodeModule
            MyComponentes = True
        End If
    Next
End Function

Sub main()
Dim t As Boolean

t = MyComponentes("fxMyComponentes")

MsgBox t

End Sub
