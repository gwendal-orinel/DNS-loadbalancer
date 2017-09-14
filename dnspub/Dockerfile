FROM ubuntu
ENTRYPOINT []

EXPOSE 53
EXPOSE 53/udp

RUN apt-get update -y && apt-get install -qy bind9

#COPY data/named.conf* /etc/bind/

CMD service bind9 start && tail -f /var/log/dmesg
