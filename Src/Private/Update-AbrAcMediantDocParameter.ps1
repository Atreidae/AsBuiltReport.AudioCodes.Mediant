function Update-AbrAcMediantDocParameter {
    <#
    .SYNOPSIS
    Used by As Built Report to update an atribute in a stored INI configuration file into a human readable object
    Replaces Shanes update-mediantDocParameter function
    .DESCRIPTION

    .NOTES
        Version:        0.1.0
        Author:         James "UcMadScientist" Arber
        Twitter:        @UCMadScientist
        Github:         Atreidae
        Credits:        Shane Hoey (@ShaneHoey) - for his work on the Mediant PowerShell module, without which this would be impossible.
    #>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Scope='Function')] #We're updating a variable state PSScriptAnalyzer, not a file or registry key. Bugger off.
  Param (
    [Parameter(Position = 0, mandatory = $true)]
    [AllowEmptyString()]
    [string]$Parameter,
    [Parameter(Position = 1, mandatory = $false)]
    [AllowEmptyString()]
    [string]$DefaultValue = '',
    [Parameter(Position = 2, mandatory = $false)]
  [hashtable]$ParameterLookup)

  Write-Verbose -Message "Parameter->       $Parameter"
  Write-Verbose -Message "DefaultValue->    $DefaultValue"
  Write-Verbose -Message "ParameterLookup-> $ParameterLookup"

  if ($Parameter -eq '')
  {
    $Parameter = $DefaultValue
  }

  if ($PSBoundParameters.ContainsKey('ParameterLookup'))
  {
    if ($ParameterLookup.containskey($Parameter))
    {
      return $ParameterLookup[$Parameter]
    }
    else
    {
      return $Parameter
    }
  }
  else
  {
    return $Parameter
  }
}