FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*


EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/first.sh /bin/first.sh
COPY ./tools/db_init.sql /bin/db_init.sql

RUN chmod +x /bin/first.sh

RUN echo "dentro do container"

ENTRYPOINT ["/bin/first.sh"]