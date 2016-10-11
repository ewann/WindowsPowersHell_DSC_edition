#https://blogs.msdn.microsoft.com/powershell/2013/12/23/automatically-resuming-windows-powershell-workflow-jobs-at-logon/
#This needs to be called first

$resumeActionscript = '-WindowStyle Normal -NoLogo -NoProfile -File "C:\WindowsPowersHell_DSC_edition\Powershell\Resume-WFJob.ps1"'

Get-ScheduledTask -TaskName ResumeWFJobTask -EA SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

$act = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Argument $resumeActionscript

$trig = New-ScheduledTaskTrigger -AtLogon -RandomDelay 00:01:30

Register-ScheduledTask -TaskName ResumeWFJobTask -Action $act -Trigger $trig -RunLevel Highest



#alternate solution:
#http://stackoverflow.com/questions/31035899/unable-to-resume-a-workflow-via-task-scheduler/31100397#31100397
