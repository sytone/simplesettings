# Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$Classes = @( Get-ChildItem -Path $PSScriptRoot\Classes\*.ps1 -ErrorAction SilentlyContinue )

# Dot source the files
Foreach($import in @($Public + $Private + $Classes))
{
    Write-Verbose $import.fullname
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Update this section as needed.
# - Read in or create an initial config file and variable
# - Set variables visible to the module and its functions only

if($null -eq $env:SIMPLESETTINGS_CONFIG_FILE -or $env:SIMPLESETTINGS_CONFIG_FILE -eq "") {
    if($null -eq $env:USERPROFILE) {
        $env:USERPROFILE = $PSScriptRoot
    }
    Set-SimpleSettingConfigurationFile -Path "$env:USERPROFILE\scripts\systemconfiguration.json"
    Write-Verbose -Message "Configuration File set to '$env:SIMPLESETTINGS_CONFIG_FILE'"
}

# This only exports the public functions and nothing else.
Export-ModuleMember -Function $Public.Basename
