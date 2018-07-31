$ErrorActionPreference = 'Stop'
#Find-Module -Name "PSFTP" | Install-Module
#
# Henter filer fra FTP, hvis disse er over en vis alder. Kan slette efter sig.  
$filalder = 10 # Er filen modificeret mere end for 10 timer siden, så hent .
$deleteafterget = $true # Skal en hentet fil slettes
# Username, Password skal stuves af vejen på den gode måde, ikke stå i scriptet. 
$username = 'xxx'
$pass = 'xxx'
#
$ftpserver = 'ftp://localhost'
$ftppath = '/' # hvor i træet under brugerens ftp-home starter vi
$lokalpath = 'C:\temp'
#
try {
    Import-Module PSFTP
    $password = $pass | ConvertTo-SecureString -asPlainText -Force
    $credentials = New-Object System.Management.Automation.PSCredential($username, $password)
    Set-FTPConnection -Credentials $credentials -Server $ftpserver -Session session1 -UsePassive | Out-Null
    $session = Get-FTPConnection -Session session1
    $filer = Get-FTPChildItem -Session $Session -Path $ftppath
    foreach ($fil in $filer) {
        # ModifiedDate er en åndssvag streng, ikke en DateTime. Og i et åndssvagt format
        $modifieddate = ([datetime]::ParseExact($fil.ModifiedDate, "MM-dd-yy  hh:mmtt", [System.Globalization.CultureInfo]::InvariantCulture))
        if ($modifieddate -le (Get-Date).AddHours( - $filalder)) {
            ($fil | Get-FTPItem -Session $Session -LocalPath $lokalpath -Overwrite) | Out-Null
            Write-Host ($fil.FullName + ' er hentet')
            if ($deleteafterget) {
                ($fil | Remove-FTPItem -Session $Session) | Out-Null
                Write-Host ($fil.FullName + ' er slettet')
            }
        }
    }
}
catch {
    Write-Host $_.Exception.Message
}
finally {
    $session = $null
}