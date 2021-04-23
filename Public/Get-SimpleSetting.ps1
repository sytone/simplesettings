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
        [String] $ConfigFile = $null
    )

    $configuration = Get-SettingsAsObject -ConfigFile $ConfigFile
    
    Write-Verbose -Message "output '$($configuration | ConvertTo-Json -Compress -Depth 10)'"

    $sectionExists = $null -ne $configuration.$Section
    $sectionNameExists = $null -ne $configuration.$Section.$Name
    $nameExists = $null -ne $configuration.$Name

    if ($Section -eq "" -and $Name -eq "") {
        return $configuration
    }

    #Name not found, section if Name = ""?
    if ($sectionExists -and $Name -eq "") {
        return $configuration.$Section
    }


    if ($sectionNameExists) {
        return $configuration.$Section.$Name
    }

    if ($nameExists) {
        return $configuration.$Name
    }

    return $DefaultValue
}