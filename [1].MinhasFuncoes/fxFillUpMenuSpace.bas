Attribute VB_Name = "fxFillUpMenuSpace"
Sub FillUpMenuSpace()
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    ' This routine creates a very large selection
    ' of menus on a custom toolbar and a few
    ' autotext items - once it has run the autotext
    ' menu is corrupted. BACKUP YOUR NORMAL TEMPLATE
    ' BEFORE RUNNING THIS!!!
    ' By Chris Rae, 4/99
    Dim FillBar, TopLevels, NextLevels

    NormalTemplate.AutoTextEntries.Add Name:="Autotext entry 1", Range:=Selection.Range
    NormalTemplate.AutoTextEntries.Add Name:="Autotext entry 2", Range:=Selection.Range
    NormalTemplate.AutoTextEntries.Add Name:="Autotext entry 3", Range:=Selection.Range
    NormalTemplate.AutoTextEntries.Add Name:="Autotext entry 4", Range:=Selection.Range

    With CommandBars.Add(Name:="FILL")
        .Visible = True
    End With

    For TopLevels = 1 To 500
        Set FillBar = CommandBars("FILL")

        For NextLevels = 1 To 50
            Set FillBar = FillBar.Controls.Add(Type:=msoControlPopup)
            FillBar.Caption = "Filling up the word menu space"
        Next NextLevels
    Next TopLevels

    CommandBars("FILL").Delete
End Sub

