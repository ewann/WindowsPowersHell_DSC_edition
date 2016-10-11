#https://blogs.msdn.microsoft.com/powershell/2013/12/23/automatically-resuming-windows-powershell-workflow-jobs-at-logon/
#this invokes the job containing the reboot
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Normal -NoLogo -NoProfile -NoExit -File "C:\WindowsPowersHell_DSC_edition\Powershell\Start-WFJob.ps1"
