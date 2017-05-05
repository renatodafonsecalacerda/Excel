Attribute VB_Name = "fxSelfModifyCode"
' Note that the current module ought not to be added to
' as it's already been compiled and new bits aren't recognised. Note also that you
' have to use Application.Run instead of just calling the procedure because otherwise
' VBA generates a compile-time error.

' Chris Rae, 15/10/99.

Sub ModifyCode()
    AddLines "Newmodule", "Sub Test", "msgbox ""hello""", "End Sub"
    Application.Run "Test"
End Sub
Sub AddLines(stModuleName As String, ParamArray stLines() As Variant)
    Dim inRunThrough As Integer
    With Application.VBE.ActiveVBProject.VBComponents.Add(vbext_ct_StdModule)
        .Name = stModuleName
        For inRunThrough = 0 To UBound(stLines())
            .CodeModule.InsertLines .CodeModule.CountOfLines + 1, stLines(inRunThrough)
        Next inRunThrough
    End With
End Sub
