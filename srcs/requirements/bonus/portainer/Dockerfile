FROM alpine:3.22

RUN apk update && apk add --no-cache \
    wget \
    tar \
    libc6-compat

ARG PORTAINER_VERSION=2.33.5

RUN wget https://github.com/portainer/portainer/releases/download/${PORTAINER_VERSION}/portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz \
    && tar -xvf portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz \
    && rm portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz \
    && mv portainer /usr/local/bin/portainer-bin

RUN mkdir -p /data

WORKDIR /usr/local/bin/portainer-bin

EXPOSE 9000

CMD ["./portainer", "--data", "/data", "--no-analytics"]
