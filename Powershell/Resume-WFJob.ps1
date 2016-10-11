#https://blogs.msdn.microsoft.com/powershell/2013/12/23/automatically-resuming-windows-powershell-workflow-jobs-at-logon/
Import-Module –Name PSWorkflow

$jobs = Get-Job -state Suspended

$resumedJobs = $jobs | resume-job -wait

$resumedJobs | wait-job
