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

echo " **********************"
echo " *  STARTING RLCraft  *"
echo " **********************"
java -Xmx${JVM_XMX:-4G} -Xms${JVM_XMS:-4G} -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar forge-server.jar nogui
