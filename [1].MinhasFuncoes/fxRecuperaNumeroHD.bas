Attribute VB_Name = "fxRecuperaNumeroHD"
Option Explicit

Private Declare Function apiGetVolumeInformation Lib "kernel32" Alias "GetVolumeInformationA" (ByVal lpRootPathName As String, ByVal lpVolumeNameBuffer As String, ByVal nVolumeNameSize As Long, _
   lpVolumeSerialNumber As Long, lpMaximumComponentLength As Long, lpFileSystemFlags As Long, ByVal lpFileSystemNameBuffer As String, ByVal nFileSystemNameSize As Long) As Long

Private Const MAX_PATH = 260

Function RecuperarVolume1(strDrive As String) As String
'   Função para devolver o nome do volume para um drive
'   Recebe:
'       strDrive - uma letra válida para o drive, no formato "C:\"
'   Devolve:
'       O nome do volume, se existir. Se não existir, devolve "Sem Rotulo"

Dim strVolume As String

   strVolume = Dir(strDrive, vbVolume)
   If strVolume = vbNullString Then
       strVolume = "Sem rótulo"
   End If
   RecuperarVolume1 = strVolume
End Function

Function RecuperarVolume2(strDrive As String) As String
'   Função para devolver o nome do volume para um drive
'   Recebe:
'       strDrive - uma letra válida para o drive, no formato "C:\"
'   Devolve:
'       O nome do volume, se existir. Se não existir, devolve "Sem Rotulo"

Dim lngDevolve As Long
Dim lngUsos1 As Long
Dim lngUsos2 As Long
Dim lngUsos3 As Long
Dim strVolume As String
Dim strUsos As String

   strVolume = Space(MAX_PATH)
   strUsos = Space(MAX_PATH)
   lngDevolve = apiGetVolumeInformation(strDrive, strVolume, Len(strVolume), lngUsos1, lngUsos2, lngUsos3, strUsos, Len(strUsos))
   strVolume = Left(strVolume, InStr(strVolume, vbNullChar) - 1)
   If strVolume = vbNullString Then
       strVolume = "Sem Rorulo"
   End If
   RecuperarVolume2 = strVolume
End Function

Function RecuperarNumeroSerie(strDrive As String) As String
'   Função para devolver o número de série de um disco rígido
'   Recebe:
'       strDrive - uma letra válida para o drive, no formato "C:\"
'   Devolve:
'       O número de série para o drive, no formato "xxxx-xxxx"

Dim lngDevolve As Long
Dim lngUsos1 As Long
Dim lngUsos2 As Long
Dim lngSerial As Long
Dim strUsos1 As String
Dim strUsos2 As String
Dim strSerie As String

   strUsos1 = Space(MAX_PATH)
   strUsos2 = Space(MAX_PATH)
   lngDevolve = apiGetVolumeInformation(strDrive, strUsos1, Len(strUsos1), lngSerial, lngUsos1, lngUsos2, strUsos2, Len(strUsos2))
   strSerie = Trim(Hex(lngSerial))
   strSerie = String(8 - Len(strSerie), "0") & strSerie
   strSerie = Left(strSerie, 4) & "-" & Right(strSerie, 4)
   RecuperarNumeroSerie = strSerie
End Function

Function Exibe()
MsgBox RecuperarNumeroSerie("C:\")
End Function


