function Get-SettingsAsObject {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String] $ConfigFile = $null
    )
    $ConfigFile = Get-SimpleSettingConfigurationFile -override $ConfigFile
    return (Get-Content $ConfigFile -Raw | ConvertFrom-Json)
}