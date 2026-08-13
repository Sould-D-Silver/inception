FROM alpine:3.23.5

RUN apk update && apk add --no-cache \
    php84 \
    php84-fpm php84-mysqli php84-opcache\
    php84-gd php84-curl php84-mbstring php84-xml\
    php84-session php84-zip 

RUN rm -rf /var/cache/apk/*

EXPOSE 80 

