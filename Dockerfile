#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM golang:alpine
MAINTAINER John <admin@vps.la>

ENV bark_VERSION 4.0.2

VOLUME /tmp
ADD . /work

WORKDIR /work

RUN set -xe && \
    apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    apk add --no-cache tzdata ca-certificates jq curl wget &&\
    VER=$(curl -s https://api.github.com/repos/aircross/docker-trojan-go/releases/latest | grep tag_name | cut -d '"' -f 4) && \
	VER_NUM=$(echo $VER|cut -b 2-) && \
	echo VER_NUM && \
    mkdir /bark &&\
    cd /bark &&\
    # URL=https://github.com/aircross/docker-trojan-go/releases/download/${VER}/trojan-go-linux-${PLATFORM}.zip && \
    # https://github.com/Finb/bark-server/releases/download/v2.0.3/bark-server_linux_amd64
    URL=https://github.com/Finb/bark-server/releases/download/${VER}/bark-server_linux_amd64 && \
    wget --no-check-certificate $URL && \
    chmod +x bark-server_linux_amd64

    
#RUN /usr/local/bin/python -m pip install --upgrade pip
# https://api.github.com/repos/Finb/bark-server/releases/latest



# CMD /bin/sh
#RUN set -x && \
#	#wget --no-check-certificate https://github.com/django/django/archive/refs/tags/${DJANGO_VERSION}.tar.gz && \ 
#	#tar xzf ${DJANGO_VERSION}.tar.gz && \
#	#python -m pip install -e django-${DJANGO_VERSION}/ && \
#	mkdir /django && \
#	cd /django && \
#	django-admin startproject home && \
#	#rm -rf *.tar.gz
#
##RUN pip3 install django-simpleui -U
##https://github.com/django/django/releases/tag/4.0.2
##https://github.com/django/django/archive/refs/tags/4.0.2.zip
##https://github.com/django/django/archive/refs/tags/4.0.2.tar.gz
##git clone https://github.com/django/django.git
#EXPOSE 8080
#
# ENTRYPOINT ["./bark-server_linux_amd64", "-addr", "0.0.0.0:8080", "-data", "./bark-data"]
ENTRYPOINT /bark/bark-server_linux_amd64 -addr 0.0.0.0:8080 -data /bark/bark-data


