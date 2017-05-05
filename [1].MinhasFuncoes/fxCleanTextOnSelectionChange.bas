Attribute VB_Name = "fxCleanTextOnSelectionChange"
'Private Sub Worksheet_SelectionChange(ByVal Target As Range)
'Call CleanText(3, Target)
'Call CleanText(5, Target)
'End Sub
Function CleanText(ByVal coluna As Integer, ByVal Target As Range)
oldVal = Target.Value
Target.Value = newValue
If Target.Column = coluna Then
    If oldVal = "" Then
    Else
        If newVal = "" Then
        Else
            Target.Value = oldVal & ", " & newVal
        End If
    End If
End If
End Function

