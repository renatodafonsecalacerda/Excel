Attribute VB_Name = "Sequence"
' version 3.0
'
' sDateSequence - generates a sequence starting from 1.strStart to 2.strEnd stepped by
'       3.strStep and puts it in 4.strTargetAddress.



' wrapper function for sDateSequence
Function sDateSequenceWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    sDateSequenceWrapper = sDateSequence(arrArguments(0), arrArguments(1), _
        CInt(arrArguments(2)), arrArguments(3))
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Function



' generate a sequence and put it in strTargetAddress
Function sDateSequence(strStart, strEnd, intStep, strTargetAddress)
    ' initialize
    objStart = DateValue(strStart)
    objEnd = DateValue(strEnd)
    
    ' generate and copy sequence
    With ExcelBricks.fGetRange(strTargetAddress)
        intRowOffset = 0
        For i = objStart To objEnd Step intStep
            .Offset(intRowOffset, 0) = i
            intRowOffset = intRowOffset + 1
        Next
    End With
End Function
