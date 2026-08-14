FROM alpine:3.23.5

RUN apk update && apk add --no-cache gettext mariadb mariadb-client
    

RUN rm -rf /var/cache/apk/* /var/lib/mysql

RUN mkdir -p /var/run/mysql && chown -R mysql:mysql /var/run/mysql

RUN rm -f /etc/my.cnf.d/mariadb-server.cnf

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh
COPY ./tools/db_init.sql /usr/local/bin/db_init.sql

RUN chmod +x /usr/local/bin/mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]