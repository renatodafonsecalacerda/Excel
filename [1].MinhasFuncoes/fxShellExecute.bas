Attribute VB_Name = "fxShellExecute"
' By Chris Rae, 10/6/99.
Option Explicit
Declare Function ShellExecute Lib "shell32.dll" Alias _
                 "ShellExecuteA" (ByVal Hwnd As Long, ByVal _
                lpOperation As String, ByVal lpFile As _
                String, ByVal lpParameters As String, _
                ByVal lpDirectory As String, ByVal _
                nShowCmd As Long) As Long
Declare Function GetForegroundWindow Lib "user32" () As Long
Sub ShellEx(FileName As String)
    ShellExecute GetForegroundWindow, "Open", FileName, "", "", 1
End Sub
Sub TestShellExecute()
    ' Load the application associated with this particular
    ' file (if the file is an application, load it). If
    ' anything goes wrong during this procedure then a
    ' runtime error is generated. CLR, 10/6/99.

    ' On a slightly different note, I'm afraid I've no idea
    ' why the foreground window handle has to be passed to the
    ' procedure but I *do* know that if you don't pass it
    ' it don't work. YMMV.
    
    ShellExecute GetForegroundWindow, "Open", _
                 "c:\bootlog.txt", _
                    "", "", 1
End Sub

