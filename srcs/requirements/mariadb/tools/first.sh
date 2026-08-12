

mysql_install_db --user=mysql && echo "criou   o banco de dados";
mysqld_safe --skip-networking & echo "iniciou o servidor";

mysql  < /bin/db_init.sql && echo "inseriu os dados iniciais";

mysqladmin shutdown && echo "desligou o servidor";
echo "iniciando o servidor novamente";
exec mysqld ;