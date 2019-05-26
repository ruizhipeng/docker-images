FROM alpine

RUN set -xe  \
    && apk add --no-cache nginx tzdata \
    && mkdir -p /run/nginx /usr/share/nginx/html \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && wget https://github.com/mayswind/AriaNg/releases/download/1.1.1/AriaNg-1.1.1.zip \
    && unzip AriaNg-1.1.1.zip -q -d /usr/share/nginx/html/ \
    && rm AriaNg-1.1.1.zip \
    && chown -R nginx:www-data /usr/share/nginx/html/*
    

COPY --chown=root:root nginx-ariang.conf /etc/nginx/conf.d/default.conf

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
