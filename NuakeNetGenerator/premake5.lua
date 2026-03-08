include "../Nuake/Thirdparty/Coral/Premake/CSExtensions.lua"

project "NuakeNetGenerator"
    language "C#"
    dotnetframework "net8.0"
    kind "ConsoleApp"
	    clr "Unsafe"
	
    targetdir (binaryOutputDir)
    objdir (intBinaryOutputDir)
    debugdir (binaryOutputDir)

    -- Don't specify architecture here. (see https://github.com/premake/premake-core/issues/1758)
     propertytags {
         "AppendTargetFrameworkToOutputPath", "false",
         "Nullable", "enable",
         "CopyLocalLockFileAssemblies", "true",
         "EnableDynamicLoading", "true"
     }

    files 
    {
        "Source/**.cs"
    }
