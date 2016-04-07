FROM koyeung/elixir:1.2.4
MAINTAINER King-On Yeung <koyeung@gmail.com>

#
# setup node.js
#

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 5.10.1

# gpg keys listed at https://github.com/nodejs/node
RUN set -ex \
  && apk add --no-cache tar xz zlib libuv openssl libstdc++ libgcc \
  && apk add --no-cache --virtual .setup-deps \
    gpgme curl \
    gcc g++ python make binutils-gold \
    linux-headers zlib-dev libuv-dev openssl-dev \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION.tar.xz" -C /usr/local \
  && rm "node-v$NODE_VERSION.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && cd /usr/local/node-v$NODE_VERSION \
  && ./configure --prefix=/usr --shared-zlib --shared-libuv --shared-openssl --without-snapshot \
  && make \
  && make install \
  && cd / \
  && apk del .setup-deps \
  && rm -rf /usr/local/node-v$NODE_VERSION


#
# setup Phoenix
#

ENV PHOENIX_VERSION 1.1.4

RUN apk add --no-cache inotify-tools \
    && mix local.hex --force \
    && mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new-${PHOENIX_VERSION}.ez

EXPOSE 4000

VOLUME ["/app", "/root/.hex"]
WORKDIR /app

ENTRYPOINT [ "mix" ]
