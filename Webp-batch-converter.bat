@echo off

set tout=C:\Windows\System32\timeout.exe
rem set WEBP=C:\DosCommands\cwebp.exe
rem ***	quality factor (0:small..100:big), default=75	***
set QUAL=-q 75
rem ***	transparency-compression quality (0..100), default=100	***
set TRAN=-alpha_q 100
rem *** -preset <string> ....... preset setting, one of: default, photo, picture, drawing, icon, text *** preset will set up a default encoding configuration targeting a particular type of input. It should appear first in the list of options, so that subsequent options can take effect on top of this preset. Default value is 'default'.
set PRE=-preset photo
rem ***	compression method (0=fast, 6=slowest), default=4	***
set COMP=-m 6
rem *** -segments <int> Change the number of partitions to use during the segmentation of the sns algorithm. Segments should be in range 1 to 4. Default value is 4. This option has no effect for methods 3 and up, unless -low_memory is used.
set SEG=-segments 4
rem ***	-sns <int> , spatial noise shaping (0:off, 100:max), default=50	*** sns will progressively turn on (when going from 0 to 100) some additional visual optimizations (like: segmentation map re-enforcement). This option will balance the bit allocation differently. It tries to take bits from the "easy" parts of the picture and use them in the "difficult" ones instead. Usually, raising the sns value (at fixed -q value) leads to larger files, but with better quality. Typical value is around '75'. 
set SNS=-sns 100
rem *** -f <int> ............... filter strength (0=off..100), default=60 *** f option directly links to the filtering strength used by the codec's in-loop processing. The higher the value, the smoother the highly-compressed area will look. This is particularly useful when aiming at very small files. Typical values are around 20-30. Note that using the option -strong/-nostrong will change the type of filtering. Use "-f 0" to turn filtering off.
set FIL_STR=-f 75
rem *** -sharpness Range is 0 (sharpest) to 7 (least sharp). Default is 0
set SHARP=-sharpness 0
rem *** -partition_limit , Degrade quality by limiting the number of bits used by some macroblocks. Range is 0 (no degradation, the default) to 100 (full degradation). Useful values are usually around 30-70 for moderately large images. In the VP8 format, the so-called control partition has a limit of 512k and is used to store the following information: whether the macroblock is skipped, which segment it belongs to, whether it is coded as intra 4x4 or intra 16x16 mode, and finally the prediction modes to use for each of the sub-blocks. For a very large image, 512k only leaves room to few bits per 16x16 macroblock. The absolute minimum is 4 bits per macroblock. Skip, segment, and mode information can use up almost all these 4 bits (although the case is unlikely), which is problematic for very large images. The partition_limit factor controls how frequently the most bit-costly mode (intra 4x4) will be used. This is useful in case the 512k limit is reached and the following message is displayed: 
rem Error code 6 PARTITION0_OVERFLOW Partition #0 is too big to fit 512k. If using -partition_limit is not enough to meet the 512k constraint, one should use less segments in order to save more header bits per macroblock. See the -segments option.
set PAR_LIM=-partition_limit 30
rem ***	specifies the permissible quality (type of Resolution) range (default: 0 100)	***
set P_QUAL=-qrange 0 100
rem ***	crop <x> <y> <w> <h> .. crop picture with the given rectangle	***
set CROP=-crop 100 100 600 600
rem ***	resize <w> <h> ........ resize picture (*after* any cropping)	***
set RESIZE=-resize 360 360
rem -low_memory, Reduce memory usage of lossy encoding by saving four times the compressed size (typically). This will make the encoding slower and the output slightly different in size and distortion. This flag is only effective for methods 3 and up, and is off by default. Note that leaving this flag off will have some side effects on the bitstream: it forces certain bitstream features like number of partitions (forced to 1). Note that a more detailed report of bitstream size is printed by cwebp when using this option.
set LMEM=-low_memory
rem *** -alpha_method <int> Specify the algorithm used for alpha compression: 0 or 1. Algorithm 0 denotes no compression, 1 uses WebP lossless format for compression. The default is 1.
set AMETH=-alpha_method 1
rem ***	-alpha_filter <string> . predictive filtering for alpha plane, one of: none, fast(default) or best	***
set AFILT=-alpha_filter best
rem ***	Add any Word at the END of File Name if required	***
set EMBED=-Webp

setlocal enableDelayedExpansion

echo Converting FILENAME "%~nx1"

cwebp %PRE% %SNS% %FIL_STR% %COMP% %TRAN% %P_QUAL% %AFILT% %AMETH% -mt %LMEM% -exact %SEG% %PAR_LIM% -af %QUAL% -progress -short "%~f1" -o "%~dpn1%EMBED%.webp" && echo Saving "%~n1%EMBED%.webp" file in "%~dp1" directory

%tout% /t 5 /nobreak
