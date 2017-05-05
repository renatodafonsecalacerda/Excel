Attribute VB_Name = "Chart"
' version 1.4.1
'
' sAddSeries - adds series with x axis 2.strXRange and y values 3.strYRange
'   to 1.<worksheet>.chartname
'
' sClearChart - removes all series from 1.<worksheet>.chartname
'
' sLegendDisplay - if 2.strStatus is blank toggles legend in
'   1.<worksheet>!chartname
'
' sRemoveSeries - remove series 2. strName from 1.<worksheet>.chartname
'
' sSetConfiguration - sets (global) configuration parameters using 1.strConfiguration, a
'   semicolon delimited list of assignments for
'       intMaxSeries (25) - the maximum number of series in the chart
'   not setting a value will change it to it's default value (given in parentheses)
'
' sSetChartSource - sets 1.<worksheet>.chartname's source to 2.strRange
'
' sSwitchRowColumn - toggles row / columns for 1.<worksheet>.chartname


' global variables
Dim intMaxSeries
Dim strSavedConfiguration



' sSetConfiguration wrapper
Sub sSetConfigurationWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sSetConfiguration arrArguments(0)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub


' wrapper function for sSetChartSource
Sub sSetChartSourceWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    Call sSetChartSource(arrArguments(0), arrArguments(1))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub


' wrapper function for sClearChart
Sub sClearChartWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    Call sClearChart(arrArguments(0))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub


' wrapper function for sAddSeries
Sub sAddSeriesWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    Call sAddSeries(arrArguments(0), arrArguments(1), arrArguments(2))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub


' wrapper function for sLegendDisplay
Sub sLegendDisplayWrapper(strArguments)
On Error GoTo Error_Handler

    ' default is toggle (for 2nd parameter blank)
    arrArguments = Split(strArguments & Chr(10), Chr(10))
    Call sLegendDisplay(arrArguments(0), arrArguments(1))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub


' wrapper function for sRemoveSeries
Function sRemoveSeriesWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sRemoveSeriesWrapper = sRemoveSeries(arrArguments(0), arrArguments(1))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Function

' wrapper function for sSwitchRowColumn
Sub sSwitchRowColumnWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    Call sSwitchRowColumn(arrArguments(0))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' set configuration variables
Sub sSetConfiguration(strConfiguration)
    ' reset values
    intMaxSeries = 25
    
    ' set configuration
    arrAssignments = Split(strConfiguration, ";")
    For i = 0 To UBound(arrAssignments)
        strAssignment = Split(Trim(arrAssignments(i)), "=")
        
        Select Case LCase(Trim(strAssignment(0)))
        Case "intmaxseries"
            intMaxSeries = CInt(strAssignment(1))
        End Select
    Next
    
    ' save configuration
    strSavedConfiguration = strConfiguration
End Sub


' sets chart to use source
Private Sub sSetChartSource(strSheetNameObject, strRange)
On Error GoTo Error_Handler
    sSetConfiguration (strSavedConfiguration)

    ' you can have only intMaxSeries series => intMaxSeries+1 rows including header
    With ExcelBricks.fGetRange(strRange)
        If .Rows.Count > intMaxSeries Then
            strRange = "'" & .Worksheet.Name & "'!" & .Cells(1, 1).AddressLocal _
                & ":" & .Cells(intMaxSeries, .Columns.Count).AddressLocal
        End If
    End With
    
    ' set chart source
    Set objChart = fGetObjectFromString(strSheetNameObject)
    objChart.SetSourceData ExcelBricks.fGetRange(strRange), xlRows

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' clean up
    On Error Resume Next
    Set objChart = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' clears chart
Private Sub sClearChart(strSheetNameObject)
On Error GoTo Error_Handler

    ' initialize
    Set objChart = fGetObjectFromString(strSheetNameObject)
    
    ' remove all series from the chart
    For Each objSeries In objChart.SeriesCollection
        objSeries.Delete
    Next

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' clean up
    On Error Resume Next
    Set objChart = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' add series to chart
Private Sub sAddSeries(strSheetNameObject, strXRange, strYRange)
On Error GoTo Error_Handler
    sSetConfiguration (strSavedConfiguration)

    With ExcelBricks.fGetRange(strYRange)
        strValue = .Cells(1, 1).Value
        
        ' check if series already exists
        Set objChart = fGetObjectFromString(strSheetNameObject)
        For Each objSeries In objChart.SeriesCollection
            If LCase(objSeries.Name) = LCase(strValue) Then
                Exit Sub
            End If
        Next
    
        ' if no, add the series
        If objChart.SeriesCollection.Count < intMaxSeries Then
            Set objSeries = objChart.SeriesCollection.NewSeries
            objSeries.Name = "=""" & strValue & """"
            objSeries.Values = "='" & .Worksheet.Name & "'!" & _
                .Cells(1, 2).AddressLocal & ":" & _
                .Cells(1, .Columns.Count).AddressLocal
            objSeries.XValues = strXRange
            Set objSeries = Nothing
        Else
            Err.Raise ExcelBricks.lngShowWarning, , "Chart already has " & intMaxSeries & " words / phrases. Remove an existing word / phrase and try again."
        End If
    End With

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' clean up
    On Error Resume Next
    Set objChart = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' set legend display
Private Sub sLegendDisplay(strSheetNameObject, strStatus)
On Error GoTo Error_Handler
    With fGetObjectFromString(strSheetNameObject)
        ' it it has a legend remove it and resize chart area
        If .HasLegend Then
            .SetElement (msoElementLegendNone)
            .PlotArea.Width = .PlotArea.Parent.Parent.Width * 0.98
        Else
            ' the legend won't be displayed when the chart has no series
            ' the error handler takes care of this case
            On Error Resume Next
            
            .SetElement (msoElementLegendRight)
            
            ' set the legend size depending on chart size
            With .Legend
                intChartWidth = .Parent.Parent.Width
                intChartHeight = .Parent.Parent.Height
                
                .Left = intChartWidth * 0.8 + 10
                .Top = intChartHeight / 10
                .Width = intChartWidth * 0.17
                .Height = intChartHeight * 0.66
            End With
        
            ' set plot area not to overlap legend area
            .PlotArea.Width = .PlotArea.Parent.Parent.Width * 0.77
        End If
    End With

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' clean up
    On Error Resume Next
    Set objChart = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub


' remove series from chart
Private Function sRemoveSeries(strSheetNameObject, strName)
On Error GoTo Error_Handler
    Set objChart = fGetObjectFromString(strSheetNameObject)
    
    ' find the series in the chart and delete it
    For Each objSeries In objChart.SeriesCollection
        If LCase(strName) = LCase(objSeries.Name) Then
            objSeries.Delete
            sRemoveSeries = True
            Exit Function
        End If
    Next
    
    ' if its a series not in the chart
    sRemoveSeries = False
    
Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' clean up
    On Error Resume Next
    Set objChart = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Function


' toggles row / columns
Private Function sSwitchRowColumn(strSheetNameObject)
On Error GoTo Error_Handler
    Set objChart = fGetObjectFromString(strSheetNameObject)
    
    If objChart.PlotBy = XlRowCol.xlColumns Then
        objChart.PlotBy = XlRowCol.xlRows
    Else
        objChart.PlotBy = XlRowCol.xlColumns
    End If
    
Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    ' clean up
    On Error Resume Next
    Set objChart = Nothing
    On Error GoTo 0
    
    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Function



' return object from string
Private Function fGetObjectFromString(strSheetNameObject) As Object
    strSheetName = Split(strSheetNameObject, ".")(0)
    strObjectName = Split(strSheetNameObject, ".")(1)
    Set fGetObjectFromString = ThisWorkbook.Worksheets(strSheetName).ChartObjects(strObjectName).Chart
End Function


