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

#consul persist storage
VOLUME /consul
RUN chgrp -R 0 /consul && chmod -R g+rwX /consul

#consul data
COPY data/config.json /consul/
COPY data/000-default.conf /etc/apache2/sites-available/

#regenerator files
RUN mkdir /consul/scripts/ /consul/backups/
COPY data/scripts/* /consul/scripts/

#web files & web settings
COPY data/webfiles.tar /var/www/
RUN cd /var/www/ && rm -R html && tar xvf webfiles.tar && rm webfiles.tar
COPY data/settings.json /var/www/

RUN a2enmod proxy proxy_http rewrite

CMD ["/bin/bash", "-c", "/etc/init.d/apache2 start && /bin/consul agent --config-file /consul/config.json"]
