FROM sergef/docker-library-nginx:1.12.1.2

ARG CONSUL_VERSION=v0.9.3
ENV CONSUL_VERSION ${CONSUL_VERSION}

RUN echo 'http://alpine.gliderlabs.com/alpine/v3.5/main' > /etc/apk/repositories \
  && echo '@community http://alpine.gliderlabs.com/alpine/v3.5/community' >> /etc/apk/repositories \
  && apk add --update-cache \
    bash \
    build-base \
    git \
    nodejs \
    make \
    ruby-bundler \
    ruby-dev \
    zip \
  && mkdir -p /build/consul \
  && cd /build/consul \
  && git init \
  && git remote add origin \
    https://github.com/hashicorp/consul.git --no-tags \
  && git config core.sparseCheckout true \
  && echo 'ui/' >> .git/info/sparse-checkout \
  && git fetch --depth=1 --tags \
  && git checkout tags/${CONSUL_VERSION} -b ${CONSUL_VERSION} \
  && git reset --hard \
  && make -C /build/consul/ui dist \
  && cp -r /build/consul/pkg/web_ui/* /app \
  && apk del \
    bash \
    build-base \
    git \
    nodejs \
    make \
    ruby-bundler \
    ruby-dev \
    zip \
  && rm -rf \
    /build \
    /var/cache/apk/* \
    /var/lib/apk/* \
