#!/bin/bash

ZIP_DIR="${ZIP_DIR:-/zips}"
APP_DIR="${APP_DIR:-/app}"
MODULES_DIR="$APP_DIR/modules/servers"

WHMCS_ZIP="$ZIP_DIR/whmcs-full.zip"
WHMCS_ZIP_LOADED="$ZIP_DIR/whmcs-full.loaded.zip"
WHMCS_ZIP_CONTENTS="whmcs/*"

MODULE_ZIP="$ZIP_DIR/pterodactyl-whmcs.zip"
MODULE_ZIP_LOADED="$ZIP_DIR/pterodactyl-whmcs.loaded.zip"
MODULE_ZIP_CONTENTS="pterodactyl"

echo "Starting WHMCS unzip"

if [ -f "$WHMCS_ZIP" ]; then
    echo "$WHMCS_ZIP exists. Extracting and copying to $APP_DIR"
    mkdir -p /tmp/whmcs-unzip
    unzip -qqu "$WHMCS_ZIP" -d /tmp/whmcs-unzip
    mv "$WHMCS_ZIP" "$WHMCS_ZIP_LOADED"
    cp -r /tmp/whmcs-unzip/$WHMCS_ZIP_CONTENTS "$APP_DIR"
    rm -rf /tmp/whmcs-unzip
else
    echo "$WHMCS_ZIP does not exist. Skipping."
fi

if [ -f "$MODULE_ZIP" ]; then
    echo "$MODULE_ZIP exists. Extracting and copying to $MODULES_DIR"
    mkdir -p /tmp/whmcs-unzip
    unzip -qqu "$MODULE_ZIP" -d /tmp/whmcs-unzip
    mv "$MODULE_ZIP" "$MODULE_ZIP_LOADED"
    cd /tmp/whmcs-unzip
    if [ -d /tmp/whmcs-unzip/whmcs-master ]; then
        # special case for zips downloaded from github
        cd whmcs-master
    fi
    cp -r $MODULE_ZIP_CONTENTS "$MODULES_DIR"
    rm -rf /tmp/whmcs-unzip
else
    echo "$MODULE_ZIP does not exist. Skipping."
fi

echo "WHCMS PHP-FPM starting"

php-fpm -F --pid /opt/bitnami/php/tmp/php-fpm.pid -y /opt/bitnami/php/etc/php-fpm.conf
EXIT_CODE=$?

echo "PHP-FPM exit code: $EXIT_CODE"

exit $EXIT_CODE
