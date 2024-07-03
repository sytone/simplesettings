<#
.SYNOPSIS
    Get a setting from the settings file.

.DESCRIPTION
    Get a setting from the settings file. The settings file is a JSON file that contains the settings you use in PowerShell scripts.

.PARAMETER Name
    The name of the setting you want to get.

.PARAMETER Section
    The section of the setting you want to get.

.PARAMETER DefaultValue
    The default value of the setting you want to get.

.PARAMETER ConfigFile
    The path to the settings file.

.PARAMETER MachineSpecific
    If the setting is machine specific. It will look for a value in the configuration using the name prefixed with the machine name.

.PARAMETER AsJson
    If the output should be in JSON format. Otherwise it is the object.

.INPUTS
    None

.OUTPUTS
    Object or JSON

.EXAMPLE
    Get-SimpleSetting -Name "MySetting" -Section "MySection" -DefaultValue "MyDefaultValue" -ConfigFile "C:\MySettings.json"

    This will get the setting "MySetting" from the section "MySection" in the settings file "C:\MySettings.json". If the setting is not found it will return "MyDefaultValue".

#>
function Get-SimpleSetting {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String] $Name = "",
        [Parameter()]
        [String] $Section = "",
        [Parameter()]
        [Object] $DefaultValue,
        [Parameter()]
        [String] $ConfigFile = $null,
        [switch] $MachineSpecific,
        [switch] $AsJson
    )

    $settingsOutput = @{}
    $configuration = Get-SettingsAsObject -ConfigFile $ConfigFile

    Write-Verbose -Message "output '$($configuration | ConvertTo-Json -Compress -Depth 10)'"

    if($MachineSpecific -and $Name -ne "" -and $null -ne $Name) {
        $Name = "$env:COMPUTERNAME-$Name"
    }

    $sectionExists = $null -ne $configuration.$Section
    $sectionNameExists = $null -ne $configuration.$Section.$Name
    $nameExists = $null -ne $configuration.$Name

    if ($Section -eq "" -and $Name -eq "") {
        $settingsOutput = $configuration
        if($AsJson) {
            return ($settingsOutput | ConvertTo-Json)
        } else {
            return $settingsOutput
        }
    }

    #Name not found, section if Name = ""?
    if ($sectionExists -and $Name -eq "") {
        $settingsOutput = $configuration.$Section
        if($AsJson) {
            return ($settingsOutput | ConvertTo-Json)
        } else {
            return $settingsOutput
        }
    }


    if ($sectionNameExists) {
        $settingsOutput = $configuration.$Section.$Name
        if($AsJson) {
            return ($settingsOutput | ConvertTo-Json)
        } else {
            return $settingsOutput
        }
    }

    if ($nameExists) {
        $settingsOutput = $configuration.$Name
        if($AsJson) {
            return ($settingsOutput | ConvertTo-Json)
        } else {
            return $settingsOutput
        }
    }

    $settingsOutput = $DefaultValue
    if($AsJson) {
        return ($settingsOutput | ConvertTo-Json)
    } else {
        return $settingsOutput
    }
}