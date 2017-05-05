Attribute VB_Name = "TagCloud"
' version 3.0
'
' sInitializeTagCloud - initializes tag cloud in 1.strSheetName.strFrameName (Microsoft Forms
'   2.0 Frame using 2.strRange. This involves positioning the tags so that they don't overlap
'   (by getting the maximum size for each tag and checking for overlaps)
'
' sSetTagCloud - sets tag sizes in 1.strSheetName.strFrameName cloud using 2.strRange. The last
'   column is used as input, the first column as labels and the other columns are used in
'   highlighting (a tag is highlighted if it is > dblSpikeFactor * average + dblSpikeOffset)
'
' sClearTagCloud - clears all tags in 1.strSheetName.strFrameName
'
' sSetConfiguration - sets (global) configuration parameters using 1.strConfiguration, a
'   semicolon delimited list of assignments for
'       intMinFontSize (7) - the font size for the minimum frequency
'       intMaxFontSize (24) - the font size for the maximum frequency
'       dblSpikeFactor (1.1) - used to calculate the cut-off for tag highlighting
'       dblSpikeOffset (5) - used to calculate the cut-off for tag highlighting
'       intNormalTagColor (16744448) - the color for normal tags
'       intSpikeTagColor (33023) - the color for tags with a spike
'   not setting a value will change it to it's default value (given in parentheses)
'
' Requires ExcelHelper.bas



' global variables
Dim objFrame

Dim intMinFontSize
Dim intMaxFontSize

Dim intNormalTagColor
Dim intSpikeTagColor
Dim dblSpikeFactor
Dim dblSpikeOffset

Dim dblFontScaling
Dim strSavedConfiguration



' sGenerateTagCloud wrapper
Sub sInitializeTagCloudWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sInitializeTagCloud arrArguments(0), arrArguments(1)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub

' sClearTagCloud wrapper
Sub sClearTagCloudWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sClearTagCloud arrArguments(0)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub

' sSetTagCloud wrapper
Sub sSetTagCloudWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sSetTagCloud arrArguments(0), arrArguments(1)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub

' sSetConfiguration wrapper
Sub sSetConfigurationWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sSetConfiguration arrArguments(0)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' generates a tagcloud
Sub sInitializeTagCloud(strSheetNameObject, strRange)
On Error GoTo Error_Handler
    
    ' get configuration and clear controls
    sSetConfiguration (strSavedConfiguration)
    sClearTagCloud (strSheetNameObject)
    
    ' initialize objects and ranges
    strSheetName = Split(strSheetNameObject, ".")(0)
    strObjectName = Split(strSheetNameObject, ".")(1)
    Set objFrame = ThisWorkbook.Worksheets(strSheetName).OLEObjects(strObjectName)
    With ExcelBricks.fGetRange(strRange)
        strRangeWorksheet = .Worksheet.Name
        Set objLabelRange = ExcelBricks.fGetRange("'" & strRangeWorksheet & "'!" & .Cells(1, 1).AddressLocal & ":" & .Cells(.Rows.Count, 1).AddressLocal)
        Set objFrequencyRange = ExcelBricks.fGetRange("'" & strRangeWorksheet & "'!" & .Cells(1, 2).AddressLocal & ":" & .Cells(.Rows.Count, .Columns.Count).AddressLocal)
    End With
    
    ' get the maximum frequency
    intMaxFrequency = Application.WorksheetFunction.Max(objFrequencyRange)
    
    ' if the maximum value is 0, we don't need to do anything
    If intMaxFrequency <> 0 Then
    
        ' set font scaling
        intMinFrequency = Application.WorksheetFunction.Min(objstrFrequencyRange)
        dblFontScaling = intMaxFontSize - intMinFontSize
        If intMaxFrequency <> intMinFrequency Then
            dblFontScaling = dblFontScaling / (intMaxFrequency - intMinFrequency)
        End If
    
    
        ' initialize positioning
        intXOffset = Round(objFrame.Width / 2)
        intYOffset = Round(objFrame.Height / 2)
        If objFrame.Height >= objFrame.Width Then
            intXRadiusIncrement = 1
            intYRadiusIncrement = Round(objFrame.Height / objFrame.Width)
        Else
            intYRadiusIncrement = 1
            intXRadiusIncrement = Round(objFrame.Width / objFrame.Height)
        End If
        dblAngleIncrement = Application.WorksheetFunction.Pi / 15
        dblAngle = 0
        
        
        For Each objCell In objLabelRange
            ' add a control for each tag and get the maximum value
            strValue = objCell.Text
            objFrame.Object.Controls.Add "Forms.Label.1", "lbl" & strValue, True
            intCount = Application.WorksheetFunction.Max(objFrequencyRange.Rows(objCell.Row - objFrequencyRange.Row + 1))
            
            ' set caption and mark point
            With objFrame.Object.Controls("lbl" & strValue)
                .Caption = strValue & " (" & intCount & ") "
                .BackStyle = fmBackStyle.fmBackStyleTransparent
                .TextAlign = fmTextAlign.fmTextAlignCenter
                .AutoSize = True
                .Font.Bold = True
                .WordWrap = False
                
                ' set the font size based on the maximum frequency
                .Font.Size = intMinFontSize + Round(dblFontScaling * intCount)
            
                ' move the label
                intXRadius = 0
                intYRadius = 0
                intTempYOffset = intYOffset - .Height / 2
                intTempXOffset = intXOffset - .Width / 2
                .Top = intTempYOffset + intYRadius * Cos(dblAngle)
                .Left = intTempXOffset + intXRadius * Sin(dblAngle)
                
                ' if it overlaps with an existing label move it
                Do While fIsOverLap("lbl" & strValue)
                    ' increase the radius
                    dblAngle = dblAngle + dblAngleIncrement
                    intXRadius = intXRadius + intXRadiusIncrement
                    intYRadius = intYRadius + intYRadiusIncrement
                
                    ' move the label
                    .Top = intTempYOffset + intYRadius * Cos(dblAngle)
                    .Left = intTempXOffset + intXRadius * Sin(dblAngle)
                Loop
            End With
        Next
    End If
    
Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    On Error Resume Next
    ' cleanup
    Set objFrame = Nothing
    Set objLabelRange = Nothing
    Set objFrequencyRange = Nothing
    On Error GoTo 0

    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' sets tag sizes
Public Sub sSetTagCloud(strSheetNameObject, strRange)
On Error GoTo Error_Handler

    ' initialize
    strSheetName = Split(strSheetNameObject, ".")(0)
    strObjectName = Split(strSheetNameObject, ".")(1)
    Set objFrame = ThisWorkbook.Worksheets(strSheetName).OLEObjects(strObjectName)
    
    With ExcelBricks.fGetRange(strRange)
        strRangeWorksheet = .Worksheet.Name
        Set objLabelRange = ExcelBricks.fGetRange("'" & strRangeWorksheet & "'!" & .Cells(1, 1).AddressLocal & ":" & .Cells(.Rows.Count, 1).AddressLocal)
        Set objValueRange = ExcelBricks.fGetRange("'" & strRangeWorksheet & "'!" & .Cells(1, .Columns.Count).AddressLocal & ":" & .Cells(.Rows.Count, .Columns.Count).AddressLocal)
        strAverageRangeAddress = "'" & strRangeWorksheet & "'!" & Replace(.Worksheet.Cells(1, .Column).AddressLocal, "$1", "$:r:") & _
            ":" & Replace(.Worksheet.Cells(1, .Column + .Columns.Count - 2).AddressLocal, "$1", "$:r:")
    End With
    
    
    ' we don't want to quit if there are missing labels
    On Error Resume Next

    ' set the font size for each label
    For Each objCell In objLabelRange
        ' row offset is required because the label row is absolute and the value row is relative
        ' column offset is required because the value range is relative
        intValue = objValueRange.Cells(objCell.Row - objValueRange.Row + 1, 1).Value
            
        With objFrame.Object.Controls("lbl" & objCell.Value)
            If intValue = "" Or intValue = 0 Then
                .Visible = False
            Else
                intAverage = Application.WorksheetFunction.Average(ExcelBricks.fGetRange( _
                    Replace(strAverageRangeAddress, ":r:", objCell.Row)))
                
                ' change the font color if this exceeds x% of the running average + an offset
                ' used to identify new terms
                If intValue > dblSpikeFactor * intAverage + dblSpikeOffset Then
                    .ForeColor = intSpikeTagColor
                Else
                    .ForeColor = intNormalTagColor
                End If
                .Visible = True
                
                ' set font size
                .Font.Size = intMinFontSize + Round(dblFontScaling * intValue)
                .Caption = objCell.Value & " (" & intValue & ") "
            End If
        End With
    Next

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' clean up
    On Error Resume Next
    Set objFrame = Nothing
    Set objValueRange = Nothing
    Set objLabelRange = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' clears tags
Sub sClearTagCloud(strSheetNameObject)
On Error GoTo Error_Handler
    
    ' initialize
    strSheetName = Split(strSheetNameObject, ".")(0)
    strObjectName = Split(strSheetNameObject, ".")(1)
    Set objFrame = ThisWorkbook.Worksheets(strSheetName).OLEObjects(strObjectName)
    
    ' clear controls
    For Each i In objFrame.Object.Controls
        objFrame.Object.Controls.Remove i.Name
    Next

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    On Error Resume Next
    ' cleanup
    Set objFrame = Nothing
    On Error GoTo 0

    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' set configuration variables
Sub sSetConfiguration(strConfiguration)
    ' reset values
    intMinFontSize = 7
    intMaxFontSize = 24
    dblSpikeFactor = 1.1
    dblSpikeOffset = 5
    intNormalTagColor = 16744448
    intSpikeTagColor = 33023
    
    ' set configuration
    arrAssignments = Split(strConfiguration, ";")
    For i = 0 To UBound(arrAssignments)
        strAssignment = Split(Trim(arrAssignments(i)), "=")
        
        Select Case LCase(Trim(strAssignment(0)))
        Case "intminfontsize"
            intMinFontSize = CInt(strAssignment(1))
        Case "intmaxfontsize"
            intMaxFontSize = CInt(strAssignment(1))
        Case "dblspikefactor"
            dblSpikeFactor = CDbl(strAssignment(1))
        Case "dblspikeoffset"
            dblSpikeOffset = CDbl(strAssignment(1))
        Case "intnormaltagcolor"
            intNormalTagColor = CInt(strAssignment(1))
        Case "intspiketagcolor"
            intSpikeTagColor = CInt(strAssignment(1))
        End Select
    Next
    
    ' save configuration
    strSavedConfiguration = strConfiguration
End Sub



' check if strLabelName any existing labels
Function fIsOverLap(strLabelName)

    ' initialize
    With objFrame.Object.Controls(strLabelName)
        intTopLeftX = .Left
        intTopLeftY = .Top
        intBottomRightX = .Left + .Width
        intBottomRightY = .Top + .Height
    End With
    
    ' check if the label overlaps with any other label
    For Each objLabel In objFrame.Object.Controls
        
        ' no need to check if it's the same object
        If objLabel.Name <> strLabelName Then
            ' get values
            With objLabel
                intTopLeftX_Temp = .Left
                intTopLeftY_Temp = .Top
                intBottomRightX_Temp = .Left + .Width
                intBottomRightY_Temp = .Top + .Height
            End With
            
            ' X alignment checks, Y alignment checks
            If ((intTopLeftX_Temp - intTopLeftX) * (intBottomRightX_Temp - intTopLeftX) <= 0 Or _
                    (intTopLeftX_Temp - intBottomRightX) * (intBottomRightX_Temp - intBottomRightX) <= 0 Or _
                    (intTopLeftX - intTopLeftX_Temp) * (intBottomRightX - intTopLeftX_Temp) <= 0 Or _
                    (intTopLeftX - intBottomRightX_Temp) * (intBottomRightX - intBottomRightX_Temp) <= 0) _
                And ((intTopLeftY_Temp - intTopLeftY) * (intBottomRightY_Temp - intTopLeftY) <= 0 Or _
                    (intTopLeftY_Temp - intBottomRightY) * (intBottomRightY_Temp - intBottomRightY) <= 0 Or _
                    (intTopLeftY - intTopLeftY_Temp) * (intBottomRightY - intTopLeftY_Temp) <= 0 Or _
                    (intTopLeftY - intBottomRightY_Temp) * (intBottomRightY - intBottomRightY_Temp) <= 0) Then
                fIsOverLap = True
                Exit Function
            End If
        End If
    Next

    fIsOverLap = False

End Function

