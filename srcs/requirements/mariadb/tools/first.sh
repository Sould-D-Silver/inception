#!/bin/sh
set -e

echo "$MYSQL_ROOT_PASSWORD"
echo "$MYSQL_DATABASE"
echo "$MYSQL_USER"
echo "$MYSQL_PASSWORD"

mkdir -p /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "criando o banco de dados inicial"
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
else
    echo "banco de dados já existe"
fi

envsubst < /usr/local/bin/db_init.sql > /usr/local/bin/db_init_processed.sql
echo "arquivo de inicialização processado"

echo "iniciando o servidor"
exec mariadbd --user=mysql --datadir=/var/lib/mysql \
    --init-file=/usr/local/bin/db_init_processed.sql --console