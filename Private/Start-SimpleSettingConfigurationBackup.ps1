function Start-SimpleSettingConfigurationBackup {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [String] $ConfigFile = $null
    )
    $ConfigFile = Get-SimpleSettingConfigurationFile -Path $ConfigFile
    $timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
    Copy-Item -Path $ConfigFile -Destination "$ConfigFile.$timestamp"
}