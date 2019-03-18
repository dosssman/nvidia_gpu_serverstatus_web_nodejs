#!/bin/bash
# TARGET_DISTRIB=$(ssh yeager "cat /etc/lsb-release | grep -o '^DISTRIB_ID=.*'")
# TARGET_DISTRIB=${TARGET_DISTRIB/'DISTRIB_ID='/''}
# echo $TARGET_DISTRIB

USERNAME="root"
HOSTS="servername"

for REMOTE_HOSTNAME in ${HOSTS} ; do
    # Copy appropriate install script to remote srver
    rsync -u "./uninstall_serverinfo_restapi_remote.sh" ${USERNAME}@${REMOTE_HOSTNAME}:~/. &> /dev/null
    ssh -l ${USERNAME} ${REMOTE_HOSTNAME} "source ./uninstall_serverinfo_restapi_remote.sh"

    # Clean Up
    # Remove Distro detect script from remote server
    ssh -l ${USERNAME} ${REMOTE_HOSTNAME} "rm ./uninstall_serverinfo_restapi_remote.sh"
done
