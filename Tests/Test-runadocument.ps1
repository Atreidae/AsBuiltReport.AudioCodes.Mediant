

remove-module 'AsBuiltReport.Audiocodes.Mediant'
Import-Module 'AsBuiltReport.Audiocodes.Mediant'

$VerbosePreference = 'Continue'

#new-AsBuiltReport -Report Microsoft.Teams -Target 'ccb889e6-dc8d-4fe4-b842-d8efb6094a75' -MFA -Format Html -OutputFolderPath 'C:\UcMadScientist\AsBuiltReport.Microsoft.Teams\reports' -Timestamp -AsBuiltConfigFilePath c:\users\atrei\asbuiltreport\asbuiltreport.json -ReportConfigFilePath C:\users\atrei\asbuiltreport\AsBuiltReport.Microsoft.Teams.json
new-AsBuiltReport -Report AudioCodes.Mediant -Target 'C:\UcMadScientist\AsBuiltReport.AudioCodes.Mediant\Tests\Res\M1000.ini' -Format Html -OutputFolderPath 'C:\UcMadScientist\AsBuiltReport.AudioCodes.Mediant\reports' -Timestamp -AsBuiltConfigFilePath c:\users\atrei\asbuiltreport\asbuiltreport.json -ReportConfigFilePath C:\users\atrei\asbuiltreport\AsBuiltReport.AudioCodes.Mediant.json -Credential "ini" -Verbose #BSL
$bug = $error[0]
