Dim strMsg As String: strMsg = "Do you want to add " & NewData & " to the table?"
If MsgBox(Prompt:=strMsg, Buttons:=vbQuestion + vbYesNo, Title:="Add new name?") = vbNo Then
    Response = acDataErrContinue
Else
    Dim db As Database
    Set db = CurrentDb
    Dim rst As Recordset
    Set rst = db.OpenRecordset("<cursor>", dbOpenDynaset) 'TODO: Add table name
    On Error Resume Next
    rst.AddNew
        rst! = NewData 'TODO: Add field name after rst!
    rst.Update    
    If Err Then
        MsgBox "An error occurred. Please try again."
        Response = acDataErrContinue
    Else
        Response = acDataErrAdded
    End If
End If
