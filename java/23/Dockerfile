FROM        --platform=$TARGETOS/$TARGETARCH ubuntu:20.04

LABEL       author="CSD" maintainer="csd@minemelon.net"

LABEL       org.opencontainers.image.source="https://github.com/CSD9773/pterodactyl-java"
LABEL       org.opencontainers.image.licenses=MIT

RUN         apt-get update -y \
						&& apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig tzdata locales iproute2 \
						&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
						&& locale-gen en_US.UTF-8 \
						&& case ${TARGETPLATFORM} in \
								"linux/amd64")  ARCH=x64  ;; \
								"linux/arm64")  ARCH=aarch64  ;; \
						esac \
						&& curl --retry 3 -Lfso /tmp/graalvm.tar.gz https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${GRAAL_VERSION}/graalvm-community-jdk-${GRAAL_VERSION}_linux-${ARCH}_bin.tar.gz \
						&& mkdir -p /opt/java/graalvm \
						&& cd /opt/java/graalvm \
						&& tar -xf /tmp/graalvm.tar.gz --strip-components=1 \
						&& rm -rf /tmp/graalvm.tar.gz \
						&& rm -rf /var/lib/apt/lists/*

ENV         JAVA_HOME=/opt/java/graalvm \
            PATH="/opt/java/graalvm/bin:$PATH"

RUN         useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
