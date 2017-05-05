Attribute VB_Name = "fxWorkSheets"
Function setWorkSheet(nome As String) As Worksheet
    Set setWorkSheet = Sheets(nome)
End Function

Public Function addWorkSheet(nome As String) As Boolean
If Sheets(nome).name <> nome Then
    Set MyFunction = Sheets.Add
    MyFunction.name = SheetArgument
Else
    If (MsgBox("A planilha já existe", vbYesNo) = vbYes) Then
        deleteWorkSheet (nome)
    End If
End If
End Function
Public Function deleteWorkSheet(nome As String) As Boolean
    Sheets(nome).Delete
End Function

Sub teste()
'Dim p As Worksheet
Set p = setWorkSheet("Plan1")
'MsgBox p.Range("b1")
Set p2 = addWorkSheet("teste")
'deleteWorkSheet ("teste")
End Sub
