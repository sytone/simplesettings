
function Set-SimpleSetting {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String] $Name,
        [Parameter()]
        [String] $Section = "",
        [Parameter()]
        [Object] $Value,
        [Parameter()]
        [String] $ConfigFile = $null
    )    
    
    $configuration = Get-SettingsAsObject -ConfigFile $ConfigFile

    $output = $configuration;
    if ($Section -ne "") {
        $setting = [PSCustomObject]@{$Name = $Value }
        Write-Verbose "Setting set to: $($setting | ConvertTo-Json -Depth 10)"
        if ($null -eq $output.$Section) {
            Write-Verbose "Adding section ($Section) to configuration"
            $output | Add-Member -NotePropertyName $Section -NotePropertyValue $setting -Force
        }
        else {
            $output.$Section | Add-Member -NotePropertyName $Name -NotePropertyValue $Value -Force
        }
    }
    else {
        $output | Add-Member -NotePropertyName $Name -NotePropertyValue $Value -Force
    }
    Set-SettingsAsObject -SettingsObject $configuration -ConfigFile $ConfigFile
}