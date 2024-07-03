<#
.SYNOPSIS
    Set a setting in the settings file.

.DESCRIPTION
    Set a setting in the settings file. The settings file is a JSON file that contains the settings you use in PowerShell scripts.

.PARAMETER Name
    The name of the setting you want to set.

.PARAMETER Section
    The section of the setting you want to set.

.PARAMETER Value
    The value of the setting you want to set.

.PARAMETER ConfigFile
    The path to the settings file.

.PARAMETER DisableConfigurationBackup
    If the configuration backup should be disabled.

.PARAMETER MachineSpecific
    If the setting is machine specific. It will save the value in the configuration using the name prefixed with the machine name.

.INPUTS
    None

.OUTPUTS
    None

.EXAMPLE
    Set-SimpleSetting -Name "MySetting" -Section "MySection" -Value "MyValue" -ConfigFile "C:\MySettings.json"

    This will set the setting "MySetting" in the section "MySection" in the settings file "C:\MySettings.json" to "MyValue".
#>
function Set-SimpleSetting {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true)]
        [String] $Name,
        [Parameter()]
        [String] $Section = "",
        [Parameter()]
        [Object] $Value,
        [Parameter()]
        [String] $ConfigFile = $null,
        [Parameter()]
        [Switch] $DisableConfigurationBackup,
        [switch] $MachineSpecific
    )

    $configuration = Get-SettingsAsObject -ConfigFile $ConfigFile

    $output = $configuration;

    if ($MachineSpecific) {
        $Name = "$env:COMPUTERNAME-$Name"
    }

    if ($Section -ne "") {
        $setting = [PSCustomObject]@{$Name = $Value }
        Write-Verbose "Setting set to: $($setting | ConvertTo-Json -Depth 10)"

        if ($null -eq $output.$Section) {
            Write-Verbose "Adding section ($Section) to configuration"
            if ($PSCmdlet.ShouldProcess("Configuration Root", "Add new section called '$Section'")) {
                $output | Add-Member -NotePropertyName $Section -NotePropertyValue $setting -Force
            }
        }
        else {
            if ($PSCmdlet.ShouldProcess("Configuration Section '$Section'", "Add/Update key called '$Name'")) {
                $output.$Section | Add-Member -NotePropertyName $Name -NotePropertyValue $Value -Force
            }
        }
    }
    else {
        if ($PSCmdlet.ShouldProcess("Configuration Root", "Add/Update key called '$Name'")) {
            $output | Add-Member -NotePropertyName $Name -NotePropertyValue $Value -Force
        }
    }

    if ($DisableConfigurationBackup) {
        Set-SettingsAsObject -SettingsObject $configuration -ConfigFile $ConfigFile -DisableConfigurationBackup
    }
    else {
        Set-SettingsAsObject -SettingsObject $configuration -ConfigFile $ConfigFile
    }
}