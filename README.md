# WindowsPowersHell_DSC_edition
Provides a demo environment for Powershell Desired State Configuration management of Ubuntu 16.04

## Pre-requisites:
* Knowledge PowerShell & PowerShell DSC:

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


* A private key in the AWS account used to deploy the CloudFormation


* There are currently hard coded AMI ID's in ```WindowsPowersHell_DSC_edition_CF_stack_01.json``` for Ubuntu 16.04 & Windows Server 2012R2. If those AMI's are retired it will be necessary to know how to update / replace them

## Install instructions:
* Launch ```WindowsPowersHell_DSC_edition_CF_stack_01.json``` using
AWS CloudFormation in the ```us-west-1``` region.
* TBC

## License:
MIT license

## Authors:
* Ewan Nisbet

## Credits:
https://jbt.github.io/markdown-editor
