FROM alpine:3.23.5

RUN apk update && apk add --no-cache gettext mariadb mariadb-client
    

RUN rm -rf /var/cache/apk/* /var/lib/mysql

RUN mkdir -p /var/run/mysql && chown -R mysql:mysql /var/run/mysql



COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/first.sh /usr/local/bin/first.sh
COPY ./tools/db_init.sql /usr/local/bin/db_init.sql

RUN chmod +x /usr/local/bin/first.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/first.sh"]