#!/bin/sh

CERT_FILE="/etc/nginx/ssl/inception.crt"
KEY_FILE="/etc/nginx/ssl/inception.key"

if [ ! -f $CERT_FILE ]; then
	echo "Certificate doesn't exist, generating a SSL certification..."

	openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
    -keyout "$KEY_FILE" \
    -out "$CERT_FILE" \
    -subj "/C=FR/ST=Normandie/L=LeHavre/O=42/OU=42/CN=lomont.42.fr/UID=lomont"

	echo "Certificate created!"
fi

if openssl x509 -checkend 86400 -noout -in /etc/nginx/ssl/inception.crt; then
    echo "Certificate is valid!"
else
    echo "Certificate is expired or invalid! Generating a new one..."

	openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
        -keyout "$KEY_FILE" \
        -out "$CERT_FILE" \
        -subj "/C=FR/ST=Normandie/L=LeHavre/O=42/OU=42/CN=lomont.42.fr/UID=lomont"

	echo "New certificate created!"
fi

exec nginx -g "daemon off;"
