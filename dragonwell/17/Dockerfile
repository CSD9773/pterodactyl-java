FROM ubuntu:22.04

ARG TARGETPLATFORM

LABEL       author="CSD" maintainer="csd@minemelon.net"

LABEL       org.opencontainers.image.source="https://github.com/CSD9773/pterodactyl-java"
LABEL       org.opencontainers.image.licenses=MIT

ENV LANG='vi_VN.UTF-8' LANGUAGE='vi_VN:vi' LC_ALL='vi_VN.UTF-8' TZ='Asia/Ho_Chi_Minh' DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
  && apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata locales iproute2 \
  && echo "vi_VN.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen vi_VN.UTF-8 \
  && case ${TARGETPLATFORM} in \
         "linux/amd64")  ARCH=x64  ;; \
         "linux/arm64")  ARCH=aarch64  ;; \
    esac \
  && curl --retry 3 -Lfso /tmp/dragonwell.tar.gz https://github.com/dragonwell-project/dragonwell17/releases/download/dragonwell-standard-17.0.13.0.14%2B9_jdk-17.0.13-ga/Alibaba_Dragonwell_Standard_17.0.13.0.14.9_${ARCH}_linux.tar.gz \
  && mkdir -p /opt/java/dragonwell \
  && cd /opt/java/dragonwell \
  && tar -xf /tmp/dragonwell.tar.gz --strip-components=1 \
  && export PATH="/opt/java/dragonwell/bin:$PATH" \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/dragonwell.tar.gz

ENV JAVA_HOME=/opt/java/dragonwell \
    PATH="/opt/java/dragonwell/bin:$PATH"

RUN         useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
