# Self-elevate
# Source: https://blog.expta.com/2017/03/how-to-self-elevate-powershell-script.html
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

echo "Creating the RemoveEnGbLanguage job..."
Register-ScheduledJob -Name "RemoveEnGbLanguage" -ScriptBlock {
  $LanguageList = Get-WinUserLanguageList

  $LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like "en-GB"))
  Set-WinUserLanguageList $LanguageList -Force

  $LanguageList.Add("en-GB")
  Set-WinUserLanguageList $LanguageList -Force

  $LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like "en-GB"))
  Set-WinUserLanguageList $LanguageList -Force
} 

# Create a task that will run the scheduled job
# You can view this task in the "Task Scheduler"
$TaskArgument = "-NoLogo -NonInteractive -WindowStyle Hidden -Command `"Import-Module PSScheduledJob; `$J = Get-ScheduledJob -Name RemoveEnGbLanguage; `$J.Run()`""
$TaskAction = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument $TaskArgument

echo "Creating the RemoveEnGbLanguageAtStartup task..."
Register-ScheduledTask -Trigger (New-ScheduledTaskTrigger -AtLogOn) -Action $TaskAction -TaskName "RemoveEnGbLanguageAtStartup"

echo "Running the RemoveEnGbLanguage job..."
$Job = Get-ScheduledJob -Name RemoveEnGbLanguage
$Job.Run()

Start-Sleep -Seconds 3
