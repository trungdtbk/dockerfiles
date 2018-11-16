FROM trungdtbk/ubuntu:xenial

RUN apt-get update && apt-get install -y \
    autoconf \
    build-essential \
    flex \
    bison \
    libncurses5-dev \
    libreadline-dev \
    wget

# Install BIRD internet routing
ENV BIRD_VERSION=1.6.4
RUN mkdir /etc/bird
RUN wget ftp://bird.network.cz/pub/bird/bird-$BIRD_VERSION.tar.gz && tar -zxvf bird-$BIRD_VERSION.tar.gz && rm bird-$BIRD_VERSION.tar.gz
WORKDIR bird-$BIRD_VERSION
RUN ./configure && make && make install
RUN ./configure --enable-ipv6 && make && make install

EXPOSE 179

CMD bird -c /etc/bird/bird.conf -d
