#Dot source function

##Todo fix this to get current location
. .\Src\Private\Convertfrom-AbrAcMediantConfigIni.ps1

#Import the ini file
$MediantConfigINI = get-content (get-item -path '.\tests\res\m1000.ini').fullname
$MediantConfigINI = (Convertfrom-AbrAcMediantConfigIni -MediantConfigini $MediantConfigINI)
