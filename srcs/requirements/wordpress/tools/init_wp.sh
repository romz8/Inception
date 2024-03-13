#! bin/sh

if [ -f wp-config.php ]; then
	wp core download --version=6.4.3 --allow-root
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER \
	--dbpass=$DB_USER_PWD --dbhost=$DB_HOSTNAME --allow-root
	wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" \
	--admin_user=$WP_ADMIN --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --allow-root
	wp theme install twentytwentytwo --activate --allow-root
fi

/usr/sbin/php-fpm7.4 -F;