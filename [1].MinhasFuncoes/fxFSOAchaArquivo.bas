Attribute VB_Name = "fxFSOAchaArquivo"
Dim msg As Integer

Sub Test_FxAcharArquivoFSO()
Dim colFiles As New Collection
Dim strArquivo As String
Dim strMyPath As String

strArquivo = "PDFCreator.exe"
strMyPath = "C:\Arquivos de programas\"

    RecursiveDir colFiles, strMyPath, strArquivo, True

    Dim vFile As Variant
    For Each vFile In colFiles
        Debug.Print vFile
    Next vFile
End Sub
Sub Test_FxAcharArquivoFSO2()
For l = 1 To 2
If l = 1 Then Call GetFilePath("D:\Renato\MyDropBox\Dropbox\Projetos\Excel\[1].MinhasFuncoes", "fxDiaDaSemana.bas")
If l = 2 Then Call GetFilePath("D:\Renato\MyDropBox\Dropbox\Projetos\Excel\[1].MinhasFuncoes", "fxGetColuna.bas")
Next
End Sub
Function GetFilePath(MyPath As String, MyFile As String) As String
Dim colFiles As New Collection
Dim strArquivo As String
Dim strMyPath As String

If msg = 0 Then MsgBox "Esse pesquisa pode levar bastante tempo.", vbCritical: msg = 1

strArquivo = MyFile
strMyPath = MyPath


    RecursiveDir colFiles, strMyPath, strArquivo, True

    Dim vFile As Variant
    For Each vFile In colFiles
        Debug.Print vFile
    Next vFile
End Function
Public Function RecursiveDir(colFiles As Collection, _
                             strFolder As String, _
                             strFileSpec As String, _
                             bIncludeSubfolders As Boolean)

    Dim strTemp As String
    Dim colFolders As New Collection
    Dim vFolderName As Variant

    'Add files in strFolder matching strFileSpec to colFiles
    strFolder = TrailingSlash(strFolder)
    strTemp = Dir(strFolder & strFileSpec)
    Do While strTemp <> vbNullString
        colFiles.Add strFolder & strTemp
        strTemp = Dir
    Loop

    If bIncludeSubfolders Then
        'Fill colFolders with list of subdirectories of strFolder
        strTemp = Dir(strFolder, vbDirectory)
        Do While strTemp <> vbNullString
            If (strTemp <> ".") And (strTemp <> "..") Then
                If (GetAttr(strFolder & strTemp) And vbDirectory) <> 0 Then
                    colFolders.Add strTemp
                End If
            End If
            strTemp = Dir
        Loop

        'Call RecursiveDir for each subfolder in colFolders
        For Each vFolderName In colFolders
            Call RecursiveDir(colFiles, strFolder & vFolderName, strFileSpec, True)
        Next vFolderName
    End If

End Function


Public Function TrailingSlash(strFolder As String) As String
    If Len(strFolder) > 0 Then
        If Right(strFolder, 1) = "\" Then
            TrailingSlash = strFolder
        Else
            TrailingSlash = strFolder & "\"
        End If
    End If
End Function

