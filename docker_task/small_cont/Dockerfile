FROM alpine 

ENV TZ Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
&& apk update && apk add \ 
apache2 \
# bind-tools is a packege with nslookup
bind-tools \
# openrc is a packege with rc-* commands 
openrc \
&& mkdir -p /usr/app/peter/

WORKDIR /usr/app/peter/
COPY . /usr/app/peter/
ENV domain pornhub.com

EXPOSE 80

CMD ["/bin/sh", "script.sh"]
