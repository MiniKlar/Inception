FROM	alpine:3.22

RUN		apk update && apk add nodejs npm

COPY	/tools/website_script.sh /tmp/

RUN		chmod +x /tmp/website_script.sh

WORKDIR /app

COPY 	/conf/server.js .

EXPOSE	3000

ENTRYPOINT [ "/tmp/website_script.sh" ]
