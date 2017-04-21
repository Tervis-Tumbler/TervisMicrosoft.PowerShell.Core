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