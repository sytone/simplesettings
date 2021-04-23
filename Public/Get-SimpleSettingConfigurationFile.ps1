function Get-SimpleSettingConfigurationFile($override = $null) {
    if ($null -eq $override -or $override -eq "") {
        $defaultConfigFile = "$env:USERPROFILE\scripts\systemconfiguration.json"
    }
    else {
        $defaultConfigFile = $override
    }
    if (-not (Test-Path $defaultConfigFile)) {
        "{}" | Set-Content $defaultConfigFile
    }
    Write-Verbose -Message "Configuration File set to '$defaultConfigFile'"
    return $defaultConfigFile
}