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

RUN echo "******************系统平台******************" && \
    echo "$(uname -m)" && \
    echo "******************系统平台******************" && \
    case "$(uname -m)" in  \
    x86_64) PLATFORM='amd64';; \
    armv5l) PLATFORM='armv5';; \
    armv6l) PLATFORM='armv6';; \
    armv7l) PLATFORM='armv7';; \
    armv8l) PLATFORM='armv8';; \
    aarch64) PLATFORM='arm';; \
    *) echo "unsupported architecture"; exit 1 ;; \
    esac && \
    set -xe && \
    apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    apk add --no-cache tzdata ca-certificates jq curl wget &&\
    VER=$(curl -s https://api.github.com/repos/Finb/bark-server/releases/latest | grep tag_name | cut -d '"' -f 4) && \
	VER_NUM=$(echo $VER|cut -b 2-) && \
	echo VER_NUM && \
    mkdir /bark &&\
    cd /bark &&\
    # URL=https://github.com/aircross/docker-trojan-go/releases/download/${VER}/trojan-go-linux-${PLATFORM}.zip && \
    # https://github.com/Finb/bark-server/releases/download/v2.0.3/bark-server_linux_amd64
    URL=https://github.com/Finb/bark-server/releases/download/${VER}/bark-server_linux_${PLATFORM} && \
    wget --no-check-certificate $URL -O bark-server && \
    chmod +x bark-server

    
#RUN /usr/local/bin/python -m pip install --upgrade pip
# https://api.github.com/repos/Finb/bark-server/releases/latest
#EXPOSE 8080
#
# ENTRYPOINT ["./bark-server_linux_amd64", "-addr", "0.0.0.0:8080", "-data", "./bark-data"]
ENTRYPOINT /bark/bark-server -addr 0.0.0.0:8080 -data /bark/bark-data


