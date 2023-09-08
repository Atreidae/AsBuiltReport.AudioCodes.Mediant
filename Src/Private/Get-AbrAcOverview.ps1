<#
    .SYNOPSIS
    Used by As Built Report import the all the objects required for the Overview section
    Replaces Shanes /files/overview.ps1
    .DESCRIPTION

    .NOTES
        Version:        0.1.0
        Author:         James "UcMadScientist" Arber
        Twitter:        @UCMadScientist
        Github:         Atreidae
        Credits:        Shane Hoey (@ShaneHoey) - for his work on the Mediant PowerShell module, without which this would be impossible.
    #>

function Get-AbrAcOverview {
    $heading = 'Mediant Overview'
    $text = $Script:MediantDocText."text$($heading.replace(' ','').replace('&','').replace('/',''))"
    Section -Style Heading2 $heading {
    Paragraph $text
    }

    $heading = 'Device Details'
    Section -Style Heading2 $heading {
    Paragraph $Script:mediantDocText."text$($heading.replace(' ','').replace('&','').replace('/',''))"

    $TableParams = @{
        Name = 'Mediant Key Features'
        List = $false
    }
    if ($Report.ShowTableCaptions) {
        $TableParams['Caption'] = "- $($TableParams.Name)"
    }
    $script:Mediant.viewDoc() | Table @TableParams
    }

    $heading = 'Key Features'
    Section -Style Heading2 $heading {
    Paragraph = ($Mediant.viewKeyfeatures().where({ $_ -notmatch '^$' }) | Out-String)
    }
}
