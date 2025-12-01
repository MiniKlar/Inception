#!/bin/sh

mkdir /srv/ftp

chown nobody:nogroup /srv/ftp

echo "anon" > /srv/ftp/anon.txt

adduser -D -h /wordpress $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

exec vsftpd /etc/vsftpd/vsftpd.conf
