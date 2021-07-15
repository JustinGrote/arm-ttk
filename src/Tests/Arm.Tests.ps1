Describe 'Arm Tests' {
    Context 'Legacy Format' {
        BeforeAll {
            <#
            Each test script has access to a set of well-known variables:
            * TemplateFullPath (The full path to the template file)
            * TemplateFileName (The name of the template file)
            * TemplateText (The template text)
            * TemplateObject (The template object)
            * FolderName (The name of the directory containing the template file)
            * FolderFiles (a hashtable of each file in the folder)
            * IsMainTemplate (a boolean indicating if the template file name is mainTemplate.json)
            * CreateUIDefintionFullPath (the full path to createUIDefintion.json)
            * CreateUIDefinitionText (the text of createUIDefintion.json)
            * CreateUIDefinitionObject ( the createUIDefintion object)
            * HasCreateUIDefintion (a boolean indicating if the directory includes createUIDefintion.json)
            * MainTemplateText (the text of the main template file)
            * MainTemplateObject (the main template file, converted from JSON)
            * MainTemplateResources (the resources and child resources of the main template)
            * MainTemplateParameters (a hashtable containing the parameters found in the main template)
            * MainTemplateVariables (a hashtable containing the variables found in the main template)
            * MainTemplateOutputs (a hashtable containing the outputs found in the main template)
            #>
            $SCRIPT:Mocks = Resolve-Path "$PSScriptRoot/../../Tests/Mocks"
            $SCRIPT:testParams = @{
                TemplateFullPath = $TemplatePath
                TemplateFileName = (Get-Item $TemplatePath).Name
                FolderName = (Split-Path $TemplatePath)
                TemplateText = Get-Content -Raw $TemplatePath
                AllAzureResources = Get-Content -Raw $Mocks/cache/AllAzureResources.cache.json
                #TODO: Fix this for nested templates
                IsMainTemplate = $true
            }
            $SCRIPT:testParams['FileName'] = $TemplatePath.Name
            $SCRIPT:testParams['TemplateObject'] = $SCRIPT:testParams.TemplateText  | ConvertFrom-Json -Depth 99
        }

        $armTests = Get-ChildItem "$PSScriptRoot/../ArmTests" | Foreach-Object {
            @{
                Name = $PSItem.BaseName -replace '.test$','' -replace '-',' '
                Path = $PSItem
            }
        }

        It '<Name>' {
            . $Path @testParams
        } -TestCases $armTests
    }
}