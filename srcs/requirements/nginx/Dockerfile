FROM alpine:3.22

RUN apk update && apk add nginx openssl && mkdir -p /run/nginx && mv /etc/nginx/http.d/default.conf /etc/nginx/http.d/default.conf.disabled

COPY ./conf/lomont.42.fr.conf /etc/nginx/http.d/

COPY ./tools/nginx_script.sh /tmp/

RUN mkdir -p /etc/nginx/ssl

RUN chmod +x /tmp/nginx_script.sh

EXPOSE 443

ENTRYPOINT [ "/tmp/nginx_script.sh" ]
