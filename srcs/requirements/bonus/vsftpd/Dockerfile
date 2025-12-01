FROM	alpine:3.22

RUN		apk update && apk add vsftpd

COPY	./conf/vsftpd.conf /etc/vsftpd/

COPY	./tools/ftp_script.sh /tmp/

RUN		chmod +x "/tmp/ftp_script.sh"

EXPOSE	21

CMD		[ "/tmp/ftp_script.sh" ]
