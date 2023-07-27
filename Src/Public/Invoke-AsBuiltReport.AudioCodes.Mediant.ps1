function Invoke-AsBuiltReport.AudioCodes.Mediant {
    <#
    .SYNOPSIS
        PowerShell script to document the configuration of AudioCodes Mediant in Word/HTML/Text formats
    .DESCRIPTION
        Documents the configuration of AudioCodes Mediant in Word/HTML/Text formats using PScribo.
    .NOTES
        Version:        0.1.0
        Author:         James Arber
        Twitter:
        Github:
        Credits:        Iain Brighton (@iainbrighton) - PScribo module
                        Shane Hoey (@ShaneHoey) - for his work on the Mediant PowerShell module, without which this would be impossible.

    .LINK
        https://github.com/AsBuiltReport/AsBuiltReport.AudioCodes.Mediant
    #>

    # Do not remove or add to these parameters
    param (
        [String[]] $Target,
        [PSCredential] $Credential
    )

    Write-PScriboMessage -Plugin 'Module' -Message 'Please refer to the AsBuiltReport.AudioCodes.Mediant GitHub website for more detailed information about this project.'
    Write-PScriboMessage -Plugin 'Module' -Message 'Do not forget to update your report configuration file after each new version release: https://www.asbuiltreport.com/user-guide/new-asbuiltreportconfig/'
    Write-PScriboMessage -Plugin 'Module' -Message 'Documentation: https://github.com/AsBuiltReport/AsBuiltReport.AudioCodes.Mediant'
    Write-PScriboMessage -Plugin 'Module' -Message 'Issues or bug reporting: https://github.com/AsBuiltReport/AsBuiltReport.AudioCodes.Mediant/issues'

    # Check the current AsBuiltReport.AudioCodes.Mediant module
    $InstalledVersion = Get-Module -ListAvailable -Name AsBuiltReport.AudioCodes.Mediant -ErrorAction SilentlyContinue | Sort-Object -Property Version -Descending | Select-Object -First 1 -ExpandProperty Version

    if ($InstalledVersion) {
        Write-PScriboMessage -Plugin 'Module' -Message "AsBuiltReport.AudioCodes.Mediant $($InstalledVersion.ToString()) is currently installed."
        $LatestVersion = Find-Module -Name AsBuiltReport.AudioCodes.Mediant -Repository PSGallery -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Version
        if ($LatestVersion -gt $InstalledVersion) {
            Write-PScriboMessage -Plugin 'Module' -Message "AsBuiltReport.AudioCodes.Mediant $($LatestVersion.ToString()) is available."
            Write-PScriboMessage -Plugin 'Module' -Message "Run 'Update-Module -Name AsBuiltReport.AudioCodes.Mediant -Force' to install the latest version."
        }
    }

    # Import Report Configuration
    $Report = $ReportConfig.Report
    $InfoLevel = $ReportConfig.InfoLevel
    $Options = $ReportConfig.Options

    # Used to set values to TitleCase where required
    $TextInfo = (Get-Culture).TextInfo

    # Import Language File
    #todo test this works.
    $Script:MediantDocText = ((Get-Content "$PSScriptRoot\..\..\Res\AudioCodes.Mediant.$($Options.language)").content -split '\n') | ConvertFrom-Json

    # Import Custom Classes
    Import-AbrAMeClasses

    # Import Handy Variables
    Import-AbrAcMediantDefaultParameter
    Import-AbrAcMediantParameterIndex

    #region foreach loop
    foreach ($Mediant in $Target) {
        #region input checks
        #First we need to figure out if the target is an Ini file (Config backup) or a live device
        if ($Mediant -like '*.ini') {
            If (Test-Path $Mediant) {
                $ConfigFile = $Mediant
                $LiveDevice = $False
            } else {
                Write-PScriboMessage -Plugin 'Mediant' -Message "Unable to open target INI file $mediant, skipping" -IsWarning
                Continue
            }

        } elseif ($Mediant -like 'http*') {
            throw 'Not implemented yet' #todo
            Try {
                Invoke-WebRequest -Uri $Mediant -Method Get -DisableKeepAlive -TimeoutSec 2 -ErrorAction Stop
                $LiveDevice = $Mediant
                $ConfigFile = $false
            } catch {
                Write-PScriboMessage -Plugin 'Mediant' -Message "Unable to open target SBC $mediant, skipping" -IsWarning
                Continue
            }

        } Else {
            Write-PScriboMessage -Plugin 'Mediant' -Message "Cannot determine if $mediant, is a config file or live device. Skipping" -IsWarning
            Continue
        }
        #endregion input checks

        #region ini to objects
        #We have an ini lets go!
        $MediantConfigini = Get-Content -Path $Mediant

        #Process ini into sections
        $ini = convertfrom-MediantDocConfigIni -MediantConfigini ($MediantConfigini).replace('[ ', '[').replace(' ]', ']')
        Remove-Item MediantConfigini -ErrorAction SilentlyContinue

        #Convert INI into custom objects
        foreach ($item  in $ini.keys) {
            switch ($item) {
                { $item -eq 'Mediant' } { Set-Variable -Name $item -Value ( ConvertFrom-AbrAcMediantParameter ) }
                { $ini[$item].ContainsKey("FORMAT $($item)_Index") } { Set-Variable -Name $item -Value ( ConvertFrom-AbrAcMediantDocTable -item $item -itemindex (Get-Variable -Name "itemindex_$($item)" -ErrorAction silentlycontinue -Verbose ).value ) }
                Default { Set-Variable -Name $item -Value (ConvertFrom-AbrAcMediantDocList -item $item -itemindex (Get-Variable -Name "itemindex_$($item)" -ErrorAction silentlycontinue -Verbose).value ) }
            }
        }

        #todo better handling here
        if ($missingparameter) {
            Write-Warning '*****************************'
            Write-Warning 'Missing Parameters Found'
            Write-Warning '*****************************'
            Write-Warning 'Please help improve this script by logging an issue on github.com/shanehoey/mediantdoc for the above missing parameters'
            Start-Sleep -Seconds 5

        }
        #endregion ini to objects

        #region report
        Section -Style Heading1 "Basic Appliance Information" {
            Get-AbrCsTenant
        }
        PageBreak





        #endregion report




    }
    #endregion foreach loop
}
