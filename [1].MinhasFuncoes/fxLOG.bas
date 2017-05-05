Attribute VB_Name = "fxLOG"
Function old_LogIT(valor As String, filename)
Dim vNome As String, strCaminho As String
vNome = ActiveWorkbook.Path & "\Log" '& Format(Now(), "yyyy.mm.dd")
strCaminho = Dir(vNome, vbDirectory)

Dim FSO As Scripting.FileSystemObject
Set FSO = New Scripting.FileSystemObject
Dim txs As Scripting.TextStream

If (strCaminho = "") Then MkDir (vNome)

Set txs = FSO.CreateTextFile(vNome & "\" & filename & ".txt")

s = valor

Debug.Print s ' still writing to immediate

txs.WriteLine s ' third way of writing to file
txs.Close
Set txs = Nothing
Set FSO = Nothing

End Function

Sub LogIT(valor As String)
Dim vNome As String, strCaminho As String
vNome = ActiveWorkbook.Path & "\Log" '& Format(Now(), "yyyy.mm.dd")
strCaminho = Dir(vNome, vbDirectory)

'the final string to print in the text file
Dim strData As String
'each line in the original text file
Dim strLine As String
strData = valor & Chr(13)

'open the original text file to read the lines
Open vNome & "\Log.txt" For Input As #1
'continue until the end of the file

While EOF(1) = False
    'read the current line of text
    Line Input #1, strLine
    'add the current line to strData
    strData = strData + strLine & vbCrLf
Wend

'add the new line
strData = strData '+ "Data to be appended"
Close #1

'reopen the file for output
Open vNome & "\Log.txt" For Output As #1
Print #1, strData

Close #1
End Sub
    
    
