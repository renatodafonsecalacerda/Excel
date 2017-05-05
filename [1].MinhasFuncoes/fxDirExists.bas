Attribute VB_Name = "fxDirExists"
Function DirExists(ByVal strDirName As String) As Boolean
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    ' Code from the Deployment Wizard, passed on by Will Rickards.
    On Error Resume Next

    DirExists = (GetAttr(strDirName) And vbDirectory) = vbDirectory

    Err.Clear
End Function
