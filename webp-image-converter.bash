#!/bin/bash
#place this script in directory of images you want convert and run in DOS shell. (bash webp-image-converter.bash)
QUAL="-q 50" #quality factor (0:small..100:big), default=75
TRAN="-alpha_q 100" #transparency-compression quality (0..100), default=100
COMP="-m 6" #compression method (0=fast, 6=slowest), default=4
# convert the image using cwebp and output a file with the extension replaced as .webp
for file in *.{jpg,jpeg,png}; do cwebp.exe -short $QUAL $TRAN $COMP "$file" -o "${file%.*}.webp"; done