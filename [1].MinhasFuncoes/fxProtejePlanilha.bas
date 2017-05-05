Attribute VB_Name = "fxProtejePlanilha"
Private Sub Proteger()

ActiveSheet.Protect DrawingObjects:=False, Contents:=True, Scenarios:= _
True, AllowFormattingCells:=True, AllowFormattingColumns:=True, _
AllowFormattingRows:=True

End Sub

Private Sub Desproteger()

ActiveSheet.Unprotect

End Sub

