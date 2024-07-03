#
# To run the tests just call ` Invoke-Pester` in this folder.

BeforeAll {
    Remove-Module SimpleSettings -Force -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\SimpleSettings.psm1 -Force
    $testJson = "$PSScriptRoot\test-config.json"
    "{}" > $testJson
    Start-Sleep -Seconds 1

}

Describe "GetSetSimpleSetting" {
    Context "When modifying the same file" {
        It "sets a simple value" {
            Set-SimpleSetting -Name "simpleroot" -Value "Test Value" -ConfigFile $testJson
            (Get-SimpleSetting -Name "simpleroot" -ConfigFile $testJson) | Should -Be "Test Value"
        }

        It "sets a nested value" {
            Set-SimpleSetting -Name "nestedparam" -Section "complexroot" -Value "Nested" -ConfigFile $testJson
            (Get-SimpleSetting -Name "nestedparam" -Section "complexroot" -ConfigFile $testJson) | Should -Be "Nested"
        }

        It "sets a new nested value" {
            Set-SimpleSetting -Name "nestedparam" -Section "complexroot" -Value "NestedNew" -ConfigFile $testJson
            (Get-SimpleSetting -Name "nestedparam" -Section "complexroot" -ConfigFile $testJson) | Should -Be "NestedNew"
        }

        It "sets a int value" {
            Set-SimpleSetting -Name "int" -Section "complexroot" -Value 45436746765 -ConfigFile $testJson
            (Get-SimpleSetting -Name "int" -Section "complexroot" -ConfigFile $testJson) | Should -Be 45436746765
        }

        It "sets a date value" {
            $date = Get-Date
            Set-SimpleSetting -Name "date" -Section "complexroot" -Value $date -ConfigFile $testJson
            (Get-SimpleSetting -Name "date" -Section "complexroot" -ConfigFile $testJson) | Should -Be $date
        }

        It "sets a bool value" {
            Set-SimpleSetting -Name "enabled" -Section "complexroot" -Value $true -ConfigFile $testJson
            (Get-SimpleSetting -Name "enabled" -Section "complexroot" -ConfigFile $testJson) | Should -Be $true
        }

        It "sets a null value" {
            Set-SimpleSetting -Name "null" -Section "complexroot" -Value $null -ConfigFile $testJson
            (Get-SimpleSetting -Name "null" -Section "complexroot" -ConfigFile $testJson) | Should -Be $null
        }

        It "sets a supercomplex value" {
            Set-SimpleSetting -Name "supercomplex" -Section "complexroot" -Value ([PSCustomObject]@{x = 1; y = 2 }) -ConfigFile $testJson
            (Get-SimpleSetting -Name "supercomplex" -Section "complexroot" -ConfigFile $testJson).x | Should -Be 1
            (Get-SimpleSetting -Name "supercomplex" -Section "complexroot" -ConfigFile $testJson).y | Should -Be 2
        }

        It "gets a missing value return `$null" {
            (Get-SimpleSetting -Name "missingsetting" -ConfigFile $testJson) | Should -Be $null
        }

        It "gets a missing value return default value" {
            (Get-SimpleSetting -Name "missingsetting" -ConfigFile $testJson -DefaultValue "TEST") | Should -Be "TEST"
        }

        It "deletes a normal property" {
            Set-SimpleSetting -Name "simplerootproperty" -Value "Hello" -ConfigFile $testJson
            Get-SimpleSetting -Name "simplerootproperty" -ConfigFile $testJson -DefaultValue "TEST" | Should -Be "Hello"
            Remove-SimpleSetting -Name "simplerootproperty" -ConfigFile $testJson -WhatIf
            Remove-SimpleSetting -Name "simplerootproperty" -ConfigFile $testJson
            Get-SimpleSetting -Name "simplerootproperty" -ConfigFile $testJson -DefaultValue "TEST" | Should -Be "TEST"

        }

        It "deletes a section property" {
            Set-SimpleSetting -Name "simplerootproperty" -Section "delsection" -Value "Hello" -ConfigFile $testJson
            Get-SimpleSetting -Name "simplerootproperty" -Section "delsection" -ConfigFile $testJson -DefaultValue "TEST" | Should -Be "Hello"
            Remove-SimpleSetting -Name "simplerootproperty" -Section "delsection" -ConfigFile $testJson -WhatIf
            Remove-SimpleSetting -Name "simplerootproperty" -Section "delsection" -ConfigFile $testJson
            Get-SimpleSetting -Name "simplerootproperty" -Section "delsection" -ConfigFile $testJson -DefaultValue "TEST" | Should -Be "TEST"

        }

        It "get a section" {
            Set-SimpleSetting -Name "valueone" -Section "sectiontest" -Value "one" -ConfigFile $testJson
            Set-SimpleSetting -Name "valuetwo" -Section "sectiontest" -Value 2 -ConfigFile $testJson
            $expectedValue = "{`"valueone`": `"one`",`"valuetwo`": 2}" | ConvertFrom-Json
            (Get-SimpleSetting -Section "sectiontest" -ConfigFile $testJson).valueone | Should -Be $expectedValue.valueone
            (Get-SimpleSetting -Section "sectiontest" -ConfigFile $testJson).valuetwo | Should -Be $expectedValue.valuetwo
        }

        It "sets a new nested value" {
            Set-SimpleSetting -Name "nestedparam" -Section "complexroot" -Value "NestedNew" -ConfigFile $testJson
            (Get-SimpleSetting -Name "nestedparam" -Section "complexroot" -ConfigFile $testJson) | Should -Be "NestedNew"
        }

        AfterAll {
            Write-Output (Get-Content $testJson | ConvertFrom-Json -Depth 10 | ConvertTo-Json -Depth 10)
        }
    }
}

Describe "Set Values" {
    Context "When using MachineSpecific settings" {
        It "sets a simple value" {
            Set-SimpleSetting -Name "simpleroot" -Value "Test Value" -ConfigFile $testJson -MachineSpecific
            (Get-SimpleSetting -Name "simpleroot" -ConfigFile $testJson -MachineSpecific) | Should -Be "Test Value"

            $savedConfiguration = Get-SimpleSetting -ConfigFile $testJson
            $savedConfiguration | Should -Not -Be $null
            $keyName = "$env:COMPUTERNAME-simpleroot"
            $savedConfiguration.$keyName | Should -Be "Test Value"
        }

        It "sets a nested value" {
            Set-SimpleSetting -Name "nestedparam" -Section "complexroot" -Value "Nested" -ConfigFile $testJson -MachineSpecific
            (Get-SimpleSetting -Name "nestedparam" -Section "complexroot" -ConfigFile $testJson -MachineSpecific) | Should -Be "Nested"
        }


        It "sets a new nested value" {
            Set-SimpleSetting -Name "nestedparam" -Section "complexroot" -Value "NestedNew" -ConfigFile $testJson -MachineSpecific
            (Get-SimpleSetting -Name "nestedparam" -Section "complexroot" -ConfigFile $testJson -MachineSpecific) | Should -Be "NestedNew"
        }

        It "sets a int value" {
            Set-SimpleSetting -Name "int" -Section "complexroot" -Value 45436746765 -ConfigFile $testJson -MachineSpecific
            (Get-SimpleSetting -Name "int" -Section "complexroot" -ConfigFile $testJson -MachineSpecific) | Should -Be 45436746765
        }

        It "sets a date value" {
            $date = Get-Date
            Set-SimpleSetting -Name "date" -Section "complexroot" -Value $date -ConfigFile $testJson -MachineSpecific
            (Get-SimpleSetting -Name "date" -Section "complexroot" -ConfigFile $testJson -MachineSpecific) | Should -Be $date
        }

        It "sets a bool value" {
            Set-SimpleSetting -Name "enabled" -Section "complexroot" -Value $true -ConfigFile $testJson -MachineSpecific
            (Get-SimpleSetting -Name "enabled" -Section "complexroot" -ConfigFile $testJson -MachineSpecific) | Should -Be $true
        }

        It "sets a null value" {
            Set-SimpleSetting -Name "null" -Section "complexroot" -Value $null -ConfigFile $testJson -MachineSpecific
            (Get-SimpleSetting -Name "null" -Section "complexroot" -ConfigFile $testJson -MachineSpecific) | Should -Be $null
        }

        It "sets a supercomplex value" {
            Set-SimpleSetting -Name "supercomplex" -Section "complexroot" -Value ([PSCustomObject]@{x = 1; y = 2 }) -ConfigFile $testJson -MachineSpecific
            (Get-SimpleSetting -Name "supercomplex" -Section "complexroot" -ConfigFile $testJson -MachineSpecific).x | Should -Be 1
            (Get-SimpleSetting -Name "supercomplex" -Section "complexroot" -ConfigFile $testJson -MachineSpecific).y | Should -Be 2
        }

        It "gets a missing value return `$null" {
            (Get-SimpleSetting -Name "missingsetting" -ConfigFile $testJson -MachineSpecific) | Should -Be $null
        }

        It "gets a missing value return default value" {
            (Get-SimpleSetting -Name "missingsetting" -ConfigFile $testJson -DefaultValue "TEST" -MachineSpecific) | Should -Be "TEST"
        }

        It "deletes a normal property" {
            Set-SimpleSetting -Name "simplerootproperty" -Value "Hello" -ConfigFile $testJson -MachineSpecific
            Get-SimpleSetting -Name "simplerootproperty" -ConfigFile $testJson -DefaultValue "TEST" -MachineSpecific | Should -Be "Hello"
            Remove-SimpleSetting -Name "simplerootproperty" -ConfigFile $testJson -MachineSpecific
            Get-SimpleSetting -Name "simplerootproperty" -ConfigFile $testJson -DefaultValue "TEST" -MachineSpecific | Should -Be "TEST"
        }

        It "deletes a section property" {
            Set-SimpleSetting -Name "simplerootproperty" -Section "delsection" -Value "Hello" -ConfigFile $testJson -MachineSpecific
            Get-SimpleSetting -Name "simplerootproperty" -Section "delsection" -ConfigFile $testJson -DefaultValue "TEST" -MachineSpecific | Should -Be "Hello"
            Remove-SimpleSetting -Name "simplerootproperty" -Section "delsection" -ConfigFile $testJson -MachineSpecific
            Get-SimpleSetting -Name "simplerootproperty" -Section "delsection" -ConfigFile $testJson -DefaultValue "TEST" -MachineSpecific | Should -Be "TEST"
        }

        It "get a section" {
            Set-SimpleSetting -Name "valueone" -Section "sectiontest" -Value "one" -ConfigFile $testJson -MachineSpecific
            Set-SimpleSetting -Name "valuetwo" -Section "sectiontest" -Value 2 -ConfigFile $testJson -MachineSpecific
            $expectedValue = "{`"valueone`": `"one`",`"valuetwo`": 2}" | ConvertFrom-Json
            (Get-SimpleSetting -Section "sectiontest" -ConfigFile $testJson -MachineSpecific).valueone | Should -Be $expectedValue.valueone
            (Get-SimpleSetting -Section "sectiontest" -ConfigFile $testJson -MachineSpecific).valuetwo | Should -Be $expectedValue.valuetwo
        }

        It "sets a new nested value" {
            Set-SimpleSetting -Name "nestedparam" -Section "complexroot" -Value "NestedNew" -ConfigFile $testJson -MachineSpecific
            (Get-SimpleSetting -Name "nestedparam" -Section "complexroot" -ConfigFile $testJson -MachineSpecific) | Should -Be "NestedNew"
        }

        AfterAll {
            Write-Output (Get-Content $testJson | ConvertFrom-Json -Depth 10 | ConvertTo-Json -Depth 10)
        }
    }
}

Describe "Configuration file" {
    Context "When no enviroment variable is set" {
        BeforeEach {
            $env:SIMPLESETTINGS_CONFIG_FILE_TMP = $env:SIMPLESETTINGS_CONFIG_FILE
        }

        It "should create a file in the user profile folder on import with no env variable set" {
            $env:SIMPLESETTINGS_CONFIG_FILE = $null
            Remove-Module SimpleSettings -Force -ErrorAction SilentlyContinue
            Import-Module $PSScriptRoot\..\SimpleSettings.psm1 -Force
            Start-Sleep -Seconds 1
            $configFile = Get-SimpleSettingConfigurationFile
            $configFile | Should -Be "$env:USERPROFILE\scripts\systemconfiguration.json"
            Test-Path $configFile | Should -Be $true
        }

        It "should create a file on the custom path" {
            $env:SIMPLESETTINGS_CONFIG_FILE = "$PSScriptRoot\test-config-env.json"
            $configFile = Get-SimpleSettingConfigurationFile
            $configFile | Should -Be "$PSScriptRoot\test-config-env.json"
            Test-Path $configFile | Should -Be $true
            Remove-Item "$PSScriptRoot\test-config-env.json"
        }

        It "should create a file on the set path" {
            Set-SimpleSettingConfigurationFile -Path "$PSScriptRoot\test-config-set.json"
            $configFile = Get-SimpleSettingConfigurationFile
            $configFile | Should -Be "$PSScriptRoot\test-config-set.json"
            Test-Path $configFile | Should -Be $true
            Remove-Item "$PSScriptRoot\test-config-set.json"
        }

        AfterEach {
            $env:SIMPLESETTINGS_CONFIG_FILE = $env:SIMPLESETTINGS_CONFIG_FILE_TMP
            $env:SIMPLESETTINGS_CONFIG_FILE_TMP = $null
        }
    }
}

