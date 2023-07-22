function ConvertFrom-AbrAcMediantDocList
{
  [CmdletBinding()]
  param (
    $item,
    $itemindex,
    $ini = $ini
  )
  Write-PscriboMessage -Plugin 'AcDocLst' -Message "Converting $item" -IsDebug

  try
  {
    $object = $ini[$item]

    if ($object.keys.where({ $_ -notlike 'Comment*' }).count -eq 0)
    {
      throw "Skipping Empty $item"
    }

    try
    {
      $result = New-Object $item
      Write-PscriboMessage -Plugin 'AcDocLst' -Message "class $item" -IsDebug
    }
    catch
    {
      $result = New-Object -TypeName PSCustomObject
      if ($itemindex) {
          foreach ($i in $itemindex) {
             $result | Add-Member -MemberType NoteProperty -Name $i -Value $null -Force
             Write-PscriboMessage -Plugin 'AcDocLst' -Message "Adding member $i" -IsDebug
          }
      }
      $result.pstypenames.insert(0,"$item")
      Write-PscriboMessage -Plugin 'AcDocLst' -Message "PSCustomObject $item" -IsDebug
    }

    foreach ($o in ( $object.keys.where({ $_ -notlike 'Comment*' }) ) )
    {
        try
        {
            $result.$o = $object[$o]
        }
        catch
        {
            Write-PscriboMessage -Plugin 'AcDocLst' -Message "Parameter not documented ->  [$item]$o" -IsWarning
            $Script:MissingParameter = $true
            $result | Add-Member -MemberType NoteProperty -Name $o -Value $object[$o] -Force
        }
    }
    Update-TypeData -TypeName "$item" -MemberType Scriptmethod -MemberName 'view' -Value { $this } -Force
    Write-PscriboMessage -Plugin 'AcDocLst' -Message "Converted:  $item"  -IsDebug
    $result
  }
  catch
  {
    Write-PscriboMessage -Plugin 'AcDocLst' -Message "Skipping:   $item"  -IsWarning
  }
}