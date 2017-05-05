Attribute VB_Name = "fxFixUpRefs"
Sub FixUpRefs()
   Dim r As Reference, r1 As Reference
   Dim s As String
   
   ' Procura a 1ª referência no BD diferente de
   ' Access e Visual Basic for Applications.
   For Each r In Application.References
      If r.Name <> "Access" And r.Name <> "VBA" Then
         Set r1 = r
         Exit For
      End If
   Next
   s = r1.FullPath
   
   ' Remove a Referência e a adiciona novamente.
   References.Remove r1
   References.AddFromFile s
   
   ' Chama um SysCmd oculto para Compilar e Salvar todos os módulos.
   Call SysCmd(504, 16483)
End Sub

Sub RemoveMissingReferences()
 'Remove any missing references
    For i = ThisWorkbook.VBProject.References.Count To 1 Step -1
        Set theRef = ThisWorkbook.VBProject.References.Item(i)
        If theRef.isbroken = True Then
            ThisWorkbook.VBProject.References.Remove theRef
        End If
    Next i
End Sub
Sub subAddRef(s As String)
On Error Resume Next
Application.VBE.ActiveVBProject.References.AddFromFile s
End Sub
