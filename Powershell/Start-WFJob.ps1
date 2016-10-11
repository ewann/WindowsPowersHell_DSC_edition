#https://blogs.msdn.microsoft.com/powershell/2013/12/23/automatically-resuming-windows-powershell-workflow-jobs-at-logon/
Remove-Item C:\AutoResumeWFJob\beforeSuspend.txt -ErrorAction SilentlyContinue
Remove-Item C:\AutoResumeWFJob\afterResume.txt -ErrorAction SilentlyContinue

workflow test-restart
{

 InlineScript {Get-Date | Out-File -FilePath C:\WindowsPowersHell_DSC_edition\Powershell\beforeSuspend.txt}
 # Suspend using Restart-Computer activity or Suspend activity
 Restart-Computer -Wait

 InlineScript {Get-Date | Out-File -FilePath C:\WindowsPowersHell_DSC_edition\Powershell\afterResume.txt}

 Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -ForceBootStrap -scope AllUsers
 #https://technet.microsoft.com/en-us/library/mt676543.aspx step 4 reminds us: 'Restart PowerShell...Alternatively:'\n",
 Import-PackageProvider -Name NuGet
 install-module nx -Force -scope AllUsers

}

$job = test-restart -asjob
Wait-job $job
