FROM  debian:buster

# update
RUN apt-get  update 
RUN apt-get  upgrade -y 

# install nginx
RUN apt-get -y  install nginx 

# install MYass
RUN apt-get -y install mariadb-server

# install Bhb 
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring

# install some other shit
RUN apt-get -y install wget
RUN apt-get -y install vim 

#hez het
 
RUN mkdir /var/www/html/wordpress
RUN mkdir /var/www/html/phpmyadmin

COPY ./srcs/wordpress /var/www/html/wordpress
COPY ./srcs/services.sh /var/
COPY ./srcs/db_wordpress.sql /var/
COPY ./srcs/phpmyadmin /var/www/html/phpmyadmin
COPY ./srcs/default /etc/nginx/sites-available/
COPY ./srcs/localhost.sql /var/

RUN  service mysql start && mysql -u root mysql < /var/db_wordpress.sql && mysql -u root mysql < /var/localhost.sql
#start services 
CMD /bin/sh /var/services.sh

EXPOSE 80 443
