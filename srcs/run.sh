# redirecting sql file for phpmyadmin
service mysql start
mysql < var/www/html/phpmyadmin/sql/create_tables.sql -u root --skip-password

# DB for WORDPRESS SETTING
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root --skip-password
echo "CREATE USER IF NOT EXISTS 'sujeong'@'%' IDENTIFIED BY 'sujeong';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'sujeong'@'%' identified by '1234'WITH GRANT OPTION;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'sujeong'@'%' identified by '1234'WITH GRANT OPTION
    ;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

service nginx start
service php7.3-fpm start
sleep infinity
