#!/bin/sh

set -e 

export DB_USER_PASSWORD=$(cat /run/secrets/db_user_pass)
export WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_pass)
export WP_USER_PASSWD=$(cat /run/secrets/wp_user_pass)

wait_for_db() {
    echo "aguardando o banco de dados..."
    until mysqladmin ping -h "mariadb" -u"$MYSQL_USER" -p"$DB_USER_PASSWORD" --silent >/dev/null 2>&1; do
        sleep 1
    done
    echo "banco de dados disponível"
}


if [ ! -f "/var/www/html/wp-config.php" ]; then

    if [ -f "/var/www/html/wp-config-sample.php" ]; then
        cp  wp-config-sample.php wp-config-sample.php
    fi

    echo "baixando e configurando o wordpress"
    if ! wp core is-installed  ; then
        wp core download --allow-root
    fi

    wait_for_db

    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$DB_USER_PASSWORD" \
        --dbhost="$DB_HOST" \
        --allow-root

    echo "created wp-config.php"

    if [ ! -f "/var/www/html/wp-config.php" ]; then
        echo "Erro: wp-config.php não foi criado corretamente."
        exit 1
    fi

    wp core install \
        --title="$WP_TITLE" \
        --url="$WP_URL" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWD" \
        --allow-root

    chown -R nobody:nobody /var/www/html

    echo "iniciando o servidor"

    exec php-fpm84 -F
else
    echo "wordpress já está baixado e configurado" 
    wait_for_db

    echo "iniciando o servidor com bd ja existente"

    exec php-fpm84 -F
fi

