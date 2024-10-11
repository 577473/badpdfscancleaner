@echo off
setlocal enabledelayedexpansion
set filename="%~1"
echo mejorar scans...

echo procesando archivo: %filename%

::pdf 2 img
magick -density 150 %filename% pdfcleaner_out-%%02d.jpg 



::clean scans
set counter=0
for %%f in (pdfcleaner_out*.jpg) do (
  echo procesando %%f
  ::echo counter: !counter!
  if !counter! lss 10 (set counterS="0!counter!") else set counterS=!counter!
  ::echo counterS: !counterS!
  magick %%f -grayscale Rec709Luma -level 40%%,85%% ^( +clone -blur 0x20 ^) -compose Divide_src -composite pdfcleaner_final-!counterS!.jpg 
  set /a counter+=1
 )
  ::magick %%f -grayscale Rec709Luma -level 40%%,85%% ^( +clone -blur 0x20 ^) -compose Divide_src -composite final-%counter.jpg 
::)

::img 2 pdf
echo generando pdf
magick pdfcleaner_*.jpg mejorado_%filename%

::delete temp files
echo borrando archivos temporales
del pdfcleaner_*.jpg

echo ******** mejora terminada, archivo listo *********.