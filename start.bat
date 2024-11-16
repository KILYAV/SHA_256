C:\masm\64\ml64.exe /c /Cp KILYAV_SHA.asm
::C:\masm\64\link.exe /SUBSYSTEM:WINDOWS /entry:Debug /debug KILYAV_SHA.obj
C:\masm\64\lib.exe KILYAV_SHA.obj
C:\masm\64\dumpbin.exe /all KILYAV_SHA.lib

::C:\x64dbg\release\x64\x64dbg.exe "C:\Users\ILYA\source\repos\sha_256\KILYAV_SHA.exe"

pause