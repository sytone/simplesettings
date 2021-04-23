function Remove-SimpleSetting {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String] $Name,
        [Parameter()]
        [String] $Section = "",
        [Parameter()]
        [String] $ConfigFile = $null
    ) 

    $configuration = Get-SettingsAsObject -ConfigFile $ConfigFile

    $output = $configuration;
    if ($Section -ne "") {
        if ($null -ne $output.$Section) {
            $output.$Section.PSObject.Properties.Remove($Name)
        }
    }
    else {
        $output.PSObject.Properties.Remove($Name)
    }
    Set-SettingsAsObject -SettingsObject $configuration -ConfigFile $ConfigFile
}