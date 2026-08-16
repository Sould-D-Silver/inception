FROM alpine:3.23.5

RUN apk update && apk add --no-cache \
    wget \
    curl \
    mariadb-client \
    php84 \
    php84-fpm \
    php84-mysqli \
    php84-opcache \
    php84-gd \
    php84-phar \
    php84-curl \
    php84-mbstring \
    php84-xml \
    php84-session \
    php84-zip 

RUN rm -rf /var/cache/apk/*

RUN curl -fsSL -o /usr/local/bin/wp \
    https://github.com/wp-cli/wp-cli/releases/download/v2.12.0/wp-cli-2.12.0.phar \
    && chmod +x /usr/local/bin/wp


COPY ./conf/limit.ini /etc/php84/conf.d/99-wp-cli.ini
COPY ./conf/www.conf /etc/php84/php-fpm.d/www.conf

COPY ./tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh


WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
