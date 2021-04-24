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
      Remove-SimpleSetting -Name "simplerootproperty" -ConfigFile $testJson
      Get-SimpleSetting -Name "simplerootproperty" -ConfigFile $testJson -DefaultValue "TEST" | Should -Be "TEST"

    }

    It "deletes a section property" {
      Set-SimpleSetting -Name "simplerootproperty" -Section "delsection" -Value "Hello" -ConfigFile $testJson
      Get-SimpleSetting -Name "simplerootproperty" -Section "delsection" -ConfigFile $testJson -DefaultValue "TEST" | Should -Be "Hello"
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
      Write-Host (Get-Content $testJson | ConvertFrom-Json -Depth 10 | ConvertTo-Json -Depth 10)
    }
  }
}

