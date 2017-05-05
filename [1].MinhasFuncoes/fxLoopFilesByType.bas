Attribute VB_Name = "fxLoopFilesByType"
Option Explicit
Option Compare Text
 
Sub OneType()
    Const MyPath = "C:\Atest" ' Set the path.
    Const FileType = "*.*" ' or "*.doc"
    ProcessFiles MyPath, FileType
End Sub
 
Sub OneName()
    Const MyPath = "C:\Atest" ' Set the path.
    Const FileName = "MyTest" & "*.*"
    ProcessFiles MyPath, FileName
End Sub
 
 
Sub MoreTypes()
    Dim FileType, FT, MyFT As String
    Const MyPath = "C:\Atest" ' Set the path.
    FileType = Array("doc", "dot", "xls")
    For Each FT In FileType
        MyFT = "*." & FT
        ProcessFiles MyPath, MyFT
    Next
End Sub
 
 
Sub ProcessFiles(strFolder As String, strFilePattern As String)
    Dim strFileName As String
    Dim strFolders() As String
    Dim iFolderCount As Integer
    Dim i As Integer
     
     'Collect child folders
    strFileName = Dir$(strFolder & "\", vbDirectory)
    Do Until strFileName = ""
        If (GetAttr(strFolder & "\" & strFileName) And vbDirectory) = vbDirectory Then
            If Left$(strFileName, 1) <> "." Then
                ReDim Preserve strFolders(iFolderCount)
                strFolders(iFolderCount) = strFolder & "\" & strFileName
                iFolderCount = iFolderCount + 1
            End If
        End If
        strFileName = Dir$()
    Loop
     
     'process files in current folder
    strFileName = Dir$(strFolder & "\" & strFilePattern)
    Do Until strFileName = ""
         'Do things with files here*****************
        Debug.Print strFolder & "\" & strFileName
         
         '*******************************************
        strFileName = Dir$()
    Loop
     
     'Look through child folders
    For i = 0 To iFolderCount - 1
        ProcessFiles strFolders(i), strFilePattern
    Next i
End Sub
