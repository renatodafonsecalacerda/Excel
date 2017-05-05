VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} fxAutoCompletarForm 
   Caption         =   "AutoCompletar"
   ClientHeight    =   480
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4710
   OleObjectBlob   =   "fxAutoCompletarForm.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "fxAutoCompletarForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Digite aqui o intervalo a ser autocompletado
Private Const r As String = "A1:A100"
Private sInput As String
 
'Faz parar a pesquisa dos dados digitados
Dim flParar As Boolean
 
'Ao digitar deletar ou backspace o sistema limpa a variável de controle para pesquisar novamente
Private Sub txtInput_KeyDown(ByVal KeyCode As MSForms.ReturnInteger, ByVal Shift As Integer)
 
    'Limpa a variável de controle
    If (KeyCode = vbKeyBack) Or (KeyCode = vbKeyDelete) Then
        flParar = True
    Else
        flParar = False
    End If
 
    If (KeyCode = 13) Then
        ActiveCell.Value = fxAutoCompletarForm.txtInput.Text
        fxAutoCompletarForm.txtInput.Value = vbNullString
        fxAutoCompletarForm.Hide
    End If
 
End Sub
 
'Faz a busca das palavras
Private Sub txtInput_Change()
    Dim lPalavra As String
 
    If flParar Then
        flParar = False
    Else
        sInput = Left(Me.txtInput, Me.txtInput.SelStart)
        lPalavra = GetFirstCloserWord(sInput)
        If lPalavra & "" <> "" Then
            flParar = True
            Me.txtInput.Text = lPalavra
            Me.txtInput.SelStart = Len(sInput)
            Me.txtInput.SelLength = 999999
        End If
    End If
 
End Sub
 
'Seleciona a primeira letra
Private Function GetFirstCloserWord(ByVal Word As String) As String
    Dim c As Range
 
    For Each c In ActiveSheet.Range(r).Cells
    If LCase(c.Value) Like LCase(Word & "*") Then
            GetFirstCloserWord = c.Value
            Exit Function
        End If
    Next c
    Set c = Nothing
 
End Function

