@echo off

SET identifyprog="C:\ImageMagick-7.0.8-46-portable-Q16-x64\identify"
SET magickprog="C:\ImageMagick-7.0.8-46-portable-Q16-x64\magick"

SET imagepath="dir /B /S C:\Orig\*.jpg"

set SEARCHTEXT=Orig
set REPLACETEXT=Conv

for /F "delims=" %%I in ('%imagepath%') do call :process "%%I"
goto :eof

:process
%identifyprog% -verbose %1 | find /c /i "Colorspace: sRGB" > temp.txt
set /p count=<temp.txt
del temp.txt
if %count%==1 (
SET "outpath=%~dp1"
setlocal EnableDelayedExpansion
SET modified=!outpath:%SEARCHTEXT%=%REPLACETEXT%!
mkdir !modified!
"%magickprog%" -verbose %1 -profile eciRGB_v2.icc -profile eciCMYK.icc !modified!%~n1.jpg!
)
goto :eof
