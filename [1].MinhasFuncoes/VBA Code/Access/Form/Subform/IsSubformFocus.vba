On Error Resume Next
Dim x As Object
Set x = Screen.ActiveControl.Parent
If Not TypeOf x Is Access.Form Then Set x = x.Parent
Set x = x.Parent
<Boolean:IsSubformFocus> = Not CBool(Err.Number)
Err.Clear