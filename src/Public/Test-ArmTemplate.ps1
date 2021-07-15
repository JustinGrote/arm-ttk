function Test-ArmTemplate {
    param(
        [Parameter(Mandatory)][String]$TemplatePath,
        [String]$ParametersPath
    )

    $container = New-PesterContainer -Path $PSScriptRoot/../Tests -Data @{
        TemplatePath = $TemplatePath
        ParametersPath = $ParametersPath
    }

    Invoke-Pester -Container $container -Output Detailed
}