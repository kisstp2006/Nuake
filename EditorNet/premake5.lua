include "../Nuake/Thirdparty/Coral/Premake/CSExtensions.lua"

project "EditorNet"
    language "C#"
    dotnetframework "net8.0"
    kind "SharedLib"
	    clr "Unsafe"
	
    -- Don't specify architecture here. (see https://github.com/premake/premake-core/issues/1758)

    targetdir (binaryOutputDir)
    objdir (intBinaryOutputDir)
    debugdir (binaryOutputDir)

    propertytags {
        "AppendTargetFrameworkToOutputPath", "false",
        "Nullable", "enable",
        "CopyLocalLockFileAssemblies", "true",
        "EnableDynamicLoading", "true",
        "IntermediateOutputPath", intBinaryOutputDir
    }

    files 
    {
        "Source/**.cs"
    }
    
	links 
    {
        "Coral.Managed",
        "NuakeNet"
    }
