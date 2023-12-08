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