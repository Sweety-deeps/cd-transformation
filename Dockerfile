$ FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y nginx zip unzip  curl
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN curl -o /var/www/html/master.zip -L https://github.com/SivaranjanAsokan/5.1.DOCKER_PROJECT_Game_Deploy_With_Code/2048/archive/refs/heads/master.zip
# Extract the zip file
RUN unzip /var/www/html/master.zip -d /var/www/html/

# Move the contents to the web root and clean up
RUN mv /var/www/html/2048-master/* /var/www/html/ && rm -rf /var/www/html/2048-master /var/www/html/master.zip


EXPOSE 80

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
