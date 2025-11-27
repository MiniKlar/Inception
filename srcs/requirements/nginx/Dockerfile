FROM alpine:3.22

WORKDIR /app

RUN apk update && apk add nginx && mkdir -p /run/nginx && mv /etc/nginx/http.d/default.conf /etc/nginx/http.d/default.conf.disabled

COPY ./tools/index.html /var/www/localhost/htdocs/

COPY ./tools/1000010831.JPG /var/www/localhost/htdocs/

COPY ./conf/lomont.42.fr.conf /etc/nginx/http.d/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
