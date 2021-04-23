function Show-SimpleSetting {
    [CmdletBinding()]
    param (
        [Switch] $AsJson,
        [Parameter()]
        [String] $ConfigFile = $null
    )

    $ConfigFile = Get-SimpleSettingConfigurationFile -override $ConfigFile

    if ($AsJson) {
        Write-Output (Get-Content $ConfigFile -Raw)
    }
    else {
        Write-Output (Get-Content $ConfigFile -Raw | ConvertFrom-Json)
    }
}