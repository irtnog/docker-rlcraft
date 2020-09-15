#! /bin/sh

# Check EULA
if [ ! -e eula.txt ]; then
    if [ "$EULA" != "" ]; then
        echo "# Generated via Docker on $(date)" > eula.txt
        echo "eula=$EULA" >> eula.txt
    else
        echo 'ERROR: The minecraft EULA must be accepted before the server can be started.\n'
        echo "By setting the enviroment variable EULA to TRUE you are indicating your agreement to the EULA at https://account.mojang.com/documents/minecraft_eula."
        exit 1
    fi
fi

# Get Forge
if [ ! -f "forge-server.jar" ]; then
	echo " **********************"
	echo " *  INSTALLING FORGE  *"
	echo " **********************"
    wget https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2838/forge-1.12.2-14.23.5.2838-installer.jar -O forge-installer.jar
    java -jar forge-installer.jar --installServer
    rm forge-installer.jar
    mv forge-1.12.*-universal.jar forge-server.jar
fi

# Get RLCraft
if [ ! -d "mods" ]; then
	echo " ************************"
	echo " *  INSTALLING RLCraft  *"
	echo " ************************"
	wget https://media.forgecdn.net/files/2935/323/RLCraft+Server+Pack+1.12.2+-+Beta+v2.8.2.zip -O rlcraft.zip
	unzip rlcraft.zip -d ziptmp
	mv ziptmp/*/* .
	rm -rf ziptmp rlcraft.zip
fi

echo " **********************"
echo " *  STARTING RLCraft  *"
echo " **********************"
java -Xmx${JVM_XMX:-4G} -Xms${JVM_XMS:-4G} -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar forge-server.jar nogui
