Attribute VB_Name = "fxCCellCollection"
'http://www.informit.com/articles/article.aspx?p=1346864
Public Sub CreateCellsCollection()

    Dim clsCell As CCell
    Dim rngCell As Range

    ' Create new Cells collection
    Set gcolCells = New Collection

    ' Create Cell objects for each cell in Selection
    For Each rngCell In Application.Selection
        Set clsCell = New CCell
        Set clsCell.Cell = rngCell
        clsCell.Analyze
        'Add the Cell to the collection
        gcolCells.Add Item:=clsCell, Key:=rngCell.Address
    Next rngCell

    ' Display the number of Cell objects stored
    MsgBox "Number of cells stored: " & CStr(gcolCells.Count)

End Sub
