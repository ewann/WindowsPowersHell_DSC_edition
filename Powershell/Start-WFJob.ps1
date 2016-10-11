#https://blogs.msdn.microsoft.com/powershell/2013/12/23/automatically-resuming-windows-powershell-workflow-jobs-at-logon/
Remove-Item C:\AutoResumeWFJob\beforeSuspend.txt -ErrorAction SilentlyContinue
Remove-Item C:\AutoResumeWFJob\afterResume.txt -ErrorAction SilentlyContinue

workflow test-restart
{

 InlineScript {Get-Date | Out-File -FilePath C:\WindowsPowersHell_DSC_edition\Powershell\beforeSuspend.txt}
 # Suspend using Restart-Computer activity or Suspend activity
 Restart-Computer -Wait

 InlineScript {Get-Date | Out-File -FilePath C:\WindowsPowersHell_DSC_edition\Powershell\afterResume.txt}

}

$job = test-restart -asjob
Wait-job $job
