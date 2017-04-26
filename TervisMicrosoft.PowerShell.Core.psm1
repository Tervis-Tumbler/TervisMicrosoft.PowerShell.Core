function Get-HistoryCommandTotalExecutionTime {
    param (
        [Parameter(ValueFromPipeline)]$Command
    )

    $Command.EndExecutionTime - $Command.StartExecutionTime
}

function Get-ModulePath {
    param (
        [Parameter(Mandatory)]$Name
    )
    (Get-Module -ListAvailable $Name).ModuleBase
}

function Set-LocationModulePath {
    param (
        [Parameter(Mandatory)]$Name
    )
    Set-Location -Path (Get-ModulePath -Name $Name)
}

function Add-IPAddressToWSManTrustedHosts {
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipelineByPropertyName)][string]$IPAddress
    )
    process {
        Write-Verbose "Adding $IPAddress to WSMan Trusted Hosts"
        Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value $IPAddress -Force
    }
}

function Get-WSManTrustedHosts {
    Get-Item -Path WSMan:\localhost\Client\TrustedHosts
}