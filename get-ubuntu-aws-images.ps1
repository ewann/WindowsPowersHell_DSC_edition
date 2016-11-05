
$images = Get-EC2Image -Owner 099720109477 -region us-west-1

$images | ForEach-Object {
    if ($_.State -eq "available") {
        if ($_.Name -like "*ubuntu*14.04*amd64*server-20160620") {
            write-host $_.ImageId
            write-host $_.Name
            $_.BlockDeviceMappings
            write-host $_.Architecture
            write-host $_.RootDeviceType
            write-host $_.RootDeviceName
            write-host $_.VirtualizationType
            write-host '----------------------------------------------------------'
        }
    }
}


