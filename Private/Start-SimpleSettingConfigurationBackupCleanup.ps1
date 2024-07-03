function Start-SimpleSettingConfigurationBackupCleanup {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [String] $ConfigFile = $null
    )
    $ConfigFile = Get-SimpleSettingConfigurationFile -Path $ConfigFile
    $backups = Get-ChildItem -Path "$ConfigFile.*" | Sort-Object -Property Name -Stable

    if($backups.Length -gt 10) {
        $backups = Get-ChildItem -Path "$ConfigFile.*" | Sort-Object -Property Name -Descending
        $backups[10..($backups.Length)] | Remove-Item
    }
}