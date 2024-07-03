<#
.SYNOPSIS
    Remove a setting from the settings file.

.DESCRIPTION
    Remove a setting from the settings file. The settings file is a JSON file that contains the settings you use in PowerShell scripts.

.PARAMETER Name
    The name of the setting you want to remove.

.PARAMETER Section
    The section of the setting you want to remove.

.PARAMETER ConfigFile
    The path to the settings file.

.PARAMETER MachineSpecific
    If the setting is machine specific. It will look for a value in the configuration using the name prefixed with the machine name.

.INPUTS
    None

.OUTPUTS
    None

.EXAMPLE
    Remove-SimpleSetting -Name "MySetting" -Section "MySection" -ConfigFile "C:\MySettings.json"

    This will remove the setting "MySetting" from the section "MySection" in the settings file "C:\MySettings.json".

#>
function Remove-SimpleSetting {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory=$true)]
        [String] $Name,
        [Parameter()]
        [String] $Section = "",
        [Parameter()]
        [String] $ConfigFile = $null,
        [switch] $MachineSpecific
    )

    $configuration = Get-SettingsAsObject -ConfigFile $ConfigFile

    if($MachineSpecific -and $Name -ne "" -and $null -ne $Name) {
        $Name = "$env:COMPUTERNAME-$Name"
    }

    $output = $configuration;
    if ($Section -ne "") {
        if ($null -ne $output.$Section) {
            if($PSCmdlet.ShouldProcess("Configuration Section '$Section'","Remove key named '$Name'")){
                $output.$Section.PSObject.Properties.Remove($Name)
            }
        }
    }
    else {
        if($PSCmdlet.ShouldProcess("Configuration Root","Remove key named '$Name'")){
            $output.PSObject.Properties.Remove($Name)
        }
    }
    Set-SettingsAsObject -SettingsObject $configuration -ConfigFile $ConfigFile
}