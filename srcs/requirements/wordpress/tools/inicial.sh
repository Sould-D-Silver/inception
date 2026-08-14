#!/bin/sh

set -e 

wait_for_db() {
    echo "aguardando o banco de dados..."
    until mysqladmin ping -h "mariadb" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent >/dev/null 2>&1; do
        sleep 1
    done
    echo "banco de dados disponível"
}



if [ ! -f "/var/www/html/wp-config.php" ]; then

   # wait_for_db
    echo "baixando e configurando o wordpress"
    if ! wp core is-installed  ; then
        wp core download --allow-root
    fi
    wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="mariadb" \
    --allow-root

    if [ ! -f "/var/www/html/wp-config.php" ]; then
        echo "Erro: wp-config.php não foi criado corretamente."
        #exit 1
    fi

    wp core install \
    --title="Inception" \
    --url="https://sjoao.42.fr" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="wp-admin@sjoao.42.fr" \
    --allow-root


    wp user create "$WP_USER" "$WP_USER_EMAIL" \
    --role=author \
    --user_pass="$WP_USER_PASSWD" \
    --allow-root



    

else
    echo "wordpress já está baixado e cconfigurado" 
fi

echo "iniciando o servidor"
exec php-fpm84 -F