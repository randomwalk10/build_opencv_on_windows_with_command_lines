msbuild print_build_info.vcxproj /maxcpucount /p:configuration=release /p:platform=x64 /p:optimization=maxspeed /t:rebuild
xcopy /Y ".\x64\release\print_build_info.exe" .\print_build_info.exe*
