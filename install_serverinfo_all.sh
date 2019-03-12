#!/bin/bash
# TARGET_DISTRIB=$(ssh yeager "cat /etc/lsb-release | grep -o '^DISTRIB_ID=.*'")
# TARGET_DISTRIB=${TARGET_DISTRIB/'DISTRIB_ID='/''}
# echo $TARGET_DISTRIB

USERNAME="root"
HOSTS="yeager"
SCRIPT="if [ -f /usr/bin/yum ]; then echo 'File Exist'; fi"

for REMOTE_HOSTNAME in ${HOSTS} ; do
    # Copy appropriate install script to remote srver
    rsync -ravu "./install_serverinfo_restapi_remote.sh" ${USERNAME}@${REMOTE_HOSTNAME}:~/.
    ssh -l ${USERNAME} ${REMOTE_HOSTNAME} "source ./install_serverinfo_restapi_remote.sh"

    # Clean Up
    # Remove Distro detect script from remote server
    ssh -l ${USERNAME} ${REMOTE_HOSTNAME} "rm ./install_serverinfo_restapi_remote.sh"
done
