Attribute VB_Name = "fxGetTempPath"
' Written by Mark D'Elton, Australia(markd@net2000.com.au).

Option Explicit

Private Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" _
                (ByVal nBufferLength As Long, _
                ByVal lpBuffer As String) As Long
Public Function GetTempDir() As String
    Dim sBuffer As String
    Dim lRetVal As Long

    sBuffer = String(255, vbNullChar)

    lRetVal = GetTempPath(Len(sBuffer), sBuffer)

    If lRetVal Then
        GetTempDir = Left$(sBuffer, lRetVal)
    End If
End Function

