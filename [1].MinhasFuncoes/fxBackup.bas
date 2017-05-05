Attribute VB_Name = "fxBackup"
Public Function Backup(contador) As Integer
    Dim vNome As String, strCaminho As String
    vNome = ActiveWorkbook.Path & "\Backup" '& Format(Now(), "yyyy.mm.dd")
    strCaminho = Dir(vNome, vbDirectory)
    If (strCaminho = "") Then MkDir (vNome)
    ActiveWorkbook.SaveCopyAs vNome & "\BCK(" & Format(Now(), "yyyy.mm.dd") & ") (versao-" & contador & ")" & ActiveWorkbook.Name
    ActiveWorkbook.Save    'salva o arquivo ativo
    Backup = contador + 1
End Function
