#Thanks to Adam the Automater for these wicked pipeline tools
#Check out https://adamtheautomator.com/powershell-devops/ for more info!
#Also check out his book "The Pester Book. It helped me write all these tests!

Describe 'Function tests' {
    It 'the functions import successfully' {
        {
            # Get public and private function definition files and dot source them
            $Public = @(Get-ChildItem -Path $PSScriptRoot\Src\Public\*.ps1 -ErrorAction SilentlyContinue)
            $Private = @(Get-ChildItem -Path $PSScriptRoot\Src\Private\*.ps1 -ErrorAction SilentlyContinue)

            foreach ($Module in @($Public + $Private)) {
                try {
                    . $Module.FullName
                } catch {
                    Write-Error -Message "Failed to import function $($Module.FullName): $_"
                }
            }
        } |  Should -not -throw
    }
}

Describe 'Convertfrom-AbrAcMediantConfigIni' {
    It ' imports the mediant 1000 Ini file' {
        {
            $MediantConfigINI = Get-Content (Get-Item -Path "$PSScriptRoot\Tests\Res\M1000.ini").fullname
            $MediantConfigINI = (Convertfrom-AbrAcMediantConfigIni -MediantConfigini $MediantConfigINI)
        } |  Should -not -throw
    }

    It 'The 1000 Ini import contains expected data' {

            $MediantConfigINI = Get-Content (Get-Item -Path "$PSScriptRoot\Tests\Res\M1000.ini").fullname
            $MediantConfigINI = (Convertfrom-AbrAcMediantConfigIni -MediantConfigini $MediantConfigINI)
            $MediantConfigINI.containskey('SYSTEMParams') | Should -Be $True
    }


    It 'The 1000 Ini import contains 97 entries' {
        $MediantConfigINI = Get-Content (Get-Item -Path "$PSScriptRoot\Tests\Res\M1000.ini").fullname
        $MediantConfigINI = (Convertfrom-AbrAcMediantConfigIni -MediantConfigini $MediantConfigINI)
        ($MediantConfigINI.count -eq 97) |  Should -Be $true
    }

    It ' imports the mediant MP124 Ini file' {
        {
            $MediantConfigINI = Get-Content (Get-Item -Path "$PSScriptRoot\Tests\Res\MP124.ini").fullname
            $MediantConfigINI = (Convertfrom-AbrAcMediantConfigIni -MediantConfigini $MediantConfigINI)
        } |  Should -not -throw
    }

    It 'The MP124 Ini import contains expected data' {
        $MediantConfigINI = Get-Content (Get-Item -Path "$PSScriptRoot\Tests\Res\MP124.ini").fullname
        $MediantConfigINI = (Convertfrom-AbrAcMediantConfigIni -MediantConfigini $MediantConfigINI)
        {($MediantConfigINI.trunkgroup.count -eq 25)} | Should -Be $true
    }

    It 'The MP124 Ini import contains 38 entries' {
        $MediantConfigINI = Get-Content (Get-Item -Path "$PSScriptRoot\Tests\Res\MP124.ini").fullname
        $MediantConfigINI = (Convertfrom-AbrAcMediantConfigIni -MediantConfigini $MediantConfigINI)
         {($MediantConfigINI.count -eq 38)} |  Should -Be $true
        }

}

Describe 'Import-AbrAcMediantDefaultParameter' {
    It ' runs without error' { {Import-AbrAcMediantDefaultParameter} | Should -not -throw }
    It ' imports the variables' { Import-AbrAcMediantDefaultParameter ; ($DefaultTerminalWindowHeight.count -eq 2) |  Should -be $true }
}

Describe 'Module-level tests' {

    It 'the module imports successfully' {
        { Import-Module -name "$PSScriptRoot\AsBuiltReport.AudioCodes.Mediant.psm1" -ErrorAction Stop } | Should -not -throw
    }

    It 'the module has an associated manifest' {
        Test-Path "$PSScriptRoot\AsBuiltReport.AudioCodes.Mediant.psd1" | Should -Be $true
    }

    It 'passes all default PSScriptAnalyzer rules' {
        Invoke-ScriptAnalyzer -Path "$PSScriptRoot\AsBuiltReport.AudioCodes.Mediant.psm1" | Should -BeNullOrEmpty
    }

}

