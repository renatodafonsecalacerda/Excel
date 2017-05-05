With Me.fsub 'Name of the subform control
    .SetFocus
    If .Form.CurrentView = acCurViewDatasheet Then
        DoCmd.RunCommand acCmdSubformFormView
    Else
        DoCmd.RunCommand acCmdSubformDatasheetView
    End If
End With
