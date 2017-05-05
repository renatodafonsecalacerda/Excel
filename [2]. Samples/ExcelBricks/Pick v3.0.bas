Attribute VB_Name = "Pick"
' version 3.0
'
' fPickFile - shows a Choose file dialog with title 1.strTitle and file name 
'      filter 2.strFilter
'
' fPickFolder - shows a Choose folder dialog with title 1.strTitle


' wrapper function for fPickFile
Function fPickFileWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    fPickFileWrapper = fPickFile(arrArguments(0), arrArguments(1))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Function


' wrapper function for fPickFolder
Function fPickFolderWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    fPickFolderWrapper = fPickFolder(arrArguments(0))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Function



' pick a file
Function fPickFile(strTitle, strFilter)
    With Excel.Application.FileDialog(msoFileDialogFilePicker)
        ' set file dialog properties
        .Title = strTitle
        .Filters.Clear
        .Filters.Add strFilter, strFilter
        
        ' we want the display to be refreshed
        Application.ScreenUpdating = True
        .Show
        Application.ScreenUpdating = False
        
        ' if no file is picked cancel the run
        If .SelectedItems.Count = 0 Then
            Err.Raise ExcelBricks.lngShowMessage, , "No file selected. Cancelling run."
        End If
        fPickFile = .SelectedItems(1)
    End With
End Function


' pick a folder
Function fPickFolder(strTitle)
    With Excel.Application.FileDialog(msoFileDialogFolderPicker)
        ' set file dialog properties
        .Title = strTitle
        
        ' we want the display to be refreshed
        Application.ScreenUpdating = True
        .Show
        Application.ScreenUpdating = False
        
        ' if no file is picked cancel the run
        If .SelectedItems.Count = 0 Then
            Err.Raise ExcelBricks.lngShowMessage, , "No folder selected. Cancelling run."
        End If
        fPickFolder = .SelectedItems(1)
    End With
End Function


