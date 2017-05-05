Attribute VB_Name = "fxProtegePlanilhaComSenha"
Option Explicit
Dim BoolProtect As Boolean
Const senha As String = "teste"

Sub Desprotege_Planilha()
Dim ws As Worksheet
Set ws = ActiveSheet
BoolProtect = False
'Checa se a planilha esta protegida.
If ws.ProtectContents = True Then
BoolProtect = True
'desprotege a planilha
ws.Unprotect _
Password:=senha
End If
End Sub

Sub Protege_Planilha()
Dim ws As Worksheet
Set ws = ActiveSheet
' Checa se planilha esta protegida
If BoolProtect = False Then
ws.Protect _
Password:=senha
BoolProtect = False
Else
ws.Protect _
Password:=senha
BoolProtect = True
End If
End Sub

Sub Desprotege_roda_macro_protege()
Call Desprotege_Planilha
Call Minha_Macro
Call Protege_Planilha
End Sub

Sub Minha_Macro()
Dim i As Integer
Range("D3") = "Macro desprotegeu a planilha para rodar rotina....."
Range("D4") = "Macro inserindo númeração de 1 a 10000....."

For i = 1 To 10000
Sheets("Plan1").Cells(1 + i, 1) = i
Next

Range("D3") = ""
Range("D4") = "Dados inseridos e planilha protegida novamente....."
End Sub

Sub Teste()
Dim senha
senha = "teste"
ActiveSheet.Unprotect senha
Range("A2:A5000").ClearContents
Range("D4") = ""
End Sub

