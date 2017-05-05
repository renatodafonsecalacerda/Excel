Attribute VB_Name = "fxLoopRecursiveArquivosNaPasta"
Private m_asFilters() As String
Private m_asFiles As Variant
Private m_lNext As Long
Private m_lMax As Long

Sub AddPdfCreator()
On Error Resume Next
Dim Arquivo(0 To 2) As String
Arquivo(0) = "C:\Arquivos de programas\PDFCreator\"
Arquivo(1) = "C:\Program Files\PDFCreator"
Arquivo(2) = "C:\Arquivos de programas x86\PDFCreator"

For x = 0 To 2
    nomes = GetFileList(Arquivo(x))
    For Each e In nomes
        If e = Arquivo(x) & "PDFCreator.exe" Then
            subAddRef (e)
        End If
    Next
Next
End Sub

Public Function GetFileList(ByVal ParentDir As String, Optional ByVal sSearch As String, Optional ByVal Deep As Boolean = True) As Variant
    m_lNext = 0
    m_lMax = 0

    ReDim m_asFiles(0)
    If Len(sSearch) Then
        m_asFilters() = Split(sSearch, "|")
    Else
        ReDim m_asFilters(0)
    End If

    If Deep Then
        Call RecursiveAddFiles(ParentDir)
    Else
        Call AddFiles(ParentDir)
    End If

    If m_lNext Then
        ReDim Preserve m_asFiles(m_lNext - 1)
        GetFileList = m_asFiles
    End If

End Function

Private Sub RecursiveAddFiles(ByVal ParentDir As String)
    Dim asDirs() As String
    Dim l As Long
    On Error GoTo ErrRecursiveAddFiles
    'Add the files in 'this' directory!


    Call AddFiles(ParentDir)

    ReDim asDirs(-1 To -1)
    asDirs = GetDirList(ParentDir)
    For l = 0 To UBound(asDirs)
        Call RecursiveAddFiles(asDirs(l))
    Next l
    On Error GoTo 0
Exit Sub
ErrRecursiveAddFiles:
End Sub
Private Function GetDirList(ByVal ParentDir As String) As String()
    Dim sDir As String
    Dim asRet() As String
    Dim l As Long
    Dim lMax As Long

    If Right(ParentDir, 1) <> "\" Then
        ParentDir = ParentDir & "\"
    End If
    sDir = Dir(ParentDir, vbDirectory Or vbHidden Or vbSystem)
    Do While Len(sDir)
        If GetAttr(ParentDir & sDir) And vbDirectory Then
            If Not (sDir = "." Or sDir = "..") Then
                If l >= lMax Then
                    lMax = lMax + 10
                    ReDim Preserve asRet(lMax)
                End If
                asRet(l) = ParentDir & sDir
                l = l + 1
            End If
        End If
        sDir = Dir
    Loop
    If l Then
        ReDim Preserve asRet(l - 1)
        GetDirList = asRet()
    End If
End Function
Private Sub AddFiles(ByVal ParentDir As String)
    Dim sFile As String
    Dim l As Long

    If Right(ParentDir, 1) <> "\" Then
        ParentDir = ParentDir & "\"
    End If

    For l = 0 To UBound(m_asFilters)
        sFile = Dir(ParentDir & "\" & m_asFilters(l), vbArchive Or vbHidden Or vbNormal Or vbReadOnly Or vbSystem)
        Do While Len(sFile)
            If Not (sFile = "." Or sFile = "..") Then
                If m_lNext >= m_lMax Then
                    m_lMax = m_lMax + 100
                    ReDim Preserve m_asFiles(m_lMax)
                End If
                m_asFiles(m_lNext) = ParentDir & sFile
                m_lNext = m_lNext + 1
            End If
            sFile = Dir
        Loop
    Next l
End Sub

Sub References_RemoveMissing()
     'Macro purpose:  To remove missing references from the VBE
     
    Dim theRef As Variant, i As Long
     
    On Error Resume Next
     
    For i = ThisWorkbook.VBProject.References.Count To 1 Step -1
        Set theRef = ThisWorkbook.VBProject.References.Item(i)
        If theRef.isbroken = True Then
            ThisWorkbook.VBProject.References.Remove theRef
        End If
    Next i
     
    If Err <> 0 Then
        MsgBox "A missing reference has been encountered!" _
        & "You will need to remove the reference manually.", _
        vbCritical, "Unable To Remove Missing Reference"
    End If
     
    On Error GoTo 0
End Sub

