param(
    [string[]]$ComputerName="localhost",
    [string[]]$Folder="example_nxFile"
)
$Node = $ComputerName
$Credential = Get-Credential -UserName:"root" -Message:"Enter Password:"

#Ignore SSL certificate validation
$opt = New-CimSessionOption -UseSsl:$true -SkipCACheck:$true -SkipCNCheck:$true -SkipRevocationCheck:$true

#Options for a trusted SSL certificate
#$opt = New-CimSessionOption -UseSsl:$true
$Sess=New-CimSession -Credential:$credential -ComputerName:$Node -Port:5986 -Authentication:basic -SessionOption:$opt -OperationTimeoutSec:90
write-host "Start-DscConfiguration -Path:$Folder -CimSession:$Sess -Wait -Verbose"
Start-DscConfiguration -Path:$Folder[0] -CimSession:$Sess -Wait -Verbose
