mysql_install_db --user=mysql;
mysqld_safe --skip-networking &;

mysql  < /bin/db_init.sql;

mysqladmin shutdown;

exec mysqld;