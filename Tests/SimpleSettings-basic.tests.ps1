
$moduleName = "SimpleSettings"

Describe "General project validation: $moduleName" {
    Context "Validate the module files" {
        $moduleRoot = Resolve-Path "$PSScriptRoot\.."
        $scripts = Get-ChildItem $moduleRoot -Include *.ps1, *.psm1, *.psd1 -Recurse

        # TestCases are splatted to the script so we need hashtables
        $testCase = $scripts | Foreach-Object { @{file = $_ } }
        It "Script <file> should be valid powershell" -TestCases $testCase {
            param($file)

            $file.fullname | Should -Exist

            $contents = Get-Content -Path $file.fullname -ErrorAction Stop
            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
            $errors.Count | Should -Be 0
        }

        It 'Passes Test-ModuleManifest' {
            $ModuleManifestName = "SimpleSettings.psd1"
            $ModuleManifestPath = Resolve-Path "$PSScriptRoot\..\$ModuleManifestName"
            Test-ModuleManifest -Path $ModuleManifestPath | Should -Not -BeNullOrEmpty
            $? | Should -Be $true
        }
    }
}
