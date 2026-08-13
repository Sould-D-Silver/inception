#!/bin/sh


echo "$MYSQL_ROOT_PASSWORD"
echo "$MYSQL_DATABASE"
echo "$MYSQL_USER"
echo "$MYSQL_PASSWORD"

mkdir -p /var/lib/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/mysql"  ]; then
   
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql && echo "criou   o banco de dados"
fi

echo "iniciou o servidor";
envsubst < /usr/local/bin/db_init.sql > /usr/local/bin/db_init_processed.sql && echo "inseriu os dados iniciais";


exec mariadbd --user=mysql --init-file=/usr/local/bin/db_init_processed.sql --console ;