# amcrest-jpg-gif web server

For when you don't want to stream video, but just want to a secure proxy to a static image.

Step 1 - do a global replace of FQDN with your domain name.

## build docker image

```
docker buildx build -t amcrest-jpg-gif --load .
```

## usage

### get a certificate from letsencrypt

This will run the container and get a certificate from letsencrypt.
This is optional, but letsencrypt will only give you a certificate if you have a valid domain name.

```sh
docker run -i -t \
  --name amcrest-web \
  -p 9999:80 \
  -p 9998:443 \
  -v "$(pwd)":/FQDN \
  -v "$(pwd)/FQDN.conf":/etc/nginx/conf.d/default.conf \
  amcrest-jpg-gif \
  certbot --register-unsafely-without-email --nginx --agree-tos
```

Follow prompts to get a certificate and update the nginx config.

You will need to run one of the scripts, perhaps in a cron job, to update the images.
## amcrest-jpg

This is a simple script that takes a snapshot from an Amcrest IP camera and converts it to a jpg.

## amcrest-jpg-gif

Replace all image.jpg references with image.gif in the nginx config and in the index.html file.

This is a simple script that takes a series of snapshots from an Amcrest IP camera and converts it to a gif.


# troubleshooting

The jpg api endpoint will vary by camera model. See the jpg row on this site for pointers:

<https://www.ispyconnect.com/camera/amcrest>