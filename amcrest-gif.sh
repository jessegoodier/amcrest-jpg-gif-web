#! /bin/bash

# nginx -g 'daemon off;' &
while true; do
    x=1
    echo "Creating image gif at $(date)" >/dev/stdout
    magick -delay 50 -loop 0 "$(pwd)/image_*.jpg" $(pwd)/image_animated-new.gif
    magick $(pwd)/image_animated-new.gif -coalesce -scale 1500 -layers Optimize +remap $(pwd)/image_animated-new.gif
    mv $(pwd)/image_animated-new.gif $(pwd)/image.gif
    echo "image gif updated at $(date)" >/dev/stdout
    while [ $x -le 20 ]; do
        # sleep 1
        /usr/bin/wget -q 'http://admin:admin@10.0.0.175/cgi-bin/snapshot.cgi' -O $(pwd)/image-original.jpg
        echo "image image $x updated at $(date)" >/dev/stdout
        magick $(pwd)/image-original.jpg \
            -fill white -undercolor '#00000080' \
            -gravity southwest -pointsize 96 \
            -annotate +10+10 "$(TZ='America/New_York' date '+%Y-%m-%d %I:%M:%S %p ET')" \
            -quiet \
            $(pwd)/image_$x.jpg 2>/dev/null
        x=$((x+1))
    done
done