gci $PSScriptRoot/Private | foreach {
    . $PSItem
}

gci $PSScriptRoot/Public | foreach {
    . $PSItem
    export-ModuleMember $PSItem.BaseName
}