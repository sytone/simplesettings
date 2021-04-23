function Start-SimpleSettingConfigurationBackup {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String] $ConfigFile = $null
    )
    $ConfigFile = Get-SimpleSettingConfigurationFile -override $ConfigFile
    $timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
    Copy-Item -Path $ConfigFile -Destination "$ConfigFile.$timestamp"
}