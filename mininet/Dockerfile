FROM ubuntu:14.04

RUN \
  apt-get update --quiet && \
  apt-get install -qy --no-install-recommends \
    libpython2.7-dev \
    libyaml-dev \
    python-paramiko \
    python-pip \
    git \
    net-tools \
    iputils-ping \
    iputils-arping \
    build-essential autoconf automake \
    dh-autoreconf \
    linux-headers-4.4.0-59-generic \
    wget \
    iputils-tracepath

# Install Mininet
ENV MININET_INSTALLER mininet/util/install.sh

RUN \
mkdir /build \
&& cd /build \
&& git clone git://github.com/mininet/mininet \
&& cd mininet \
&& git checkout -b 2.2.1 2.2.1 \
&& cd .. \

&& sed -e 's/sudo //g' \
        -e 's/~\//\//g' \
        -e 's/\(apt-get -y install\)/\1 --no-install-recommends --no-install-suggests/g' \
        -i $MININET_INSTALLER \
&& touch /.bashrc \
&& chmod +x ${MININET_INSTALLER} \
&& ${MININET_INSTALLER} -nv -V 2.5.0 -s /build \
&& rm -rf /build \
&& rm -rf mininet \
&& apt-get clean

COPY boot.sh /bin/
CMD ["/bin/boot.sh"]
