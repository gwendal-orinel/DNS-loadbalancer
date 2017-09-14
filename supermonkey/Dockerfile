FROM ubuntu
ENTRYPOINT []

EXPOSE 80
EXPOSE 8500

RUN apt-get update -y && \
        apt-get install -qy curl wget jq unzip apache2 libapache2-mod-php php && \
        curl -o consul-template.zip https://releases.hashicorp.com/consul-template/0.19.2/consul-template_0.19.2_linux_amd64.zip &&\
        curl -o consul.zip https://releases.hashicorp.com/consul/0.9.2/consul_0.9.2_linux_amd64.zip?_ga=2.39868391.459639417.1504620639-308966139.1498052766 && \
        unzip consul.zip && unzip consul-template.zip && \
        rm *.zip && mv consul* /bin/

#RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb
#RUN dpkg -i dumb-init_*.deb

#ENTRYPOINT ["/usr/bin/dumb-init", "--"]
#CMD /etc/init.d/apache2 start && /bin/consul agent --config-file /consul/config.json

CMD ["/bin/bash", "-c", "/etc/init.d/apache2 start && /bin/consul agent --config-file /consul/config.json"]
