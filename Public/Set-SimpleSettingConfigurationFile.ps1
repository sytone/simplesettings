<#
.SYNOPSIS
    Set the configuration file path for SimpleSettings.

.DESCRIPTION
    Set the configuration file path for SimpleSettings. The configuration file is a JSON file that contains the settings you use in PowerShell scripts.

.PARAMETER Path
    The path to the settings file.

.INPUTS
    None

.OUTPUTS
    None

.EXAMPLE
    Set-SimpleSettingConfigurationFile -Path "C:\MySettings.json"

    This will set the configuration file path for SimpleSettings to "C:\MySettings.json".
#>
function Set-SimpleSettingConfigurationFile {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory=$true)]
        [String] $Path
    )

    if ($null -eq $Path -or $Path -eq "") {
        Write-Error -Message "No Path provided"
    }
    else {
        if($PSCmdlet.ShouldProcess('$env:SIMPLESETTINGS_CONFIG_FILE',"Set value to '$Path'")){
            $env:SIMPLESETTINGS_CONFIG_FILE = $Path
        }
    }

    if (-not (Test-Path $env:SIMPLESETTINGS_CONFIG_FILE)) {
        New-Item -Path $env:SIMPLESETTINGS_CONFIG_FILE -ItemType File -Force
        "{}" | Set-Content $env:SIMPLESETTINGS_CONFIG_FILE
    }

    Write-Verbose -Message "Configuration File set to '$env:SIMPLESETTINGS_CONFIG_FILE'"
}