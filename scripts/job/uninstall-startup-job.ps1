# Self-elevate
# Source: https://blog.expta.com/2017/03/how-to-self-elevate-powershell-script.html
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

echo "Removing the RemoveEnGbLanguage job..."
Unregister-ScheduledJob -Name 'RemoveEnGbLanguage' -Force

echo "Removing the RemoveEnGbLanguageAtStartup task..."
Unregister-ScheduledTask -TaskName 'RemoveEnGbLanguageAtStartup' -Confirm:$False

echo "Done"
Start-Sleep -Seconds 2
