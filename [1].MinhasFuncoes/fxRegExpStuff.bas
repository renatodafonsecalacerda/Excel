Attribute VB_Name = "fxRegExpStuff"
' Version 2 was using my matrix theory (which certainly
' seems to work, if I do say so myself). In version 3
' I have abandoned the "FirstInLine" and "LastInLine"
' concepts as they are completely redundant. Although
' it took me ages to work it out. CLR, 2/6/99 to 16/6/99.

' The table type - have to define this at module level because
' you can't define types anywhere else.
Private Type tyRegExpTable
    stCharMatch As String
    inMatchType As Integer
    boRepeat As Boolean
End Type

' The inMatchType constants
Private Const coNormal As Integer = 1
Private Const coAnyChar As Integer = 2
Private Const coOpposite As Integer = 3

' The RegExp table - I have to define this at module level too because
' I can't return arrays of user-defined types from functions.
Private REtable() As tyRegExpTable

' The comparison table. Defined at module level because I'm using it
' in lots of different procedures.
Private boCoTable() As Boolean
Public Sub MakeCoTable(ByVal stTest As String, ByVal stRegExp As String)
    ' Make up the comparison table. CLR, 3/6/99.

    ' The loop through the regexp string
    Dim inREloop As Integer
    ' And the one through the normal string
    Dim inSTloop As Integer

    ' Clear the table to its defaults. A few of
    ' the booleans aren't explicitly set to
    ' "false" but as they default to that when
    ' the variable is cleared, it doesn't matter
    ' all that much.
    ReDim boCoTable(Len(stTest), UBound(REtable))

    For inREloop = 1 To UBound(REtable)
        For inSTloop = 1 To Len(stTest)
            ' Test this match and put the result in the matrix.
            boCoTable(inSTloop, inREloop) = MatchChar(stTest, inSTloop, inREloop)
        Next inSTloop
    Next inREloop
End Sub
Private Function MatchChar(stToMatch As String, inPos As Integer, inREtableEntry As Integer) As Boolean
    ' Match the given character against the given entry
    ' in the RegExp table. Note that repeats don't matter
    ' here as they're dealt with at the path level. Note
    ' that we are relying on the fact that the function
    ' will default to false.
    ' We need to pass a string and position rather than
    ' a char because we need to be able to know whether
    ' it is the first or last character. CLR, 3/6/99.

    Dim chToMatch As String
    chToMatch = Mid(stToMatch, inPos, 1)
    
    Select Case REtable(inREtableEntry).inMatchType
        Case coNormal
            ' Nice and simple - just match it (remember to
            ' compare against the whole string in the
            ' regexp table)
            If InStr(REtable(inREtableEntry).stCharMatch, chToMatch) > 0 Then MatchChar = True
        Case coOpposite
            ' Don't match the regexp string.
            If InStr(REtable(inREtableEntry).stCharMatch, chToMatch) = 0 Then MatchChar = True
        Case coAnyChar
                MatchChar = True
        Case Else
            ' If the program broke, say so and give up
            Debug.Print "Unrecognised regexp type.";
            Stop
    End Select
End Function
Public Sub ShowCoTable(XaxisTitle As String)
    ' Display the comparison table. The X axis
    ' title is a purely cosmetic thing. This table
    ' now incorporates the RegExp table, which
    ' used to be displayed in a different procedure
    ' entirely. CLR, 3/6/99.
    
    Dim y As Integer, x As Integer

    Debug.Print
    Debug.Print "Comparison Table:"
    Debug.Print
    
    Debug.Print XaxisTitle
    For y = 1 To UBound(boCoTable, 2)
        For x = 1 To UBound(boCoTable, 1)
            Debug.Print IIf(boCoTable(x, y), "#", "-");
        Next x
        Debug.Print " " & REtable(y).stCharMatch & _
                           " (type=" & REtable(y).inMatchType & _
                           ", repeat=" & REtable(y).boRepeat & ")"
    Next y
End Sub
Private Function MultiMatch(ByVal stMulti As String) As String
    ' Match the multiple-character definitions like
    ' [a-zA-Z] or [abc] or something. CLR, 3/6/99.

    Dim stCompleteSet As String
    Dim inAtPos As Integer
    Dim inBuildString As Integer

    ' Work down the string, eating it steadily. ;-)
    Do
        ' Just ignore escaped minuses!
        If Left(stMulti, 1) = "\" Then
            ' Add the escaped character.
            stCompleteSet = stCompleteSet & Mid(stMulti, 2, 1)
            stMulti = Mid(stMulti, 3)
        ElseIf Mid(stMulti, 2, 1) = "-" Then
            ' It's a multiple set. Add the chunk...
            For inBuildString = Asc(Mid(stMulti, 1, 1)) To Asc(Mid(stMulti, 3, 1))
                stCompleteSet = stCompleteSet & Chr(inBuildString)
            Next inBuildString
            stMulti = Mid(stMulti, 4)
        Else
            ' It's not a multiple set and it's nothing
            ' escaped - just add this one character
            stCompleteSet = stCompleteSet & Left(stMulti, 1)
            stMulti = Mid(stMulti, 2)
        End If
    Loop Until Len(stMulti) = 0

    MultiMatch = stCompleteSet
End Function
Public Sub MakeREtable(ByVal stRegExp As String)
    ' Make up the regexp matching table. CLR, 2/6/99.

    ' The loop to make the RegExp expression table
    Dim inBuildTable As Integer

    ' The current character we're working on
    Dim chThisChar As String
    
    ' Has the next character been escaped - false
    ' by default at definition time and reset at
    ' the end of the main loop
    Dim boEscaped As Boolean

    ReDim REtable(1 To 1)

    ' Start off before first entry - this variable
    ' is incremented during the loop.
    inBuildTable = 0
    Do
        ' Chop the first character from stRegExp
        chThisChar = Left(stRegExp, 1)
        stRegExp = Mid(stRegExp, 2)

        ' Head onto the next expression chunk.
        inBuildTable = inBuildTable + 1
        ' Make sure the array is big enough to fit the
        ' new thing in.
        ReDim Preserve REtable(1 To inBuildTable)
        
        ' Check for special-case ones.

        ' Repeater?
        If chThisChar = "*" And Not boEscaped Then
            ' Oops! This refers to the last one so
            ' we need to drop the index back a bit.
            inBuildTable = inBuildTable - 1
            ReDim Preserve REtable(1 To inBuildTable)
            REtable(inBuildTable).boRepeat = True

        ' First in line or last in line?
        ElseIf chThisChar = "^" Or chThisChar = "$" And Not boEscaped Then
            ' Not doing a blind thing.
            inBuildTable = inBuildTable - 1
            ' Because the "^" may well be the very first character,
            ' have to be careful with this one!
            If inBuildTable > 0 Then
                ReDim Preserve REtable(1 To inBuildTable)
            End If

        ' Listed characters?
        ElseIf chThisChar = "[" And Not boEscaped Then
            ' Put the whole matching string in there - THERE
            ' IS NO ERROR CHECKING FOR THE END OF THE SQUARE
            ' BRACKETS!!!
            ' If it has the caret (^) at the beginning of it
            ' just negate it.
            If Left(stRegExp, 1) = "^" Then
                ' It does have the caret - no big problem. Just chop
                ' the caret off and set it as being a negative match.
                REtable(inBuildTable).stCharMatch = MultiMatch(Mid(stRegExp, 2, InStr(stRegExp, "]") - 2))
                REtable(inBuildTable).inMatchType = coOpposite
            Else
                ' It's a list but it's not negative.
                REtable(inBuildTable).stCharMatch = MultiMatch(Left(stRegExp, InStr(stRegExp, "]") - 1))
                REtable(inBuildTable).inMatchType = coNormal
            End If
            ' And cut the RegExp string.
            stRegExp = Mid(stRegExp, InStr(stRegExp, "]") + 1)
        
        ' Dot thing?
        ElseIf chThisChar = "." And Not boEscaped Then
            REtable(inBuildTable).stCharMatch = "N/A"
            REtable(inBuildTable).inMatchType = coAnyChar

        ' Escape char?
        ElseIf chThisChar = "\" And Not boEscaped Then
            ' Escape the next one
            boEscaped = True
            ' And don't store this one
            inBuildTable = inBuildTable - 1
        
        Else
            ' Not a special char of any sort - just treat it normally
            REtable(inBuildTable).stCharMatch = chThisChar
            REtable(inBuildTable).inMatchType = coNormal
            ' If this was a char that was escaped, don't do it
            ' again
            boEscaped = False
        End If ' (special char / not special char)

    Loop Until stRegExp = ""
End Sub
Public Function TracePath(x As Integer, y As Integer) As Boolean
    ' Trace the path through the matrix to see whether
    ' the expressions actually match. This routine
    ' is horrendously recursive. CLR, 3/6/99.
    
    ' If we went off the bottom corner of the matrix,
    ' we have completed the path. Note that if the last
    ' element of the matrix is a repeating one, we can go
    ' off the X-end of the matrix but still be on the last
    ' Y-value
    If x > UBound(boCoTable, 1) And (y > UBound(boCoTable, 2) Or (y = UBound(boCoTable, 2) And REtable(UBound(boCoTable, 2)).boRepeat)) Then
        TracePath = True
        ' If we went past the end to the right, or
        ' off the bottom (but not *both*) then it's bad.
    ElseIf x > UBound(boCoTable, 1) Or y > UBound(boCoTable, 2) Then
        TracePath = False
    Else
        ' Wierd repeat-skipping thing that may or may not work.
        ' Because "repeat" technically means *zero* or more, a
        ' repeat may jump a gap in the matrix. Easiest way to
        ' understand this one is to look at a matrix and see
        ' the jumping goin' on.
        If (Not boCoTable(x, y)) And REtable(y).boRepeat Then
            TracePath = TracePath(x, y + 1)
        ' Okay, we're not off the matrix in any shape or
        ' form. Other thing worth remembering here is that
        ' if this particular cell isn't true, there's not
        ' much point in checking any further, so...
        ElseIf boCoTable(x, y) Then
            TracePath = TracePath(x + 1, y + 1) Or _
                        IIf(REtable(y).boRepeat, TracePath(x + 1, y), False) _
                        Or IIf(REtable(y).boRepeat, TracePath(x, y + 1), False)
        End If
    End If
End Function
Public Function RegExp(stTest As String, stRegExp As String) As Boolean
    ' Test a string against a given Regular Expression. CLR, 2/6/99.

    ' Make up the RegExp reference table
    MakeREtable stRegExp
    
    ' Make up the comparison table
    MakeCoTable stTest, stRegExp
    ' Display the table (for debug)
    ShowCoTable stTest

    RegExp = TracePath(1, 1)
End Function


