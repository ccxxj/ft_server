service mysql start

cp /root/wordpress.sql /var/www/wordpress.sql

echo "CREATE DATABASE wordpress" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'xxj'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
mysql wordpress -u root --password= < /var/www/wordpress.sql

wp core install --allow-root --path=/var/www/localhost/wordpress --url="https://localhost/wordpress" --title="xxj" --admin_name=admin --admin_password=admin --admin_email=cocoxxj@gmail.com

service php7.3-fpm start
service nginx start

bash