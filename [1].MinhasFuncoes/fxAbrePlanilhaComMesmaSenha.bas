Attribute VB_Name = "fxAbrePlanilhaComMesmaSenha"
'Origem: http://guiadoexcel.com.br/abrir-varios-arquivos-com-mesma-senha-excel
Sub lsAbrirArquivos(ByVal Caminho As String, ByVal lSenha As String)
    Dim FSO As Object, Pasta As Object, Arquivo As Object, Arquivos As Object
    Dim Linha As Long
    Dim lSeq As Long
    Dim lNovoNome As String
 
    Set FSO = CreateObject("Scripting.FileSystemObject")
 
    If Not FSO.FolderExists(Caminho) Then
        MsgBox "A pasta '" & Caminho & "' não existe.", vbCritical, "Erro"
        Exit Sub
    End If
 
    lSeq = 1
 
    Set Pasta = FSO.GetFolder(Caminho)
    Set Arquivos = Pasta.Files
 
    For Each Arquivo In Arquivos
        Workbooks.Open Filename:=UCase$(Arquivo.Path), Password:=lSenha, WriteResPassword:=lSenha
    Next
End Sub
 
'Seleciona os arquivos
Public Sub lsSelecionaArquivo()
    Dim Caminho As String
    Dim lSenha As String
 
    Caminho = InputBox("Informe o local dos arquivos", "Pasta", "c:\")
    lSenha = InputBox("Informe a senha dos arquivos:", "Senha", "")
 
    'Chama a função para renomear os arquivos
    lsAbrirArquivos Caminho, lSenha
End Sub
