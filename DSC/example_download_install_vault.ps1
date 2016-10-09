#. .\example_download_install_vault.ps1
#example_download_install_vault -ComputerName 'MyTestNode'
#-OutputPath:"C:\temp"

Configuration example_download_install_vault {
  param(
      [string[]]$ComputerName="localhost"
  )
  Import-DscResource -Module nx
  Node $ComputerName {
    nxFile folderMakesSenseHuh
    # 20161008
    # as well as lacking intuition, need to do this seperately
    # file creation as seems to fail silently if the target folder is absent
    {
        DestinationPath = "/opt/hashicorp"
        Type = "Directory"
        Mode = 755
    }
    nxFile SyncArchiveFromWeb
    {
       Ensure = "Present"
       SourcePath = "https://releases.hashicorp.com/vault/0.6.2/vault_0.6.2_linux_amd64.zip"
       # 20161008 problems if we try to download into vault and later extract there as well
       DestinationPath = "/opt/hashicorp/vault_0.6.2_linux_amd64.zip"
       Type = "File"
       Recurse = $true
       Checksum = "mtime"
       Force = $true
       DependsOn = "[nxFile]folderMakesSenseHuh"
    }
    nxArchive ExtractVault
    {
       SourcePath = "/opt/hashicorp/vault_0.6.2_linux_amd64.zip"
       #20161008 trailing slashes currently are important
       #20161008 potentially DestinationPath has issues - changing it can have unpredictable results
       DestinationPath = "/opt/hashicorp/vault"
       Force = $true
       DependsOn = "[nxFile]SyncArchiveFromWeb"
       Ensure = "Present"
    }
    nxScript chmodVault #ResourceName
    {
        TestScript = @"
#!/bin/bash
exit 1
"@
        GetScript = @"
#!/bin/bash
echo hello?
chmod 755 /opt/hashicorp/vault/vault
"@
#20161008 Get script purpose unclear
        SetScript = @"
#!/bin/bash
echo hello?
chmod 755 /opt/hashicorp/vault/vault
"@
        #User = "root"
        #Group = "root"
        #DependsOn = "[nxArchive]ExtractVault"
    }
  }
}
