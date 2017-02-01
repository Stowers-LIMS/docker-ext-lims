#!/usr/bin/env bash
set -e

# exit when docker sends SIGTERM (aka docker stop)
onTerminate() {
    echo "Got SIGTERM, quitting..."
    exit
}
trap 'onTerminate' SIGTERM

#
# Initialize container-specific files
#

# Ensure limsuser uid and gid matches environment configuration (see docker-compose.yml)
: ${DOCKERLIMS_SHELL_UID:=5000}
echo "Switching to UID ${DOCKERLIMS_SHELL_UID}"
usermod -u ${DOCKERLIMS_SHELL_UID} limsuser
groupmod -g ${DOCKERLIMS_SHELL_UID} limsuser

# Perform an initial build on the ext files
cd /var/www/html/Ext
#HOME=/home/limsuser su -p limsuser -c '. ~/.bash_profile; ./build.sh'

# Ensure container stays alive so it can be exec'd into
while true
do
    sleep 1
done