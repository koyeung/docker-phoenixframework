docker-phoenixframework
=======================

Run [Phoenix Framework](http://www.phoenixframework.org) on [Alpine Linux](http://www.alpinelinux.org) docker image.


Setup docker image
====================

Method 1: Building
------------------

    # docker build --rm -t <username>/phoenixframework .

Method 2: Pull from Docker Hub
------------------------------

    # docker pull docker.io/<username>/phoenixframework

Test
====

* setup:

  ```bash
  mkdir -p app dotHex
  docker run --rm -v "$PWD/app":/app -v "$PWD/dotHex:/root/.hex" \
      koyeung/phoenixframework phoenix.new /app --app=hello_phoenix
  docker run --rm -v "$PWD/app":/app -v "$PWD/dotHex:/root/.hex" \
      koyeung/phoenixframework deps.get
  docker run --rm -v "$PWD/app":/app -v "$PWD/dotHex:/root/.hex" \
      --entrypoint npm koyeung/phoenix install
  ```

* run:

  ```bash
  docker run --rm -v "$PWD/app":/app -v "$PWD/dotHex:/root/.hex" \
    -p 4000:4000 \
    koyeung/phoenixframework phoenix.server
  ```

  Browse to `http://localhost:4000` for the Phoenix Framework welcome page
