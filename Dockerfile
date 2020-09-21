FROM openjdk:8

RUN set -eux; \
        adduser --system --group app; \
        mkdir -p /server; \
        chown -R app:app /server

WORKDIR /server

USER app

RUN set -eux; \
        wget https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2838/forge-1.12.2-14.23.5.2838-installer.jar -O forge-installer.jar; \
        java -jar forge-installer.jar --installServer; \
        rm forge-installer.jar; \
        rm forge-installer.jar.log; \
        mv forge-1.12.*-universal.jar forge-server.jar; \
echo $'# temporary for Forge installation\n\
eula=TRUE\n' > eula.txt; \
        echo stop | java -jar forge-server.jar nogui; \
        rm eula.txt; \
        rm -rf logs/*; \
        rm -rf world/*; \
        sed -i'' -e 's/level-seed=.*/level-seed=/' server.properties; \
        sed -i'' -e 's/allow-flight=.*/allow-flight=true/' server.properties; \
        sed -i'' -e 's/difficulty=.*/difficulty=3/' server.properties; \
        sed -i'' -e 's/max-tick-time=.*/max-tick-time=-1/' server.properties; \
        sed -i'' -e 's/view-distance=.*/view-distance=6/' server.properties; \
        wget https://media.forgecdn.net/files/2935/323/RLCraft+Server+Pack+1.12.2+-+Beta+v2.8.2.zip -O rlcraft.zip; \
        unzip -o rlcraft.zip; \
        rm rlcraft.zip; \
        wget https://media.forgecdn.net/files/2811/832/Chunk+Pregenerator+V1.12-2.2.jar -O mods/Chunk+Pregenerator+V1.12-2.2.jar

COPY ./start.sh /server/

ENTRYPOINT ["/server/start.sh"]

EXPOSE 25565
