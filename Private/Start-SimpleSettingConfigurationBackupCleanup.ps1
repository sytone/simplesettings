function Start-SimpleSettingConfigurationBackupCleanup {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String] $ConfigFile = $null
    )
    $ConfigFile = Get-SimpleSettingConfigurationFile -override $ConfigFile
    $backups = Get-ChildItem -Path "$ConfigFile.*" | Sort-Object -Property Name -Stable
    
    if($backups.Length -gt 10) {
        $backups = Get-ChildItem -Path "$ConfigFile.*" | Sort-Object -Property Name -Descending
        $backups[10..($backups.Length)] | Remove-Item
    }
}