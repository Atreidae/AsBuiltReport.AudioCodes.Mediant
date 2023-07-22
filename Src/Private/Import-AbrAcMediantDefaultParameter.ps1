function Import-AbrAcMediantDefaultParameter
{
    <#
    .SYNOPSIS
    Imports the default parameters for the AudioCodes Mediant
    .DESCRIPTION

    .NOTES
        Version:        0.1.0
        Author:         James "UcMadScientist" Arber
        Twitter:        @UCMadScientist
        Github:         Atreidae
        Credits:        Shane Hoey (@ShaneHoey) - for his work on the Mediant PowerShell module, without which this would be impossible.
    #>
    $Script:DisableEnable = @{'0' = 'Disable'; '1' = 'Enable' }
    $Script:EnableDisable = @{'0' = 'Enable'; '1' = 'Disable' }
    $Script:YesNo = @{'0' = 'Yes'; '1' = 'No' }
    $Script:NoYes = @{'0' = 'No'; '1' = 'Yes' }

    $Script:3xxBehavior = @{'0' = 'Forward'; '1' = 'Redirect' }
    $Script:AuthenticationMode = @{ '0' = 'Per Endpoint'; '1' = 'Per Gateway'; '3' = 'Per FXS'; }
    $Script:CDRReportLevel = @{ '0' = 'None'; '1' = 'End Call'; '2' = 'Start End Call'; '3' = 'Connect & End Call'; '4' = 'Start & End & Connect Call' }
    $Script:DeviceTable_Tagging = @{ '0' = 'Untagged'; '1' = 'Tagged'; }
    $Script:DNSQueryType = @{ '0' = 'A-Record'; '1' = 'SRV'; '2' = 'NAPTR' }
    $Script:EnablePtime = @{'0' = "Remove 'ptime'"; '1' = "include 'ptime'" }
    $Script:EtherGroupTable_Mode = @{ '0' = 'None'; '1' = 'Single'; '2' = '2RX/1TX'; '3' = '2RX/2TX' }
    $Script:FaxVBDBehavior = @{'0' = 'VBD Coder'; '1' = 'IsFaxUsed' }
    $Script:InterfaceTable_ApplicationTypes = @{ '0' = 'OAMP'; '1' = 'Media'; '2' = 'Control'; '3' = 'OAMP + Media'; '4' = 'OAMP + Control'; '5' = 'Media + Control'; '6' = 'OAMP + Media + Control' }
    $Script:InterfaceTable_InterfaceMode = @{'3' = 'IPv6 Manual Prefix'; '4' = 'IPv6 Manual'; '10' = 'IPv4 Manual' }
    $Script:IsCiscoSCEMode = @{'0' = 'No Cisco Gatway'; '1' = 'CiscoGateway' }
    $Script:MediaCDRReportLevel = @{'0' = 'None'; '1' = 'End Media'; '2' = 'Start & End Media'; '3' = 'Update & End Media'; '4' = 'Start & End & Update Media' }
    $Script:MultiPtimeFormat = @{'0' = 'None'; '1' = 'PacketCable' }
    $Script:PhysicalPortsTable_SpeedDuplex = @{ '0' = '10BaseT Half Duplex'; '1' = '10BaseT Full Duplex'; '2' = '100BaseT Half Duplex'; '3' = '100BaseT Full Duplex'; '4' = 'Auto Negotiation (default)'; '6' = '1000BaseT Half Duplex'; '7' = '1000BaseT Full Duplex'; }
    $Script:PrackMode = @{ '0' = 'Disable'; '1' = 'Supported '; '2' = 'Required'; }
    $Script:ProxyDNSQueryType = @{ '0' = 'A-Record'; '1' = 'SRV'; '2' = 'NAPTR' }
    $Script:ProxyRedundancyMode = @{ '0' = 'Parking'; '1' = 'Homing' }
    $Script:RegistrarTransportType = @{ '-1' = 'Not Configured'; '0' = 'UDP'; '1' = 'TCP'; '2' = 'TLS' }
    $Script:ReleaseIP2ISDNCallOnProgressWithCause = @{ '0' = 'Default'; '1' = 'SIP 4xx EarlyMedia'; '2' = 'Always SIP 4xx'; }
    $Script:RemoveToTagInFailureResponse = @{ '0' = 'Do not remove tag'; '1' = 'Remove tag'; }
    $Script:SelectSourceHeaderForCalledNumber = @{ '0' = 'Request-URI-Header'; '1' = 'To Header'; '2' = 'P-Called-Party-ID' }
    $Script:SessionExpiresMethod = @{ '0' = 'Re-Invite'; '1' = 'Update'; }
    $Script:SIP183Behaviour = @{ '0' = 'Progress'; '1' = 'Alert '; }
    $Script:SIPChallengeCachingMode = @{ '0' = 'None'; '1' = 'Invite Only'; '2' = 'Full' }
    $Script:SIPReroutingMode = @{ '0' = 'Standard'; '1' = 'Proxy'; '2' = 'Routing Table' }
    $Script:SIPTransportType = @{'0' = 'UDP(Default)'; '1' = 'TCP'; '2' = 'TLS (SIPS)' }
    $Script:TelnetServerEnable = @{'0' = 'Disable'; '1' = 'Enable Unsecured'; '2' = 'Enable Secured' }
    $Script:TGRProutingPrecedence = @{'0' = 'IP to Tel Routing Table'; '1' = 'tgrp' }
    $Script:TLSContexts_DHKeySize = @{ '1024' = '1024'; '2048' = '2048' }
    $Script:TLSContexts_OcspDefaultResponse = @{ '0' = 'Reject'; '1' = 'Allow' }
    $Script:TLSContexts_TLSVersion = @{ '0' = 'Any - Including SSLv3 '; '1' = 'TLSv1.0'; '2' = 'TLSv1.1'; '3' = 'TLSv1.0 + TLSv1.1'; '4' = 'TLSv1.2'; '5' = 'TLSv1.0 + TLSv1.2'; '6' = 'TLSv1.1 + TLSv1.2'; '7' = 'TLSv1.0 +TLSv1.1 +TLSv1.2' }
    $Script:TrunkStatusReportingMode = @{ '0' = 'Disable'; '1' = "Don't reply OPTIONS"; '2' = "Don’t send Keep-Alive"; "3" = "Don’t Reply and Send"; }
    $Script:UseGatewayNameForOptions = @{ '0' = 'No'; '1' = 'Yes'; "2" = "Server" }
    $Script:UseSIPTgrp = @{"0" = "Disable"; '1' = 'Send Only'; '2' = 'Send and Recieve'; "3" = "Hotline"; "4" = "Hotline Extended" }
    $Script:WebUsers_Status = @{"0" = 'New'; '1' = 'Valid'; '2' = "Failed Login"; "3" = "Inactivity" }
    $Script:WebUsers_UserLevel = @{"50" = 'Monitor'; '100' = 'Administrator'; '200' = "Security Administrator"; "220" = "Master" }
    $Script:GwDebugLevel = @{'0' = 'No Debug'; '1' = 'Basic'; "5" = "Detailed " }
    $Script:SyslogFacility = @{"16" = "Local0"; "17" = 'Local1'; '18' = 'Local2'; '19' = "Local3"; "20" = "Local4"; "21" = "Local5"; "22" = "Local6"; "23" = "Local7" }
    $Script:CallDurationUnits = @{"0" = 'Seconds'; '1' = 'Deciseconds'; '2' = "Centiseconds"; "3" = "Milliseconds" }
    $Script:TelnetServerEnable = @{'0' = 'Disable'; '1' = 'Enable Unsecured'; "2" = "Enable Secured" }
    $Script:DefaultTerminalWindowHeight = @{'-1' = 'CLI Window Height'; '0' = 'Window'; }
}