# WindowsPowersHell_DSC_edition
Provides a demo environment for Powershell Desired State Configuration management of Ubuntu LTS releases

## Pre-requisites:
* Knowledge of PowerShell & PowerShell DSC, or the ability to quickly come up to speed:

  Windows PowerShell Desired State Configuration Overview:
  https://msdn.microsoft.com/en-us/powershell/dsc/overview

  DSC Configurations:
  https://msdn.microsoft.com/en-us/powershell/dsc/configurations

  DSC Resources:
  https://msdn.microsoft.com/en-us/powershell/dsc/resources

  Build Custom Windows PowerShell Desired State Configuration Resources:
  https://msdn.microsoft.com/en-us/powershell/dsc/authoringresource

  Built-In Desired State Configuration Resources for Linux:
  https://msdn.microsoft.com/en-us/powershell/dsc/lnxbuiltinresources

  Get started with Desired State Configuration (DSC) for Linux:
  https://msdn.microsoft.com/en-us/powershell/dsc/lnxgettingstarted


* To use ```WindowsPowersHell_DSC_edition_CF_stack_01.json``` requires familiarity with and access to AWS CloudFormation, or the ability to quickly come up to speed


* An AWS account & a private key in that account or the willingness to follow the instructions below to create them


* Very basic Git knowledge, or the ability to quickly come up to speed


* There are currently hard coded AMI ID's in ```WindowsPowersHell_DSC_edition_CF_stack_01.json``` for Ubuntu 16.04, 14.04 & Windows Server 2012R2. If those AMI's are retired it will be necessary to know how to update / replace them


## Install / Usage instructions:

### Client Setup
* Get access to an AWS account. If you don't already have access, visit https://aws.amazon.com/free to open an account with a free tier access to AWS
* Ensure you have Git installed on your client machine. One of: 
	* ```install-package git```
	* ``` choco install git```
	* https://git-scm.com/downloads
	
	Should provide what you need
        
* Clone this repo locally:
	```
    cd ~
	git clone https://github.com/ewann/WindowsPowersHell_DSC_edition.git
	"{local-repo} is: $pwd\WindowsPowersHell_DSC_edition"
    ```
  Make a note of {local-repo} as we will use it later

### Launch AWS CloudFormation in ```us-west-1``` (N. Califorina) region

* Log in into the AWS Console
* If you don't already have a key pair created in your AWS account, open a new browser window and follow the instructions at http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair. Be sure to save the {private-key-file} as it will be needed later.
* In the AWS Console click ```Services --> Cloud formation``` from the menu to get to https://us-west-1.console.aws.amazon.com/cloudformation/home?region=us-west-1
* Click ```Create Stack```
* For the option ```Choose a template``` click the ```Browse``` button and choose the ```WindowsPowersHell_DSC_edition_CF_stack_01.json```  from the location we cloned the repo into
* Click ```Next```
* Specify a ```Stack name``` What you choose doesn't really matter, but it has to be unique in your AWS account/region
*  Choose an option from the drop down list next to ```Key Name``` - possibly the {private-key-file} you created in a previous step
*  Choose ```16.04``` from ```UbuntuRelease``` - choosing any other option is currently experimental
*  Click ```Next```
*  Options: Specify a ```Key Name``` of ```purpose``` and a ```Value``` of ```LinuxDSCtest``` to help us find the created servers later on. Scroll to the bottom right and click ```Next```
*  Review: On this page there is nothing we need to select / change. Scroll to the bottom right and click ```Next```
*  On the ```Cloud Formation``` Console page (https://us-west-1.console.aws.amazon.com/cloudformation/home?region=us-west-1#/stacks?filter=active) we should see in the top half our stack status ```CREATE_IN_PROGRESS``` In the bottom half we should the creation steps being processed. Wait or refresh the page until the stack reaches status ```CREATE_COMPLETE```

### Log in to the Windows server created by CloudFormation: 

*  In the AWS Console click ```Services --> EC2``` from the menu to get to https://us-west-1.console.aws.amazon.com/ec2/v2/home?region=us-west-1
*  In the center of the screen click the ```Running Instances``` text. 
*  Find the 2 servers that are part of the Cloud Formation stack. If you created an AWS account for this purpose there will only be 2 servers present. If you are using a pre-existing account and have trouble finding them, consider using the ```Tags``` menu and look for the purpose/LinuxDSCtest we specified earlier.
*  Right-click the Windows server and click ```Connect``` You can identify the Windows server by inspecting the ```AMI ID``` on the ```Description``` tab
*  Click ```Download Remote Desktop File``` and save it somewhere you can get back to later
*  Click ```Get password``` and supply the private key file for the private key you (created and?) selected earlier
*  RDP to the Windows server using the credentials. After you log in, a powershell window will open and complete some additional software installation. While waiting for that to complete, copy the {private-key-file} to a location on the server.

### Open an SSH connection to the Linux server:

*  From a powershell window execute ```ssh ubuntu@{Linux-server-private-ip-address} -i {private-key-file}``` 
*  You can find the {Linux-server-private-ip-address} on the AWS EC2 Console page https://us-west-1.console.aws.amazon.com/ec2/v2/home?region=us-west-1 by first selecting the server, then reviewing the ```Description``` tab

### Verify /tmp/example doesn't exist on the Linux server:

*  Once connected to the Linux server execute ```sudo ls /tmp/example``` You should see the response ```ls: cannot access '/tmp/example': No such file or directory```

### Create the file /tmp/example on the Linux server using Powershell DSC:

*  On the Windows server open a new powershell window. Recalling {local-repo} from earlier execute: 

	```pushd c:\windowspowershell_dsc_edition\dsc```


*  Create the DSC Mof file. Execute: 

	```
    . .\example_nxFile.ps1
    example_nxFile -ComputerName '{Linux-server-private-ip-address}'
    ```
* Push the configuration to the Linux server. Execute:

	```.\push_configuration.ps1 -ComputerName '{Linux-server-private-ip-address}' -Folder .\example_nxFile```
    
    
* You will be prompted for the root password. The root password for this server is ```root``` You should see output like:
  ```
  VERBOSE: Perform operation 'Invoke CimMethod' with following parameters, ''methodName' =
  SendConfigurationApply,'className' = MSFT_DSCLocalConfigurationManager,'namespaceName' =
  root/Microsoft/Windows/DesiredStateConfiguration'.
  VERBOSE: Operation 'Invoke CimMethod' complete.
  VERBOSE: Time taken for configuration job to complete is 0.572 seconds
  ```
 
### Verify /tmp/example now exists on the Linux server:

*  If you already closed your SSH connection, review the previous step ```Open an SSH connection to the Linux server``` for a reminder of how to reconnect. 
*  Once connected to the Linux server execute: 

	```sudo cat /tmp/example``` 
    
* You should see the response:

	```hello world```

### Download Hashicorp Vault archive (zip) from the internet, create destination directory, extract archive into location:

* On the Windows server in a powershell window execute:

	```
    pushd c:\windowspowershell_dsc_edition\dsc
    . .\example_download_install_vault.ps1
    example_download_install_vault -ComputerName '{Linux-server-private-ip-address}'
    .\push_configuration.ps1 -ComputerName '{Linux-server-private-ip-address}' -Folder .\example_download_install_vault
    
    ```
    
    
### Start the Hashicorp Vault server in dev mode:

* On the Linux server execute: 
	```
    /opt/hashicorp/vault/vault server -dev
	```
	You should see output that starts like:
    
    ```
    ==> Vault server configuration:

                 Backend: inmem
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
                 Version: Vault v0.6.2

	==> WARNING: Dev mode is enabled!
	```


## License:
MIT license

## Authors:
* Ewan Nisbet

## Credits:
https://jbt.github.io/markdown-editor
