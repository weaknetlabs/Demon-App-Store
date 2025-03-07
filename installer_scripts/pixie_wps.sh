#!/usr/bin/env bash
# 2020 Demon App Store
# WeakNet Labs
#
# Installer script, should be called from the workflow app
# INSTALL:
# --------------------
# Pixie WPS
# --------------------
# NOTES:
#
#
# DO NOT INFO:
printf "\n[INFO] Installer script initiated: $(echo $0)\n"
#
export DAS_LOCAL=/var/demon/store/code/Demon-App-Store/
export DAS_CONFIG=${DAS_LOCAL}das_config.txt # This is required
export DAS_FUNC_SCRIPT_DIR=$(cat $DAS_CONFIG|grep DAS_FUNC_SCRIPT_DIR|sed -r 's/[^=]+=//')
##### ##### ##### ##### #####
export DAS_DESKTOP_CACHE=$(cat $DAS_CONFIG|grep DAS_DESKTOP_CACHE | sed -r 's/[^=]+=//')
export DAS_APPCACHE=$(cat $DAS_CONFIG|grep DAS_APPCACHE | sed -r 's/[^=]+=//')
export SYS_LOCAL_APPS=$(cat $DAS_CONFIG|grep SYS_LOCAL_APPS | sed -r 's/[^=]+=//')
export GIT_URL=https://github.com/wiire/pixiewps/archive/master.zip
export DAS_APP_NAME=PixieWPS
export DAS_FUNC_SCRIPT_DIR=$(cat $DAS_FUNC_SCRIPT_DIR|grep DAS_APPCACHE|sed -r 's/[^=]+=//')
##### Demon App Store Variables:
# Example of pulling variable from das_config:
# $(cat $DAS_CONFIG|grep DAS_APPCACHE|sed -r 's/[^=]+=//')
export FILE=master.zip
export LOCALAREA=$DAS_APPCACHE/$FILE # /var/demon/.../master.zip
export CHECKSUM=75453b8646f28873de05c083a60b6a69 # for master.zip ($FILE)
export INSTALLAREA=/cyberpunk/wifi/
export INSTALLDIR=pixiewps-master
$DAS_FUNC_SCRIPT_DIR/checksum_check.sh $LOCALAREA $CHECKSUM $GIT_URL $DAS_APP_NAME # download the file

cp $LOCALAREA $INSTALLAREA
cd $INSTALLAREA && unzip $FILE && rm $FILE
apt -y install $DAS_BUILD_DEPS # install dependencies
cd ${INSTALLAREA}/${INSTALLDIR} && make && cp pixiewps /usr/local/sbin # copy the executable into $PATH
cp $DAS_DESKTOP_CACHE/pixiewps.desktop /usr/share/applications # copy menu icon/entry file
cd && rm -rf ${INSTALLAREA}/${INSTALLDIR} # remove /cyberpunk/wifi/pixiewps-master
