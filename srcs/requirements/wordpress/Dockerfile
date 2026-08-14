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



# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#     && chmod +x wp-cli.phar \
#     && mv wp-cli.phar /usr/local/bin/wp

# RUN curl -O https://github.com/wp-cli/wp-cli/releases/download/v2.12.0/wp-cli-2.12.0.phar \
#     && chmod +x wp-cli-2.12.0.phar \
#     && mv wp-cli-2.12.0.phar /usr/local/bin/wp

RUN curl -fsSL -o /usr/local/bin/wp \
    https://github.com/wp-cli/wp-cli/releases/download/v2.12.0/wp-cli-2.12.0.phar \
    && chmod +x /usr/local/bin/wp

# RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz && \
#     tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
#     rm /tmp/wordpress.tar.gz

COPY ./conf/limit.ini /etc/php84/conf.d/99-wp-cli.ini

COPY ./tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
