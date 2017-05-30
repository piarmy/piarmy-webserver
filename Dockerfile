FROM mattwiater/piarmy-webserver

COPY containerFiles /www
WORKDIR /www

EXPOSE 80

CMD ["httpd", "-f", "-p", "80", "-h", "/www"]