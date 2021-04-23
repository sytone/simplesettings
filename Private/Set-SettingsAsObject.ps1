function Set-SettingsAsObject {
    [CmdletBinding()]
    param (
        $SettingsObject,
        [String] $ConfigFile = $null
    )
    $ConfigFile = Get-SimpleSettingConfigurationFile -override $ConfigFile
    Start-SimpleSettingConfigurationBackup -ConfigFile $ConfigFile
    Start-SimpleSettingConfigurationBackupCleanup -ConfigFile $ConfigFile
    $SettingsObject | ConvertTo-Json -Depth 20 | Set-Content $ConfigFile
}