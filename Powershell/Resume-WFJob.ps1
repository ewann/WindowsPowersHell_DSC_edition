#https://blogs.msdn.microsoft.com/powershell/2013/12/23/automatically-resuming-windows-powershell-workflow-jobs-at-logon/
Import-Module -Name PSWorkflow

$jobs = Get-Job -state Suspended

$resumedJobs = $jobs | resume-job -wait

$resumedJobs | wait-job

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -ForceBootStrap -scope AllUsers
#https://technet.microsoft.com/en-us/library/mt676543.aspx step 4 reminds us: 'Restart PowerShell...Alternatively:'\n",
Import-PackageProvider -Name NuGet
install-module nx -Force -scope AllUsers
write-host "Post reboot software installation has completed. Press {Enter} to close this window and complete next steps."
pause