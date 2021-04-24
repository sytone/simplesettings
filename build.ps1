[CmdletBinding()]
param(
    # A specific folder to build into
    $OutputDirectory,

    # The version of the output module
    [Alias("ModuleVersion")]
    [string]$SemVer
)

$buildconfiguration = Get-Content "$PSScriptRoot\module_config.json" | ConvertFrom-Json

$moduleName = $buildconfiguration.moduleName

$manifestPath = "$PSScriptRoot\$moduleName.psd1"

Write-Host "Validating Manifest..."
$manifest = Test-ModuleManifest -Path $manifestPath

Write-Host "Updating Version..."
if (-not $SemVer) {
    $SemVer =  gitversion -showvariable SemVer
}
Write-Output "Old Version: $($manifest.Version)"
Write-Output "New Version: $SemVer"

# Update the manifest with the new version value and fix the weird string replace bug
$functionList = ((Get-ChildItem -Path "$PSScriptRoot\Public").BaseName)
$currentManifest = Import-PowerShellDataFile $manifestPath
$copyright = "Copyright $(Get-Date -Format "yyyy") $($currentManifest.Author)"

Update-ModuleManifest -Path $manifestPath -ModuleVersion $SemVer -FunctionsToExport $functionList -Copyright $copyright
(Get-Content -Path $manifestPath) -replace "PSGet_$moduleName", $moduleName | Set-Content -Path $manifestPath
(Get-Content -Path $manifestPath) -replace 'NewManifest', $moduleName | Set-Content -Path $manifestPath
(Get-Content -Path $manifestPath) -replace 'FunctionsToExport = ', 'FunctionsToExport = @(' | Set-Content -Path $manifestPath -Force
(Get-Content -Path $manifestPath) -replace "$($functionList[-1])'", "$($functionList[-1])')" | Set-Content -Path $manifestPath -Force


# Create new markdown and XML help files
Write-Host "Building new function documentation" -ForegroundColor Yellow
Import-Module -Name "$PSScriptRoot\$moduleName.psm1" -Force
Get-Module $moduleName
Write-Host "Updating markdown based help" -ForegroundColor Yellow
New-MarkdownHelp -Module $moduleName -OutputFolder .\docs -ErrorAction SilentlyContinue
Update-MarkdownHelp "$PSScriptRoot\docs"
Write-Host "Building new xml file for help" -ForegroundColor Yellow
New-ExternalHelp -Path "$PSScriptRoot\docs" -OutputPath "$PSScriptRoot\en-US\" -Force

return

# Publish the new version back to Master on GitHub
Try {
    # Set up a path to the git.exe cmd, import posh-git to give us control over git, and then push changes to GitHub
    # Note that "update version" is included in the appveyor.yml file's "skip a build" regex to avoid a loop
    $env:Path += ";$env:ProgramFiles\Git\cmd"
    Import-Module posh-git -ErrorAction Stop
    git checkout master
    git add --all
    git status
    git commit -s -m "Update version to $SemVer"
    git push origin master
    Write-Host "$moduleName PowerShell Module version $SemVer published to GitHub." -ForegroundColor Cyan
}
Catch {
    # Sad panda; it broke
    Write-Warning "Publishing update $SemVer to GitHub failed."
    throw $_
}
