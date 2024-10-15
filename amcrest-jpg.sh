#! /bin/bash

/usr/bin/wget -q 'http://admin:admin@10.0.0.175/cgi-bin/snapshot.cgi?1' -O /home/ubuntu/cronjobs/image-original.jpg
echo "image image updated at $(date)" >/home/ubuntu/cronjobs/image.log
/home/linuxbrew/.linuxbrew/bin/magick /home/ubuntu/cronjobs/image-original.jpg \
    -normalize \
    -fill white -undercolor '#00000080' \
    -gravity southwest -pointsize 96 \
    -annotate +10+10 "$(TZ='America/New_York' date '+%Y-%m-%d %I:%M:%S %p ET')" \
    -quiet \
    /home/ubuntu/cronjobs/image-normal.jpg 2>>/home/ubuntu/cronjobs/image.log

/home/linuxbrew/.linuxbrew/bin/magick /home/ubuntu/cronjobs/image-normal.jpg \
    -auto-gamma \
    -quiet \
    /home/ubuntu/cronjobs/image.jpg 2>>/home/ubuntu/cronjobs/image.log
