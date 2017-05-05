Attribute VB_Name = "fxCalculationFunctions"
Public screenUpdateState
Public statusBarState
Public calcState
Public eventsState
Sub mainVars()
    screenUpdateState = Application.ScreenUpdating
    statusBarState = Application.DisplayStatusBar
    calcState = Application.Calculation
    eventsState = Application.EnableEvents
End Sub

Sub sbCalculationOn()
    screenUpdateState = True
    statusBarState = True
    calcState = True
    eventsState = True
End Sub

Sub sbCalculationOff()
    screenUpdateState = False
    statusBarState = False
    calcState = False
    eventsState = False
End Sub

Sub TestMain()

    For X = 1 To 65000
        Range("A" & X) = X
    Next

End Sub
