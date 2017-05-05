<NoNewLine>
On Error GoTo HandleError
DoCmd.RunCommand acCmdSaveRecord
DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
HandleExit:
Exit Sub
HandleError:
MsgBox Err.Description
Resume HandleExit