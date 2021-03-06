﻿####------------------------------------------------------------------------####
#### Editor info: Geir Dybbugt - https://dybbugt.no
####------------------------------------------------------------------------####

<#
.SYNOPSIS
    Downloads and installs Citrix Receiver.
    Intended to run via Intune.
#>

# If Receiver is already installed, skip download and install
If (!(Get-WmiObject -Class Win32_Product | Where-Object Name -Like "Citrix Workspace*")) {

    # Cirix Receiver download source
    $Url = "https://downloadplugins.citrix.com/Windows/CitrixWorkspaceApp.exe"
    $Target = "$env:SystemRoot\Temp\CitrixWorkspaceApp.exe"

    # Delete the target if it exists, so that we don't have issues
    If (Test-Path $Target) { Remove-Item -Path $Target -Force -ErrorAction SilentlyContinue }

    # Download Citrix Receiver locally
    Start-BitsTransfer -Source $Url -Destination $Target

    # Install Citrix Receiver
    If (Test-Path $Target) { Start-Process -FilePath $Target -ArgumentList "/AutoUpdateCheck=auto /Allowaaddstore=A /AutoUpdateStream=Current /DeferUpdateCount=5 /AURolloutPriority=Medium /NoReboot /Silent EnableCEIP=False" -Wait }
}