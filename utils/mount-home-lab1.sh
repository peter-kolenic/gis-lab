#!/bin/bash
set -e

DIR="$(dirname $0)"

source "$(dirname $DIR)/config.cfg"
source "$(dirname $DIR)/config-user.cfg"

HOMEDIR="$(dirname $DIR)/HOME"
[ -d "$HOMEDIR" ] || mkdir "$HOMEDIR"

sudo mount -t nfs -o nolock,resvport 192.168.59.5:/home "$HOMEDIR"
