<#
.SYNOPSIS
    Get the configuration file path for SimpleSettings.

.DESCRIPTION
    Get the configuration file path for SimpleSettings. The configuration file is a JSON file that contains the settings you use in PowerShell scripts.

.PARAMETER Path
    The path to the settings file.

.INPUTS
    None

.OUTPUTS
    String

.EXAMPLE
    Get-SimpleSettingConfigurationFile -Path "C:\MySettings.json"

    This will get the configuration file path for SimpleSettings. If the Path is not provided it will use the default configuration file path.

#>
function Get-SimpleSettingConfigurationFile {
    [CmdletBinding()]
    param (
        [Alias("override")]
        [Parameter()]
        [String] $Path = $null
    )

    if ($null -eq $Path -or $Path -eq "") {
        Write-Verbose -Message "No Path provided, using default configuration file '$env:SIMPLESETTINGS_CONFIG_FILE'"
        $defaultConfigFile = $env:SIMPLESETTINGS_CONFIG_FILE
    }
    else {
        $defaultConfigFile = $Path
    }

    if (-not (Test-Path $defaultConfigFile)) {
        "{}" | Set-Content $defaultConfigFile
    }

    Write-Verbose -Message "Configuration File set to '$defaultConfigFile'"
    return $defaultConfigFile
}