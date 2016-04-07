docker-phoenix
==============

Run [Phoenix Framework](http://www.phoenixframework.org) on [Alpine Linux](http://www.alpinelinux.org) docker image.


Setup docker image
====================

Method 1: Building
------------------

    # docker build --rm -t <username>/phoenix .

Method 2: Pull from Docker Hub
------------------------------

    # docker pull docker.io/<username>/phoenix

Test
====

* setup:

  ```bash
  mkdir -p app dotHex
  docker run --rm -v "$PWD/app":/app -v "$PWD/dotHex:/root/.hex" \
      koyeung/phoenix phoenix.new /app --app=hello_phoenix
  docker run --rm -v "$PWD/app":/app -v "$PWD/dotHex:/root/.hex" \
      koyeung/phoenix deps.get
  docker run --rm -v "$PWD/app":/app -v "$PWD/dotHex:/root/.hex" \
      --entrypoint npm koyeung/phoenix install
  ```

* run:

  ```bash
  docker run --rm -v "$PWD/app":/app -v "$PWD/dotHex:/root/.hex" \
    -p 4000:4000 \
    koyeung/phoenix phoenix.server
  ```

  Browse to `http://localhost:4000` for the Phoenix Framework welcome page
