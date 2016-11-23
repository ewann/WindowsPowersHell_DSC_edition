param (
 [Parameter(Mandatory=$true)][string]$linuxIP
)

write-host "---------------------------------------"
write-host "demo1"
write-host "---------------------------------------"
pause

write-host "From a PowerShell window execute  ssh ubuntu@$linuxIP -i {private-key-file}"
write-host "Verify /tmp/example doesn't exist on the Linux server:"
write-host "sudo ls /tmp/example"
pause

write-host "Creating the file /tmp/example on the Linux server using PowerShell DSC..."
pushd c:\windowspowershell_dsc_edition\dsc


write-host "Creating the DSC Mof file..."
. .\example_nxFile.ps1
example_nxFile -ComputerName $linuxIP #'{Linux-server-private-ip-address}'
pause

write-host "Pushing the configuration to the Linux server. supply 'root' in the prompt:"
 .\push_configuration.ps1 -ComputerName $linuxIP -Folder .\example_nxFile
pause

write-host "Verify /tmp/example now exists on the Linux server:"
write-host "sudo cat /tmp/example"
pause

write-host "---------------------------------------"
write-host "end of demo 1"
write-host "---------------------------------------"
pause

write-host "---------------------------------------"
write-host "demo2"
write-host "---------------------------------------"
pause
write-host
write-host "Installing Hashicorp Vault on Linux server. Enter 'root' when prompted:"
pushd c:\windowspowershell_dsc_edition\dsc
. .\example_download_install_vault.ps1
example_download_install_vault -ComputerName $linuxIP
.\push_configuration.ps1 -ComputerName $linuxIP -Folder .\example_download_install_vault

write-host
write-host "On the Linux server execute:"
write-host "/opt/hashicorp/vault/vault server -dev"
