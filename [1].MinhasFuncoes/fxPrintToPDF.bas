Attribute VB_Name = "fxPrintToPDF"
Sub PrintToPDF_Early(NomeDoArquivo As String)
'Author       : Ken Puls (www.excelguru.ca)
'Macro Purpose: Print to PDF file using PDFCreator
'   (Download from http://sourceforge.net/projects/pdfcreator/)
'   Designed for early bind, set reference to PDFCreator

    Dim pdfjob As PDFCreator.clsPDFCreator
    Dim sPDFName As String
    Dim sPDFPath As String
    Dim bRestart As Boolean
    MINHA_IMPRESSORA = Application.ActivePrinter

    '/// Change the output file name here! ///
	NomeDoArquivo = replace(NomeDoArquivo,":", " ")
    sPDFName = NomeDoArquivo
    sPDFPath = ActiveWorkbook.Path & Application.PathSeparator

    'Check if worksheet is empty and exit if so
    If IsEmpty(ActiveSheet.UsedRange) Then Exit Sub

    'Activate error handling and turn off screen updates
    On Error GoTo EarlyExit
    Application.ScreenUpdating = False
    Set pdfjob = New PDFCreator.clsPDFCreator

    'Check if PDFCreator is already running and attempt to kill the process if so
    'Do
    '    bRestart = False
    '    Set pdfjob = New PDFCreator.clsPDFCreator
    '    If pdfjob.cStart("/NoProcessingAtStartup") = False Then
    '        'PDF Creator is already running.  Kill the existing process
    '        Shell "taskkill /f /im PDFCreator.exe", vbHide
    '        DoEvents
    '        Set pdfjob = Nothing
    '        bRestart = True
    '    End If
    'Loop Until bRestart = False
    'Check if PDFCreator is already (or still) running and attempt to kill the process if so
Do
bRestart = False
Set pdfjob = New PDFCreator.clsPDFCreator
If pdfjob.cStart("/NoProcessingAtStartup", True) = False Then
'PDF Creator is already running. Kill the existing process
Shell "taskkill /f /im PDFCreator.exe", vbHide
DoEvents
Set pdfjob = Nothing
bRestart = True
End If
Loop Until bRestart = False

    'Assign settings for PDF job
    With pdfjob
        .cOption("UseAutosave") = 1
        .cOption("UseAutosaveDirectory") = 1
        .cOption("AutosaveDirectory") = sPDFPath
        .cOption("AutosaveFilename") = sPDFName
        .cOption("AutosaveFormat") = 0    ' 0 = PDF
        .cClearCache
    End With

    'Delete the PDF if it already exists
    If Dir(sPDFPath & sPDFName) = sPDFName Then Kill (sPDFPath & sPDFName)

    'Print the document to PDF
    ActiveSheet.PrintOut copies:=1, ActivePrinter:="PDFCreator"

    'Wait until the print job has entered the print queue
    Do Until pdfjob.cCountOfPrintjobs = 1
        DoEvents
    Loop
    pdfjob.cPrinterStop = False

    'Wait until the file shows up before closing PDF Creator
    Do
        DoEvents
    Loop Until Dir(sPDFPath & sPDFName) = sPDFName
Application.ActivePrinter = MINHA_IMPRESSORA
Cleanup:
    'Release objects and terminate PDFCreator
    Set pdfjob = Nothing
    Shell "taskkill /f /im PDFCreator.exe", vbHide
    On Error GoTo 0
    Application.ScreenUpdating = True
    Exit Sub

EarlyExit:
    'Inform user of error, and go to cleanup section
    MsgBox "There was an error encountered.  PDFCreator has" & vbCrLf & _
           "has been terminated.  Please try again.", _
           vbCritical + vbOKOnly, "Error"
    Resume Cleanup
    

End Sub


