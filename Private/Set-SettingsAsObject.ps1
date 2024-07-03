function Set-SettingsAsObject {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $SettingsObject,
        [String] $ConfigFile = $null,
        [Parameter()]
        [Switch] $DisableConfigurationBackup
    )
    $ConfigFile = Get-SimpleSettingConfigurationFile -Path $ConfigFile
    if (-not $DisableConfigurationBackup) {
        Start-SimpleSettingConfigurationBackup -ConfigFile $ConfigFile
        Start-SimpleSettingConfigurationBackupCleanup -ConfigFile $ConfigFile
    }
    if ($PSCmdlet.ShouldProcess("$ConfigFile", "Set content to current settings value.")) {
        $SettingsObject | ConvertTo-Json -Depth 20 | Set-Content $ConfigFile
    }
}