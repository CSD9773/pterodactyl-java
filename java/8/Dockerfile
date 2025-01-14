FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:8u432-b06-jdk-focal

LABEL       author="CSD" maintainer="csd@minemelon.net"

LABEL       org.opencontainers.image.source="https://github.com/CSD9773/pterodactyl-java"
LABEL       org.opencontainers.image.licenses=MIT

RUN         rm -rf /usr/bin/dd \
						&& rm -rf /usr/bin/fallocate \
						&& rm -rf /usr/bin/truncate \
						&& rm -rf /usr/bin/xfs_mkfile

						RUN 				apt-get update -y \
						&& apt-get install -y jq lsof ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
						&& useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ../../graalvm/entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
