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
        if ((Get-Item -Path WSMan:\localhost\Client\TrustedHosts).Value -ne "*") {
            Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value $IPAddress -Force -Concatenate
        } else {
            Write-Warning "All hosts (*) already enabled on WSMAN Trusted Hosts"
        }
    }
}

function Get-WSManTrustedHosts {
    Get-Item -Path WSMan:\localhost\Client\TrustedHosts
}

function Get-PropertyName {
    param (
        [Parameter(Mandatory,ValueFromPipeline)]$Object
    )
    process {
        $Object |
        Get-Member |
        Where MemberType -In "Property","NoteProperty" |
        Select-Object -ExpandProperty Name
    }
}

function Get-ModuleImportTimes {
    $Modules = Get-Module -ListAvailable
    $UserPSModulePath = Get-UserPSModulePath
    
    $UserModules = $Modules | 
    Where-Object ModuleBase -Match ([regex]::Escape($UserPSModulePath))

    $UserModules |
    Add-Member -MemberType ScriptProperty -Name ImportModuleDuration -force -Value {
        Measure-command { Import-Module -Force $This.Name }
    }
    $SortedByImportTimes = $UserModules | Sort-Object ImportModuleDuration
    $SortedByImportTimes | select -First 20 -Property Name, ImportModuleDuration    
}