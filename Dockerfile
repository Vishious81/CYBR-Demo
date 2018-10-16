## Dockerfile for latest alpine with latest OpenSSH enabled
FROM alpine:latest

LABEL maintainer="https://github.com/Vishious81"

ENV ROOT_PASSWORD=ChangeMe!

EXPOSE 22

RUN apk update && apk upgrade && apk add --no-cache openssh \
    && sed -i s/#PermitRootLogin./PermitRootLogin\ yes/ /etc/ssh/sshd_config \
    && echo "root:${ROOT_PASSWORD}" | chpasswd \
    && rm -rf /var/cache/apk/ /tmp/*

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT [entrypoint.sh]