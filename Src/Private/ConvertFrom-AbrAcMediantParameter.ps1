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