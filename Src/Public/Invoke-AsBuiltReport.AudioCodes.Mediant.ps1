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

    Write-PScriboMessage -Plugin "Module" -Message "Please refer to the AsBuiltReport.AudioCodes.Mediant GitHub website for more detailed information about this project."
    Write-PScriboMessage -Plugin "Module" -Message "Do not forget to update your report configuration file after each new version release: https://www.asbuiltreport.com/user-guide/new-asbuiltreportconfig/"
    Write-PScriboMessage -Plugin "Module" -Message "Documentation: https://github.com/AsBuiltReport/AsBuiltReport.AudioCodes.Mediant"
    Write-PScriboMessage -Plugin "Module" -Message "Issues or bug reporting: https://github.com/AsBuiltReport/AsBuiltReport.AudioCodes.Mediant/issues"

    # Check the current AsBuiltReport.AudioCodes.Mediant module
    $InstalledVersion = Get-Module -ListAvailable -Name AsBuiltReport.AudioCodes.Mediant -ErrorAction SilentlyContinue | Sort-Object -Property Version -Descending | Select-Object -First 1 -ExpandProperty Version

    if ($InstalledVersion) {
        Write-PScriboMessage -Plugin "Module" -Message "AsBuiltReport.AudioCodes.Mediant $($InstalledVersion.ToString()) is currently installed."
        $LatestVersion = Find-Module -Name AsBuiltReport.AudioCodes.Mediant -Repository PSGallery -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Version
        if ($LatestVersion -gt $InstalledVersion) {
            Write-PScriboMessage -Plugin "Module" -Message "AsBuiltReport.AudioCodes.Mediant $($LatestVersion.ToString()) is available."
            Write-PScriboMessage -Plugin "Module" -Message "Run 'Update-Module -Name AsBuiltReport.AudioCodes.Mediant -Force' to install the latest version."
        }
    }

    # Import Report Configuration
    $Report = $ReportConfig.Report
    $InfoLevel = $ReportConfig.InfoLevel
    $Options = $ReportConfig.Options

    # Used to set values to TitleCase where required
    $TextInfo = (Get-Culture).TextInfo

# Setup TLS exclsuions
add-type @"
de    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
    [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy


    #region foreach loop
    foreach ($Mediant in $Target) {
    #region input checks
        #First we need to figure out if the target is an Ini file (Config backup) or a live device
        if ($Mediant -like "*.ini")
        {
            If (Test-Path $Mediant)
            {
                $ConfigFile = $Mediant
                $LiveDevice = $False
            } else {
                Write-PScriboMessage -Plugin "Mediant" -Message "Unable to open target INI file $mediant, skipping" -IsWarning
                Continue
            }

        }
        elseif ($Mediant -like "http*")
        {
            Try
            {
                Invoke-WebRequest -Uri $Mediant -Method Get -DisableKeepAlive -TimeoutSec 2 -ErrorAction Stop
                $LiveDevice = $Mediant
                $ConfigFile = $false
            }
            catch {
                Write-PScriboMessage -Plugin "Mediant" -Message "Unable to open target SBC $mediant, skipping" -IsWarning
                Continue
            }

        }
        Else
        {
            Write-PScriboMessage -Plugin "Mediant" -Message "Cannot determine if $mediant, is a config file or live device. Skipping" -IsWarning
            Continue
        }
    #endregion input checks



	}
	#endregion foreach loop
}
