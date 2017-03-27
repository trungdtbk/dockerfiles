FROM ubuntu:latest

ENV OVS_VERSION 2.5.2
RUN \
  apt-get update --quiet && \
  apt-get install -qy --no-install-recommends \
  build-essential fakeroot supervisor wget net-tools
#    libpython2.7-dev \
#    libyaml-dev \
#    python-paramiko \
#    python-pip
#    git \
#    python
#    net-tools \
#    iputils-ping \
#    iputils-arping \
#    build-essential \
#    autoconf \
#    automake \
#    iputils-tracepath \
#    wget
RUN \
mkdir /build && cd /build \
&& wget http://openvswitch.org/releases/openvswitch-${OVS_VERSION}.tar.gz \
&& tar xzf openvswitch-${OVS_VERSION}.tar.gz
WORKDIR /build/openvswitch-${OVS_VERSION}/
RUN ./configure && make && make install
RUN \
mkdir /etc/openvswitch \
&& ovsdb-tool create /etc/openvswitch/conf.db /usr/local/share/openvswitch/vswitch.ovsschema
RUN rm -r /build
RUN apt-get clean

ADD supervisord.conf /etc/
ADD configure-ovs.sh /usr/local/share/openvswitch/

WORKDIR /

CMD ["/usr/bin/supervisord"]
