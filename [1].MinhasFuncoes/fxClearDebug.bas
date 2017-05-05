Attribute VB_Name = "fxClearDebug"
Sub DeleteTextInDebugWindow1()
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    Application.VBE.Windows("Immediate").SetFocus
    DoEvents
    SendKeys "^a{Delete}", True
    DoEvents
End Sub
Sub DeleteTextInDebugWindow2()
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    Application.VBE.Windows("Immediate").SetFocus
    Application.VBE.CommandBars("Menu Bar").Controls("&Edit").Controls("Select &All").Execute
    SendKeys "{Del}"
End Sub
Sub DeleteTextInDebugWindow3()
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    SendKeys "^g^a{del}"
End Sub
