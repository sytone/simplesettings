function Set-SettingsAsObject {
    [CmdletBinding()]
    param (
        $SettingsObject,
        [String] $ConfigFile = $null,
        [Parameter()]
        [Switch] $DisableConfigurationBackup
    )
    $ConfigFile = Get-SimpleSettingConfigurationFile -override $ConfigFile
    if(-not $DisableConfigurationBackup) {
        Start-SimpleSettingConfigurationBackup -ConfigFile $ConfigFile
        Start-SimpleSettingConfigurationBackupCleanup -ConfigFile $ConfigFile
    }
    $SettingsObject | ConvertTo-Json -Depth 20 | Set-Content $ConfigFile
}