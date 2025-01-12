FROM ubuntu:22.04

ARG TARGETPLATFORM
ARG GRAAL_VERSION=22.0.2

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
  && curl --retry 3 -Lfso /tmp/graalvm.tar.gz https://download.oracle.com/graalvm/22/latest/graalvm-jdk-22_linux-${ARCH}_bin.tar.gz \
  && mkdir -p /opt/java/graalvm \
  && cd /opt/java/graalvm \
  && tar -xf /tmp/graalvm.tar.gz --strip-components=1 \
  && export PATH="/opt/java/graalvm/bin:$PATH" \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/graalvm.tar.gz

ENV JAVA_HOME=/opt/java/graalvm \
    PATH="/opt/java/graalvm/bin:$PATH"

RUN         useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
