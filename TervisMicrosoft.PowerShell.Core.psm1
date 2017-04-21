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