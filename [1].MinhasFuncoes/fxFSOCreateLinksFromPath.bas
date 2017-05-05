Attribute VB_Name = "fxFSOCreateLinksFromPath"
'Force the explicit declaration of variables

Option Explicit

'Enable in Tools >> References >> Microsoft Scripting Runtime

Sub ListFiles()

    'Set a reference to Microsoft Scripting Runtime by using
    'Tools > References in the Visual Basic Editor (Alt+F11)
    
    'Declare the variables
    Dim objFSO As FileSystemObject
    Dim objFolder As Folder
    Dim objFile As file
    Dim strPath As String
    Dim strFile As String
    Dim NextRow As Long
    
    'Specify the path to the folder
    strPath = "C:\Documents and Settings\renato.lacerda\Desktop\A\B"
    
    'Create an instance of the FileSystemObject
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    
    'Get the folder
    Set objFolder = objFSO.GetFolder(strPath)
    
    'If the folder does not contain files, exit the sub
    If objFolder.Files.Count = 0 Then
        MsgBox "No files were found...", vbExclamation
        Exit Sub
    End If
    
    'Turn off screen updating
    Application.ScreenUpdating = False
    
    'Insert the headers for Columns A, B, and C
    Cells(1, "A").Value = "FileName"
    Cells(1, "B").Value = "Size"
    'Cells(1, "C").Value = "Date/Time"
    
    'Find the next available row
    NextRow = Cells(Rows.Count, "A").End(xlUp).Row + 1
    
    'Loop through each file in the folder
    For Each objFile In objFolder.Files
    
        'List the name, size, and date/time of the current file
        Cells(NextRow, 1).Select
        Cells(NextRow, 1).Value = objFile.Name
        Call linkIt(objFile, objFile.Name)
        Cells(NextRow, 2).Value = objFile.Size
        Cells(NextRow, 3).Value = objFile.DateLastModified
        
        'Determine the next row
        NextRow = NextRow + 1
    
    Next objFile
    
    'Change the width of the columns to achieve the best fit
    Columns.AutoFit
    
    'Turn screen updating back on
    Application.ScreenUpdating = True
        
End Sub
Sub linkIt(ByVal file As String, text As String)
    ActiveSheet.Hyperlinks.Add Anchor:=Selection, Address:=file, TextToDisplay:=text
End Sub
