Attribute VB_Name = "fxLoopArquivosNaPasta"
Sub LoopThroughFiles(caminho As String)
    Dim StrFile As String
    StrFile = Dir(caminho)
    Do While Len(StrFile) > 0
        Debug.Print StrFile
        StrFile = Dir
    Loop
End Sub
Sub test()
LoopThroughFiles (ThisWorkbook.Path)
End Sub
