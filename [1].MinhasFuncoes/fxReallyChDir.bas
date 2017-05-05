Attribute VB_Name = "fxReallyChDir"
Function ReallyChDir(IntoDir As String) As Boolean
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    ' Code by Chris Rae, 25/02/2001
    On Error GoTo Fail
    ChDrive Left(IntoDir, 2)
    ChDir IntoDir
    ReallyChDir = True
    Exit Function
Fail:
    ' Well, it broke.
    ReallyChDir = False
End Function
