Attribute VB_Name = "fxQuitWhenPrinted"
' Routine stuck together by Chris Rae but entirely based
' upon code and ideas from Jonathan West and Astrid. 20/7/99.
Option Explicit
Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Sub QuitWhenPrinted()
    Do While Application.BackgroundPrintingStatus > 0
        Sleep 1000
    Loop
    Application.Quit
End Sub
