Attribute VB_Name = "fxAreaDeTransferencia"
Dim dArea As MSForms.DataObject

Public Function getAreaTransferencia() As String
'Search your PC for the FM20.DLL file. On my PC it is under C:\WINDOWS\system32
Set dArea = New MSForms.DataObject
    dArea.GetFromClipboard
    getAreaTransferencia = dArea.GetText

End Function

Public Function setAreaTransferencia(valor As String)
Set dArea = New MSForms.DataObject

dArea.SetText valor
dArea.PutInClipboard

End Function
Sub Exemplo()
'Private Sub Worksheet_Activate()

'C:\WINDOWS\system32\FM20.DLL
'Dim valor As String

'valor = getClipboard

'ThisWorkbook.Save

'setClipboard (valor)

End Sub
End Sub


