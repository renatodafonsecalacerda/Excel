Attribute VB_Name = "fxDescribeFunctionOffice2010"
'http://spreadsheetpage.com/index.php/tip/C32
'Office 2010 - Excel Create Information to the function
Function EXTRACTELEMENT(Txt, n, Separator) As String
     EXTRACTELEMENT = Split(Application.Trim(Txt), Separator)(n - 1)
End Function
Sub DescribeFunction()
   Dim FuncName As String
   Dim FuncDesc As String
   Dim Category As String
   Dim ArgDesc(1 To 3) As String

   FuncName = "EXTRACTELEMENT"
   FuncDesc = "Returns the nth element of a string that uses a separator character"
   Category = 7 'Text category
   ArgDesc(1) = "String that contains the elements"
   ArgDesc(2) = "Element number to return"
   ArgDesc(3) = "Single-character element separator"

   Application.MacroOptions _
      Macro:=FuncName, _
      Description:=FuncDesc, _
      Category:=Category, _
      ArgumentDescriptions:=ArgDesc
End Sub
