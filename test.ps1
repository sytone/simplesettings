$Timestamp = Get-date -uformat "%Y%m%d-%H%M%S"
$PSVersion = $PSVersionTable.PSVersion.Major
$TestFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"

Set-Location $PSScriptRoot

"`n`tSTATUS: Testing with PowerShell $PSVersion`n"
    
Import-Module Pester -force
Invoke-Pester -Path "$PSScriptRoot\Tests" -OutputFormat NUnitXml -OutputFile "$PSScriptRoot\$TestFile" -PassThru |
Export-Clixml -Path "$PSScriptRoot\PesterResults_PS$PSVersion`_$Timestamp.xml"
        

$AllFiles = Get-ChildItem -Path $PSScriptRoot\PesterResults*.xml | Select-Object -ExpandProperty FullName
"`n`tSTATUS: Finalizing results`n"
"COLLATING FILES:`n$($AllFiles | Out-String)"

#What failed?
$Results = @( Get-ChildItem -Path "$PSScriptRoot\PesterResults_PS*.xml" | Import-Clixml )
            
$FailedCount = $Results |
Select-Object -ExpandProperty FailedCount |
Measure-Object -Sum |
Select-Object -ExpandProperty Sum

"Failed Count: $FailedCount`n"

if ($FailedCount -gt 0) {

    $FailedItems = $Results |
    Select-Object -ExpandProperty Tests |
    Where-Object { $_.Passed -notlike $True }

    "FAILED TESTS SUMMARY:`n"
    $FailedItems | ForEach-Object {
        $Item = $_
        [pscustomobject]@{
            Describe = $Item.Describe
            Context  = $Item.Context
            Name     = "It $($Item.Name)"
            Result   = $Item.Result
        }
    } |
    Sort-Object Describe, Context, Name, Result |
    Format-List
}
$Results = $null
Remove-Item "$PSScriptRoot\PesterResults_PS*.xml" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$PSScriptRoot\TestResults_PS*.xml" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$PSScriptRoot\Tests\test-config.*" -Force -ErrorAction SilentlyContinue | Out-Null

if ($FailedCount -gt 0) {
    throw "$FailedCount tests failed."
}