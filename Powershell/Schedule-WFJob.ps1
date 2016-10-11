$resumeActionscript = ‘-WindowStyle Normal -NoLogo -NoProfile -File "C:\WindowsPowersHell_DSC_edition\Powershell\Resume-WFJob.ps1"’

Get-ScheduledTask -TaskName ResumeWFJobTask –EA SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

$act = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Argument $resumeActionscript

$trig = New-ScheduledTaskTrigger -AtLogOn -RandomDelay 00:00:55

Register-ScheduledTask -TaskName ResumeWFJobTask -Action $act -Trigger $trig -RunLevel Highest
