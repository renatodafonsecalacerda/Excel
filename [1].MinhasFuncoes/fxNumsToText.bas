Attribute VB_Name = "fxNumsToText"
' Chris Rae, 2003
Function NumsToText(ByVal thenum As Double) As String
    Dim u_hundreds As Integer
    Dim u_tens As Integer
    Dim u_units As Integer
    Dim outstr As String
    Dim ondigit As Integer
    Dim thischunk As String

    ' Special case for zero, unfortunately
    If thenum = 0 Then
        NumsToText = "zero"
        Exit Function
    End If
    
    ' Nice simple effort for negatives
    If thenum < 0 Then
        thenum = Abs(thenum)
        outstr = "minus "
    End If
    
    ' Work up through the thousands
    ondigit = 0

    Do
        ' Okay, break the number down
        u_units = GetDigit(thenum, ondigit * 3 + 1)
        u_tens = GetDigit(thenum, ondigit * 3 + 2)
        u_hundreds = GetDigit(thenum, ondigit * 3 + 3)
        
        thischunk = ""
    
        'Debug.Print u_hundreds, u_tens, u_units
    
        If u_hundreds > 0 Then
            thischunk = thischunk & Array("one", "two", "three", "four", "five", "six", "seven", "eight", "nine")(u_hundreds - 1) & " hundred"
        End If
    
        If u_tens > 1 Then
            thischunk = thischunk & IIf(u_hundreds > 0, " and ", "")
            thischunk = thischunk & Array("twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety")(u_tens - 2)
        Else
            ' If the number of tens is 1, add ten to the units
            ' so we can still index it below
            u_units = u_units + (u_tens * 10)
        End If
        
        If u_units > 0 Then
            thischunk = thischunk & IIf(u_tens > 1, " ", IIf(u_hundreds > 0, " and ", ""))
            thischunk = thischunk & Array("one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen")(u_units - 1)
        End If

        ' Okay, we have a 1000-chunk-worth
        outstr = thischunk & IIf(ondigit > 0, " ", "") & Array("", "thousand", "million", "billion", "trillion")(ondigit) & IIf(ondigit > 0, " ", "") & outstr
        
        ondigit = ondigit + 1
    Loop Until thenum < 10 ^ ((ondigit) * 3)
    
    NumsToText = outstr
End Function
Function GetDigit(m As Double, n As Integer) As Integer
    '=INT((m-INT(m/10^n)*10^n)/10^(n-1))
    GetDigit = Int((m - Int(m / 10 ^ n) * 10 ^ n) / 10 ^ (n - 1))
End Function
