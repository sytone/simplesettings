function Get-SettingsAsObject {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String] $ConfigFile = $null
    )
    $ConfigFile = Get-SimpleSettingConfigurationFile -Path $ConfigFile
    return (Get-Content $ConfigFile -Raw | ConvertFrom-Json)
}