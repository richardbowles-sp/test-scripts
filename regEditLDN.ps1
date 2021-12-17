$rootPath = "HKLM:"
$tigerRegPath = "HKLM:\SOFTWARE\Tiger Technology"
$fullRegPath = "HKLM:\SOFTWARE\Tiger Technology\tbox\client\settings"
$regKey = "masters"
$regKeyValue = '[{"ip-addresses": ["10.243.18.68"], "name": "10.243.18.68", "volumes": [{"guid": "3643AE0A000000000000000000000000", "preferred-mount-point": "M"}]}]'

Push-Location

$pathTest = Test-Path $tigerRegPath
function CreateRegKey {
    #Set-Location HKLM:
    Set-Location -Path "$fullRegPath"

    Get-Item -Path "$fullRegPath" | New-Item -Name "$regKey" -Force

    # Create new items with values
    New-ItemProperty -Path "$fullRegPath" -Name "$regKey" -Value "$regKeyValue" -PropertyType String -Force

    # Get out of the Registry
    Pop-Location
}

if ( $pathTest )
{
    Write-Output "The Restry path exists, proceeding to add key"
    CreateRegKey
}else {
    Write-Output "The Restry path does not exist, proceeding to create path"
    Set-Location -Path "$rootPath"
    New-Item -Path "$tigerRegPath"
    New-Item -Path "HKLM:\SOFTWARE\Tiger Technology\tbox"
    New-Item -Path "HKLM:\SOFTWARE\Tiger Technology\tbox\client"
    New-Item -Path "$fullRegPath"
    Write-Output "The Restry path has been created, proceeding to add key"
    CreateRegKey
}

