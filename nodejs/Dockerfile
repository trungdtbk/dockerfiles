FROM ubuntu:16.04

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends nodejs \
    && apt-get install -y --no-install-recommends npm

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends postgresql postgresql-contrib

VOLUME ["/usr/src/app", "/boot"]

EXPOSE 8080
CMD ["/boot/start.sh"]
