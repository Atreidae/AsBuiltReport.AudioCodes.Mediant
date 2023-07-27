 <#
    .SYNOPSIS
    Used by As Built Report to update a table in a stored INI configuration file into a human readable object
    Replaces Shanes ConvertFrom-MediantDocTable function
    .DESCRIPTION

    .NOTES
        Version:        0.1.0
        Author:         James "UcMadScientist" Arber
        Twitter:        @UCMadScientist
        Github:         Atreidae
        Credits:        Shane Hoey (@ShaneHoey) - for his work on the Mediant PowerShell module, without which this would be impossible.
    #>

function ConvertFrom-AbrAcMediantDocTable
{

    [CmdletBinding()]
    param (
        $item,
        $itemindex,
        $ini = $ini
        )

    Write-PscriboMessage -Plugin 'AcDocTbl' -Message "Converting $item"  -IsDebug

    try
    {
        $object = $ini[$item]
        if ($object -eq $null) { throw "Not Configured $item" }

        [array]$objectIndex = $object["FORMAT $($item)_Index"].trim().trimend(';').Split(',').trim()

        foreach ($o in ($object.keys.where( { $_ -like "$item*" })) )
        {
            try
            {
                $result = New-Object $item
                $result | Add-Member -membertype NoteProperty -Name ("$($item)_Index") -Value $o -Force
                Write-PscriboMessage -Plugin 'AcDocTbl' -Message "class $item" -IsDebug
            }
            catch
            {
                $result = New-Object -TypeName PSCustomObject
                $result | Add-Member -membertype NoteProperty -Name ("$($item)_Index") -Value $o -Force
                foreach ($i in $itemindex)
                {
                  $result | Add-Member -membertype NoteProperty -Name $i -Value ''
                }
                $result.pstypenames.insert(0,"$item")
                Write-PscriboMessage -Plugin 'AcDocTbl' -Message "psCustomObject $item" -IsDebug
            }

            for ($i = 0; $i -lt $objectIndex.Count; $i++)
            {
                try
                {
                    $result.($objectIndex[$i]) = $($object.$o.trim().trimend(';').Split(',')[$i].trim().trimstart([char]0x0022).trimend([char]0x0022))
                    Write-PscriboMessage -Plugin 'AcDocTbl' -Message "$($objectIndex[$i]) = $($result.($objectIndex[$i]))"  -IsDebug
                }
                catch
                {
                    Write-PscriboMessage -Plugin 'AcDocTbl' -Message "*** Parameter not documented ->  [$item]$($objectIndex[$i])"  -IsWarning
                    $Script:MissingParameter = $TRUE
                    $result | Add-Member -MemberType NoteProperty -Name ($objectIndex[$i]) -Value $($object.$o.trim().trimend(';').Split(',')[$i].trim().trimstart([char]0x0022).trimend([char]0x0022))
                    Write-PscriboMessage -Plugin 'AcDocTbl' -Message "$($objectIndex[$i]) = $($result.($objectIndex[$i]))" -IsDebug
                }
            }
        $result
    }
    Update-TypeData -TypeName "$item" -MemberType Scriptmethod -MemberName 'view' -Value { $this  } -Force
    Write-PscriboMessage -Plugin 'AcDocTbl' -Message "Converted:  $item"  -IsDebug
  }
  catch
  {
    Write-PscriboMessage -Plugin 'AcDocTbl' -Message "Skipping:   $item"  -IsWarning
  }

}