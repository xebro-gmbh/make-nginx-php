FROM nginx:1.25.1 as prod

MAINTAINER Daniel Langemann <daniel@xebro.de>

ARG XEBRO_VERSION

LABEL de.xebro.company="xebro"
LABEL de.xebro.version=$XEBRO_VERSION

ENV USER_GID 1000
ENV USER_UID 1000

RUN apt-get update && \
    apt-get install gosu && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get autoremove -y && \
    apt-get clean -y

COPY ./etc/nginx.conf /etc/nginx/nginx.conf
COPY ./etc/default.conf /etc/nginx/conf.d/default.conf
COPY ./etc/entrypoint.sh /docker-entrypoint.d/

ENTRYPOINT ["/docker-entrypoint.d/entrypoint.sh"]
WORKDIR /var/www/html/public

EXPOSE 80

FROM prod as dev
