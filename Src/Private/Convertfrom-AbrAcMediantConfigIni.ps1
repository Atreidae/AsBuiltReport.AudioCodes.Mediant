function Convertfrom-AbrAcMediantConfigIni {
    <#
    .SYNOPSIS
    Used by As Built Report to convert an AudioCodes Mediant configuration file into a PowerShell object.
    .DESCRIPTION

    .NOTES
        Version:        0.1.0
        Author:         James "UcMadScientist" Arber
        Twitter:        @UCMadScientist
        Github:         Atreidae
        Credits:        Shane Hoey (@ShaneHoey) - for his work on the Mediant PowerShell module, without which this would be impossible.
    #>
    param ( $MediantConfigini )

    #Credit Oliver Lipkau
    #https://blogs.technet.microsoft.com/heyscriptingguy/2011/08/20/use-powershell-to-work-with-any-ini-file/

    $ini = @{}
    $section = 'Mediant'
    $ini[$section] = @{}

    switch -regex ($MediantConfigini) {
        '^(;.*)' {
            #Comment
            Write-PscriboMessage -Plugin 'AcIniImp' -Message "COMMENT -> $_" -IsDebug
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = 'Comment' + $CommentCount
            $ini[$section][$name] = $value
            continue
        }
        '^\[([^\\].+)\]' {
            #Section
            Write-PscriboMessage -Plugin 'AcIniImp' -Message "Imported:   $($matches[1].Replace(' ',''))"
            Write-PscriboMessage -Plugin 'AcIniImp' -Message "SECTION -> $_" -IsDebug
            $section = $matches[1].Replace(' ', '')
            $ini[$section] = @{}
            $CommentCount = 0
            continue
        }
        '^(.+?)\s*=(.*)' {
            #Key
            Write-PscriboMessage -Plugin 'AcIniImp' -Message "KEY    -> $_" -IsDebug
            $name, $value = $matches[1..2]
            $ini[$section][$name] = $value
            continue
        }
        default {
            Write-PscriboMessage -Plugin 'AcIniImp' -Message "Ignore -> $_" -IsDebug
        }
    }
    return $ini
}