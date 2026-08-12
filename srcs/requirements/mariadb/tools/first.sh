#!/bin/sh



if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
    mysql_install_db --user=mysql --datadir=/var/lib/mysql && echo "criou   o banco de dados";
    mysqld --user=mysql --skip-networking &
    until mysqladmin ping >/dev/null 2>&1; do
        sleep 1
    done
    echo "iniciou o servidor";
    mysql  < /usr/local/bin/db_init.sql && echo "inseriu os dados iniciais";
    mysqladmin shutdown && echo "desligou o servidor";

fi


echo "iniciando o servidor novamente";
exec mysqld --user=mysql ;