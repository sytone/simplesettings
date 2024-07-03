<#
.SYNOPSIS
    Show a setting in the settings file.

.DESCRIPTION
    Show a setting in the settings file. The settings file is a JSON file that contains the settings you use in PowerShell scripts. The setting will be shown as a JSON object or as a PowerShell object.

.PARAMETER AsJson
    If the output should be in JSON format. Otherwise it is the object.

.PARAMETER ConfigFile
    The path to the settings file.

.INPUTS
    None

.OUTPUTS
    Object or JSON

.EXAMPLE
    Show-SimpleSetting
    Show-SimpleSetting -AsJson
    Show-SimpleSetting -ConfigFile "C:\MySettings.json"
    Show-SimpleSetting -AsJson -ConfigFile "C:\MySettings.json"

#>
function Show-SimpleSetting {
    [CmdletBinding()]
    param (
        [Switch] $AsJson,
        [Parameter()]
        [String] $ConfigFile = $null
    )

    $ConfigFile = Get-SimpleSettingConfigurationFile -Path $ConfigFile

    if ($AsJson) {
        Write-Output (Get-Content $ConfigFile -Raw)
    }
    else {
        Write-Output (Get-Content $ConfigFile -Raw | ConvertFrom-Json)
    }
}