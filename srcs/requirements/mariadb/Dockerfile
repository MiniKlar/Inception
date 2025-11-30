FROM alpine:3.22

WORKDIR /app

RUN apk update && apk add mariadb mariadb-client

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./tools/mariadb_startup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mariadb_startup.sh

COPY /conf/mariadb-server.cnf /etc/my.cnf.d/

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/mariadb_startup.sh" ]
