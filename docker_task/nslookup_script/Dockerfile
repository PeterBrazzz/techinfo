FROM ubuntu:20.04

ENV TZ Europe/Moscow
ENV domain pornhub.com

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
&& apt-get update && apt-get install -y \ 
apache2 \
dnsutils \ 
&& mkdir -p /usr/app/peter/ \
&& rm -rf /var/cache/apt

WORKDIR /usr/app/peter/
COPY . /usr/app/peter/

EXPOSE 80

CMD ["/bin/bash", "script.sh"]