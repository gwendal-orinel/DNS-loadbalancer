FROM ubuntu
ENTRYPOINT []

EXPOSE 8300-8302
EXPOSE 8301-8302/udp
EXPOSE 8500
EXPOSE 8600
EXPOSE 8600/udp

RUN apt-get update -y && \
        apt-get install -qy curl bind9 unzip && \
        curl -o consul-template.zip https://releases.hashicorp.com/consul-template/0.19.2/consul-template_0.19.2_linux_amd64.zip &&\
        curl -o consul.zip https://releases.hashicorp.com/consul/0.9.2/consul_0.9.2_linux_amd64.zip?_ga=2.39868391.459639417.1504620639-308966139.1498052766 && \
        unzip consul.zip && unzip consul-template.zip && \
        rm *.zip && mv consul* /bin/
  
#consul persist storage
VOLUME /consul
RUN chgrp -R 0 /consul && chmod -R g+rwX /consul

#consul data
COPY data/config.json /consul/
COPY data/update-dns.tmp /consul/

#bind data
COPY data/named.conf* /etc/bind/
COPY data/rndc.key /etc/bind/
RUN chmod 700 /etc/bind/rndc.key
RUN mkdir /etc/bind/zones


CMD /bin/consul agent --config-file /consul/config.json -advertise 192.168.0.2 -retry-join 192.168.0.3
