ARG RLCRAFT_BASE_VERSION=latest
FROM rlcraft-base:${RLCRAFT_BASE_VERSION}
ENV RLCRAFT_BASE_VERSION=${RLCRAFT_BASE_VERSION}

RUN set -eux; \
        wget https://media.forgecdn.net/files/3000/874/Modern+RLCraft+Server+Pack-1.12.2-1.4.2.zip -O rlcraft.zip; \
        unzip -o rlcraft.zip; \
        rm rlcraft.zip; \
        rm Modern\ RLCraft\ Server\ Pack*/*.jar; \
        cp -R Modern\ RLCraft\ Server\ Pack*/* .; \
        rm -rf Modern\ RLCraft\ Server\ Pack*

RUN set -eux; \
        sed -i'' -e 's/server-ip=.*/server-ip=/' server.properties
