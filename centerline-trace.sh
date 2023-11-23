#!/bin/bash

# shell script wrapper to run the centerline-trace 
# inkscape extension as a standalone tool
#
# (c) 2016, juewei@fabmail.com

#set -euo

export CUR_DIR=$(dirname "$0")

# opts='--invert=False'
opts='--invert=False --candidates=15 --debug --remove True'
# opts='--invert=False --candidates=1 --debug --remove True'

# opts='--candidates=15'
# opts='--megapixels=2.0'
# opts='--megapixel=0.5 --invert=True --candidates=5'
# opts='--invert=True'

image=$1 
test -z "$image" && image=testdata/kringel.png
case "$image" in .*) ;; /*) ;; *) image=./$image;; esac
tmpsvg=/tmp/$$-centerline-trace-wrapper.svg

cat << EOF > $tmpsvg
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   width="210mm"
   height="297mm"
   viewBox="0 0 210 297">
  <g
     inkscape:label="Ebene 1"
     inkscape:groupmode="layer"
     id="layer1">
    <image
       sodipodi:absref="$image"
       xlink:href="$image"
       width="1456.2667"
       height="819.15002"
       preserveAspectRatio="none"
       id="image4421"
       x="-577.12152"
       y="-226.81631" />
  </g>
</svg>
EOF

python ${CUR_DIR}/centerline-trace.py $opts --id=image4421 $tmpsvg
#rm $tmpsvg
