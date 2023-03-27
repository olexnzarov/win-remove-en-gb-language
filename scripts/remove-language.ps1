$LanguageList = Get-WinUserLanguageList

# Sometimes "en-GB" is already in the language list, but it actually isn't properly registered in the system 🙂
# We need to remove this "phantom" language before we properly add it
$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like "en-GB"))
Set-WinUserLanguageList $LanguageList -Force

# We properly add the "en-GB" language to the list
$LanguageList.Add("en-GB")
Set-WinUserLanguageList $LanguageList -Force

# We remove the "en-GB" language
$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like "en-GB"))
Set-WinUserLanguageList $LanguageList -Force