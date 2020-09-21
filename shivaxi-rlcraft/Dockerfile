ARG RLCRAFT_BASE_VERSION=latest
FROM rlcraft-base:${RLCRAFT_BASE_VERSION}
ENV RLCRAFT_BASE_VERSION=${RLCRAFT_BASE_VERSION}

RUN set -eux; \
        wget https://media.forgecdn.net/files/2935/323/RLCraft+Server+Pack+1.12.2+-+Beta+v2.8.2.zip -O rlcraft.zip; \
        unzip -o rlcraft.zip; \
        rm rlcraft.zip
