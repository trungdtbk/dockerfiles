FROM ubuntu:latest

RUN apt-get update; apt-get upgrade -y
RUN apt-get install -y --no-install-recommends quagga build-essential \
    tcpdump \
    libpcap-dev \
    net-tools ifupdown \
    iputils-ping wget unzip \
    iperf supervisor

COPY config/* /etc/quagga/
RUN chown -R quagga /etc/quagga

WORKDIR /
RUN wget http://traffic.comics.unina.it/software/ITG/codice/D-ITG-2.8.1-r1023-src.zip
RUN unzip D-ITG-2.8.1-r1023-src.zip
RUN rm D-ITG-2.8.1-r1023-src.zip
WORKDIR /D-ITG-2.8.1-r1023/src
RUN make && make install PREFIX=/usr/local
WORKDIR /

ADD supervisord.conf /etc/
ADD start-quagga.sh /usr/local/bin/

ENV PATH "/usr/lib/quagga/:/sbin:/bin:/usr/sbin:/usr/bin"
ONBUILD ADD config/* /etc/quagga/
ONBUILD RUN chown -R quagga /etc/quagga
VOLUME ["/etc/quagga/", "/var/log/quagga/"]
CMD ["/usr/bin/supervisord"]
