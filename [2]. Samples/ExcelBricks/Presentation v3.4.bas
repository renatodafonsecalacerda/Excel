Attribute VB_Name = "Presentation"
' version 3.4
'
' sGenerateDeck - parses commands in cell 1.strConfigSource and updates 2.strTemplatePath.
'     The updated presentation is put in 3.strOutputPath. 4.strValuesSource (optional)
'     points to a excel grid of name value pairs. commands should be separated by line
'     breaks. Blank lines are ignored
'
'     Syntax
'          This is a comment
'               # this is a comment
'
'          Copy object (chart / group) from Sheet and position / size it per layout (pre-defined)
'               copychart <Sheet>.<Chart/Group name>, <layout name>
'
'          Copy range from Sheet and position / size it per layout (pre-defined). The range is
'          pasted as an image
'               copyrange <range>, <layout name>
'
'          Copy table from Sheet and position it as per the layout (pre-defined). The table
'          is pasted as HTML
'               copytable <range>, <layout name>
'
'          This removes the current slide
'               deleteslide
'
'          Inserts the specified file as per hte layout (pre-defined)
'               insert <path>, <layout name>
'
'          This defines a layout (size and position). Layouts are retained across multiple
'          calls i.e. you can define it once per workbook
'               layout <name>, <height>, <width>, <horizontal>, <vertical>,
'
'          For a table the width attribute is a : delimited set of columns widths
'               layout <name>, <height>, <col1Width>:<col2Width>..., <horizontal>, <vertical>,
'
'          This sets the current slide. All operations except replaceall affect the current
'          slide
'               setslide <slide number>
'
'          Turn on / off shadow for copy (on by default)
'               shadow on
'               shadow off
'
'          This replaces a string in the slide
'               replace <string to find>, <string to replace>
'
'          If the value begins with $ it is picked from the strValuesSource grid
'               replace <string to find>, $name
'
'          This does a replace across all slides
'               replaceall <string to find>, <string to replace>



Dim arrLayout()
Dim boolShadow



' sGenerateDeck wrapper
Sub sGenerateDeckWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments & Chr(10), Chr(10))
    sGenerateDeck arrArguments(0), arrArguments(1), arrArguments(2), arrArguments(3)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' generate deck using template and configuration file
Sub sGenerateDeck(strConfigSource, strTemplatePath, strOutputPath, strValuesSource)
On Error GoTo Error_Handler
    boolShadow = True

    ' build name value array
    intRowOffset = -1
    If strValuesSource <> "" Then
        Set objStartCell = ExcelBricks.fGetRange(strValuesSource)
        
        ' check how many name values there are
        Do While objStartCell.Offset(intRowOffset + 1, 0).Value <> ""
            intRowOffset = intRowOffset + 1
        Loop
        
        ' don't do anything if there were no name-values
        If intRowOffset <> -1 Then
            Dim arrNames()
            Dim arrValues()
            
            ' get the names and values into arrays
            ReDim arrNames(intRowOffset)
            ReDim arrValues(intRowOffset)
            For i = 0 To intRowOffset
                arrNames(i) = objStartCell.Offset(i, 0).Value
                arrValues(i) = objStartCell.Offset(i, 1).Value
            Next
        End If
    End If
    
    ' open presentation
    Set objPowerpoint = CreateObject("Powerpoint.Application")
    If objPowerpoint.Presentations.Count <> 0 Then
        Err.Raise -1, "sGenerateDeck", "Close all open presentations and retry."
    End If
    If Left(strTemplatePath, 2) = ".\" Or Left(strTemplatePath, 3) = "..\" Then
        strTemplatePath = ThisWorkbook.Path & "\" & strTemplatePath
    End If
    Set objTemplate = objPowerpoint.Presentations.Open(strTemplatePath, , , 0)
    Set objSlide = objTemplate.Slides(1)
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    
    ' get configuration
    arrLines = Split(ExcelBricks.fGetRange(strConfigSource).Value, Chr(10))
    
    
    ' initialize array if it has not been done yet
    If (Not arrLayout) = -1 Then
        ReDim arrLayout(1 To 1)
    End If
    
    ' process configuration
    For Each strLine In arrLines
        strLine = Trim(strLine)
        
        ' ignore blank lines
        If strLine <> "" Then
                        
            ' parse out command and parameters
            strCommand = LCase(Split(strLine, " ")(0))
            arrParameters = Split(Trim(Mid(strLine, Len(strCommand) + 1)), ",")
            
            Select Case strCommand
            ' ignore comments
            Case "#"
            
            ' copy chart as picture
            Case "copychart"
                strChartSheet = Trim(Split(arrParameters(0), ".")(0))
                strChartTitle = Trim(Split(arrParameters(0), ".")(1))
                strLayout = LCase(Trim(arrParameters(1)))
                
                ' find the chart
                boolFound = False
                With ThisWorkbook.Worksheets(strChartSheet)
                    .Shapes(strChartTitle).Copy
                    Set objShape = objSlide.Shapes.PasteSpecial(6)
                    ' set object layout and format
                    sLayout objShape, strLayout, False
                End With
                
            ' copy range as picture
            Case "copyrange"
                strLayout = LCase(Trim(arrParameters(1)))
                
                ' convert to image in excel to work around excel bug
                ' from http://www.keyongtech.com/5351722-cannot-copy-excel-2007-chart
                With ExcelBricks.fGetRange(arrParameters(0))
                    .CopyPicture
                    .Worksheet.Paste
                    .Worksheet.Shapes(.Worksheet.Shapes.Count).Copy
                    Set objShape = objSlide.Shapes.PasteSpecial(1)
                    .Worksheet.Shapes(.Worksheet.Shapes.Count).Delete
                End With
                
                ' set object layout and format
                sLayout objShape, strLayout, False
            
            ' copy range as table
            Case "copytable"
                strLayout = LCase(Trim(arrParameters(1)))
                
                ' workaround Office 2007 bug by copying cell by cell
                Set objExcelRange = ExcelBricks.fGetRange(arrParameters(0))
                Set objShape = objSlide.Shapes.AddTable(objExcelRange.Rows.Count, objExcelRange.Columns.Count)
                
                ' set cell data and formats
                With objShape.Table
                    For i = 1 To objExcelRange.Rows.Count
                        
                        For j = 1 To objExcelRange.Columns.Count
                           With .Rows(i).Cells(j)
                                If objExcelRange.Cells(i, j).Text <> "" Then
                                    ' set border (default)
                                    For k = 1 To 4
                                        .Borders(k).ForeColor.RGB = 12632256
                                        .Borders(k).Weight = 0.25
                                        .Borders(k).Visible = True
                                    Next
                                End If
                                
                                ' set background color
                                .Shape.Fill.ForeColor.RGB = objExcelRange.Cells(i, j).Interior.Color
                                
                                With .Shape.TextFrame.TextRange
                                    .Text = objExcelRange.Cells(i, j).Text
                                    
                                    ' set format
                                    .Font.Color = objExcelRange.Cells(i, j).Font.Color
                                    .Font.Bold = objExcelRange.Cells(i, j).Font.Bold
                                    .Font.Italic = objExcelRange.Cells(i, j).Font.Italic
                                    .Font.Name = objExcelRange.Cells(i, j).Font.Name
                                    .Font.Size = objExcelRange.Cells(i, j).Font.Size
                                    .Font.Underline = (objExcelRange.Cells(i, j).Font.Underline = Excel.XlCommandUnderlines.xlCommandUnderlinesOn)
                                    
                                    ' horizontal alignment
                                    If objExcelRange.Cells(i, j).HorizontalAlignment = xlRight Then
                                        .ParagraphFormat.Alignment = 3
                                    ElseIf objExcelRange.Cells(i, j).HorizontalAlignment = xlCenter Then
                                        .ParagraphFormat.Alignment = 2
                                    Else
                                        .ParagraphFormat.Alignment = 1
                                    End If
                                End With
                                
                                ' vertical alignment
                                If objExcelRange.Cells(i, j).VerticalAlignment = xlBottom Then
                                    .Shape.TextFrame.VerticalAnchor = 4
                                ElseIf objExcelRange.Cells(i, j).VerticalAlignment = xlCenter Then
                                    .Shape.TextFrame.VerticalAnchor = 3
                                Else
                                    .Shape.TextFrame.VerticalAnchor = 1
                                End If
                            End With
                        Next

                        ' set row height
                        objShape.Table.Rows(i).Height = objExcelRange.Rows(i).Height
                    Next
                End With
                
                ' set object layout and format
                sLayout objShape, strLayout, True
            
            ' remove current slide
            Case "deleteslide"
                objSlide.Delete
            
            ' insert an object
            Case "insert"
                strLayout = LCase(Trim(arrParameters(1)))
                
                strFilePath = Trim(arrParameters(0))
                If Left(strFilePath, 2) = ".\" Or Left(strFilePath, 3) = "..\" Then
                    strFilePath = ThisWorkbook.Path & "\" & strFilePath
                End If
                Set objShape = objSlide.Shapes.AddOLEObject(Filename:=strFilePath, DisplayAsIcon:=True, IconLabel:=objFSO.GetFileName(strFilePath))
                
                ' set object layout and format
                sLayout objShape, strLayout, False
            
            ' define a layout
            Case "layout"
                ' the last layout is empty we just started
                If Not IsEmpty(arrLayout(UBound(arrLayout))) Then
                    
                    ' if the layout already exists, overwrite it
                    boolExists = False
                    For i = 1 To UBound(arrLayout)
                        If LCase(Trim(Split(arrLayout(i), ",")(0))) = LCase(arrParameters(0)) Then
                            arrLayout(i) = Join(arrParameters, ",")
                            boolExists = True
                            Exit For
                        End If
                    Next
                
                    ' if its a new layout add a new element
                    If Not boolExists Then
                        ReDim Preserve arrLayout(1 To UBound(arrLayout) + 1)
                        arrLayout(UBound(arrLayout)) = Join(arrParameters, ",")
                    End If
                
                Else
                    arrLayout(1) = Join(arrParameters, ",")
                End If

            ' replace with value
            Case "replace"
                strFind = Trim(arrParameters(0))
                strReplace = Trim(arrParameters(1))
                
                ' named values begin with $
                If Left(Trim(arrParameters(1)), 1) = "$" Then
                    strReplace = fGetValue(Mid(strReplace, 2, Len(strReplace)), intRowOffset, arrNames, arrValues)
                End If
                
                ' replace text in all placeholders in slide
                sReplaceinSlide objSlide, strFind, strReplace
            
            ' replace with value across all slides
            Case "replaceall"
                strFind = Trim(arrParameters(0))
                
                ' named values have only one parmeter
                If UBound(arrParameters) = 0 Then
                    strReplace = fGetValue(strFind, intRowOffset, arrNames, arrValues)
                Else
                    strReplace = Trim(arrParameters(1))
                End If
            
                ' replace in all slides
                For i = 1 To objTemplate.Slides.Count
                    sReplaceinSlide objTemplate.Slides(i), strFind, strReplace
                Next
            
            ' set current slide
            Case "setslide"
                Set objSlide = objTemplate.Slides(CInt(arrParameters(0)))
            
            ' turns on / off shadow for paste
            Case "shadow"
                If LCase(Trim(arrParameters(0))) = "on" Then
                    boolShadow = True
                Else
                    boolShadow = False
                End If
            
            Case Else
                Err.Raise -1, "sGenerateDeck", "Unrecognized command [" & strLine & "]"
            End Select
        
        End If
        
    Next


    ' save presentation
    If Left(strOutputPath, 2) = ".\" Or Left(strOutputPath, 3) = "..\" Then
        strOutputPath = ThisWorkbook.Path & "\" & strOutputPath
    End If
    objTemplate.SaveCopyAs strOutputPath


Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' cleanup
    On Error Resume Next
    Set objFSO = Nothing
    Set objStartCell = Nothing
    Set objExcelRange = Nothing
    Set objShape = Nothing
    Set objSlide = Nothing
    Set objTemplate = Nothing
    If Not IsEmpty(objPowerpoint) Then
        ' if the error was because of an already open presentation don't quit powerpoint
        If strErrDescription <> "Close all open presentations and retry." Then
            objPowerpoint.Quit
        End If
    End If
    Set objPowerpoint = Nothing
    On Error GoTo 0

    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' default formatting for object
Sub sFormat(objShape)
    If boolShadown Then
        With objShape.Shadow
            .Visible = True
            .Size = 100
            .Blur = 23
            .OffsetX = 7.77
            .OffsetY = 7.77
            .Transparency = 0.35
        End With
    End If
    
    objShape.ZOrder 1
End Sub


' set layout for object
Sub sLayout(objShape, strFormat, boolIsTable)
    
    ' get layout definition
    boolExists = False
    For Each i In arrLayout
        If LCase(Split(i, ",")(0)) = strFormat Then
            strAttributes = Split(i, ",")
            intHeight = CDbl(Trim(strAttributes(1)))
            If boolIsTable Then
                arrWidths = Split(Trim(strAttributes(2)), ":")
                ' set column widths
                For j = 1 To objShape.Table.Columns.Count
                    objShape.Table.Columns(j).Width = CDbl(arrWidths(j - 1)) * 72
                Next
            Else
                intWidth = CDbl(Trim(strAttributes(2)))
            End If
            intLeft = CDbl(Trim(strAttributes(3)))
            intTop = CDbl(Trim(strAttributes(4)))
            boolExists = True
            Exit For
        End If
    Next
    
    ' raise error if layout does not exist
    If Not boolExists Then
        Err.Raise -1, "sLayout", "Undefined layout [" & strFormat & "]"
    End If
   
    ' set size
    If Not boolIsTable Then
        objShape.LockAspectRatio = False
        objShape.Height = intHeight * 72
        objShape.Width = intWidth * 72
    
        ' set default format
        sFormat objShape
    End If
    
    ' position object
    objShape.Top = intTop * 72
    objShape.Left = intLeft * 72
    
    ' bring to front
    objShape.ZOrder MsoZOrderCmd.msoBringToFront
End Sub


' replace all instances of strFind by strReplace
Sub sReplaceinSlide(objSlide, strFind, strReplace)
    For Each objShape In objSlide.Shapes
        If objShape.Type = 14 Or objShape.Type = 17 Then
            objShape.TextFrame.TextRange.Replace strFind, strReplace
        End If
    Next
End Sub


' get value based on name from array
Function fGetValue(strFind, intRowOffset, arrNames, arrValues)
    For i = 0 To intRowOffset
        If arrNames(i) = strFind Then
            fGetValue = arrValues(i)
            Exit Function
        End If
    Next
    
    Err.Raise -1, "fGetValue", "Could not find named value [" & strFind & "]"
End Function
