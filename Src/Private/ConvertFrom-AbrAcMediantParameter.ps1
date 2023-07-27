 <#
    .SYNOPSIS
    Used by As Built Report to convert the parameter section of AudioCodes Mediant configuration file into a human readable object
    Replaces ConvertFrom-MediantDocMediantParameter
    .DESCRIPTION

    .NOTES
        Version:        0.1.0
        Author:         James "UcMadScientist" Arber
        Twitter:        @UCMadScientist
        Github:         Atreidae
        Credits:        Shane Hoey (@ShaneHoey) - for his work on the Mediant PowerShell module, without which this would be impossible.
    #>

function ConvertFrom-AbrAcMediantParameter {
    $item = 'Mediant'
    $result = New-Object $item

    Switch -regex ($ini[$item].Values)
    {
      '^;Board: (.*)$' { $result | Add-Member -Name 'Mediant_Board' -Value $matches[1] -MemberType NoteProperty -Force }
      '^;Board Type: (.*)$' { $result | Add-Member -Name 'Mediant_BoardType' -Value $matches[1] -MemberType NoteProperty -Force }
      '^;;;Key features:(.*)$'  { $result | Add-Member -Name 'Mediant_KeyFeatures' -Value $matches[1].split(';') -MemberType NoteProperty -Force }
      '^;Serial Number: (.*)$'  { $result | Add-Member -Name 'Mediant_SerialNumber' -Value $matches[1] -MemberType NoteProperty -Force }
      '^;Software Version: (.*)$' { $result | Add-Member -Name 'Mediant_SoftwareVersion' -Value $matches[1] -MemberType NoteProperty -Force }
      '^;DSP Software Version: (.*)$' { $result | Add-Member -Name 'Mediant_DSPSoftwareVersion' -Value $matches[1] -MemberType NoteProperty -Force  }
    }
    return $result
}