<NoNewLine>
On Error GoTo HandleError
<cursor>
HandleExit:
Exit <proceduretype>
HandleError:
MsgBox Err.Description
Resume HandleExit