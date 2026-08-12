FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client
    
EXPOSE 3306

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/first.sh /usr/local/bin/first.sh
COPY ./tools/db_init.sql /usr/local/bin/db_init.sql

RUN chmod +x /usr/local/bin/first.sh

RUN echo "dentro do container"


# ENV MYSQL_ROOT_PASSWORD=root \
#     MYSQL_DATABASE=app_db \
#     MYSQL_USER=app_user \
#     MYSQL_PASSWORD=app_pass
# 
    
ENTRYPOINT ["/usr/local/bin/first.sh"]