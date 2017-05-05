Attribute VB_Name = "fxShowAllFonts"
Sub ShowAllFonts()
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    ' Various incarnations by Chris Rae,
    ' sometime 1997 to 19/5/99.
    
    Const UseFontSize = 18

    Dim aFont
    Dim LoopThrough As Integer
    
    Documents.Add
    With Selection
        .Font.Name = "Times New Roman"
        .Font.Size = UseFontSize
        .TypeText "There are " & FontNames.Count & _
           " fonts installed. They are (listed in order that they are displayed in this file) "
    End With

    For LoopThrough = 1 To FontNames.Count
        ' All the """""""s look a bit funny but work
        Selection.TypeText """" & FontNames(LoopThrough) & """" & _
           IIf(LoopThrough = FontNames.Count - 1, " and ", ",")
    Next LoopThrough
    Selection.TypeText "."
    Selection.TypeParagraph
    Selection.TypeParagraph
    
    For Each aFont In FontNames
        With Selection
            .Font.Name = aFont
            .TypeText "This a paragraph of example text typed in the "
            .Font.Name = "Times New Roman"
            .TypeText aFont
            .Font.Name = aFont
            .TypeText " font, running in Word 97. THIS IS AN EXAMPLE SENTENCE IN CAPITAL LETTERS, JUST AS A BONUS. And - 0 1 2 3 4 5 6 7 8 9 here are some free numbers."
            .Font.Bold = True
            .TypeText " Here is some text in bold, "
            .Font.Bold = False
            .TypeText "and "
            .Font.Italic = True
            .TypeText "here is some text in italics."
            .Font.Italic = False
            .TypeParagraph
            .TypeParagraph
        End With
    Next aFont
    
    ' Jump back to the top
    Selection.HomeKey unit:=wdStory
    ' And pretend that the document is saved already
    ActiveDocument.Saved = True
End Sub

