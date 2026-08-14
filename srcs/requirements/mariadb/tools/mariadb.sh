#!/bin/sh
set -e

export DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_pass)
export DB_USER_PASSWORD=$(cat /run/secrets/db_user_pass)


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
    --init-file=/usr/local/bin/db_init_processed.sql