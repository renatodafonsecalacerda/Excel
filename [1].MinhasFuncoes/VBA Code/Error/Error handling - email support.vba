<include basErrorHandle.bas><NoNewLine>
On Error GoTo HandleError
<cursor>
HandleExit:
Exit <proceduretype>
HandleError:
ErrorHandle Err, Erl(), "<modulename>.<procedurename>"
Resume HandleExit