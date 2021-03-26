# ft_server
The project is to set up a web server with Nginx, in only one docker container.The container OS must be debian buster.
• Your web server must be able to run several services at the same time. The services will be a WordPress website, phpMyAdmin and MySQL. You will need to make sure your SQL database works with the WordPress and phpMyAdmin.
• Your server should be able to use the SSL protocol.
• You will have to make sure that, depending on the url, your server redirects to the
correct website.
• You will also need to make sure your server is running with an autoindex that must be able to be disabled.

command to build the image and run the container
docker build --build-arg Autoindex=on -t nginx
docker run -it --rm -p 80:80 -p 443:443 nginx

Helpful command:
access log for request to nginx server: tail -f /var/log/nginx/access.log
check the configuration is installed sucessfully:  nginx -t
