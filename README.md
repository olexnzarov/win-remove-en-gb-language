# Remove English (United Kingdom, en-GB) keyboard layout

This repository contains a script to remove the "English (United Kingdom)" keyboard layout programmatically. It also has a script to create a scheduled job that will do that automatically on Windows startup. 

This was created due to the annoying Windows bug that keeps adding the `en-GB` language layout without it being in the "Language & region > Language" settings. 

- [United Kingdom keyboard (language) is added automatically](https://superuser.com/questions/1146973/united-kingdom-keyboard-language-is-added-automatically)
- [Can't remove unneeded keyboard layouts - no such setting anywhere](https://superuser.com/questions/1360623/cant-remove-unneeded-keyboard-layouts-no-such-setting-anywhere)
- [How to delete a keyboard layout in Windows 10](https://superuser.com/questions/957552/how-to-delete-a-keyboard-layout-in-windows-10)

These scripts were only tested on Windows 11. 

## How to use - Manual

This method is recommended for anyone who isn't comfortable running any shell commands, or wants a user-interface. It doesn't require any specific knowledge or tools

If you're looking for one line commands, see the [How to use (Shell)](#how-to-use-shell) section.

### Run once

1. Download the repository.
2. Right-click on [scripts/remove-language.ps1](./scripts/remove-language.ps1) file and select the "Run with PowerShell" option.
3. The keyboard layout should be gone.

### Install the scheduled job

Before installing the scheduled job, it's recommened to try it running once to see if it fixes the problem. 

This job will create a process at the startup to remove the language. It may result in a `cmd.exe` window appearing for a short time. If that's something you want to avoid, consider trying other solutions, or finding other way to make the scheduled job work.

1. Download the repository.
2. Right-click on [scripts/job/install-startup-job.ps1](./scripts/job/install-startup-job.ps1) file and select the "Run with PowerShell" option.
3. When it asks you for elevated privileges, press "Yes". You can check the code it wants to run by looking inside the file you right-clicked.
4. The scheduled job should be installed. To verify everything works, restart the computer and see if "English (United Kingdom)" layout is gone. 

### Uninstall the scheduled job

1. Download the repository.
2. Right-click on [scripts/job/uninstall-startup-job.ps1](./scripts/job/uninstall-startup-job.ps1) file and select the "Run with PowerShell" option.
3. When it asks you for elevated privileges, press "Yes". You can check the code it wants to run by looking inside the file you right-clicked.
4. The scheduled job should be uninstalled. You can check the "Task Scheduler" to verify this.
