FROM alpine:3
LABEL maintainer="Ian Spence <ian@ecnepsnai.com>"
LABEL org.opencontainers.image.authors="Ian Spence <ian@ecnepsnai.com>"
LABEL org.opencontainers.image.source=https://github.com/ecnepsnai/nginx
LABEL org.opencontainers.image.title="nginx"
LABEL org.opencontainers.image.description="nginx container image"

ARG OPENSSL_VERSION=1.1.1l
ARG NGINX_VERSION=1.21.1
ARG NUM_THREADS=4

RUN apk add --no-cache build-base zlib-dev pcre-dev curl tar perl linux-headers

RUN curl https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz | tar -xzf - && \
    curl https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar -xzf -

WORKDIR /nginx-${NGINX_VERSION}

RUN ./configure --with-http_ssl_module --with-threads --with-http_v2_module --with-http_realip_module --with-openssl=/openssl-${OPENSSL_VERSION} && \
    make -sj${NUM_THREADS} && \
    mv objs/nginx /sbin/nginx && \
    mkdir -p /etc/nginx && \
    cp conf/mime.types /etc/nginx

COPY nginx.conf /nginx.conf

RUN rm -rf /nginx-${NGINX_VERSION} /openssl-${OPENSSL_VERSION} && \
    apk del --no-cache build-base curl tar perl linux-headers

VOLUME [ "/usr/local/nginx/logs", "/nginx_conf", "/nginx_root" ]
EXPOSE 80 443

ENTRYPOINT [ "/sbin/nginx", "-c", "/nginx.conf" ]
