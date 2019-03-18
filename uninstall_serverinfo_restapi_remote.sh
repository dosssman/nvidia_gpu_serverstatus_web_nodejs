#!/bin/bash
# To be ran as root


# Disable Service and forward necessary command
if [ -f "/etc/systemd/system/serverinfo_restapi.service" ]; then
  # Stopping potentially running service
  echo "Disabling ServerInfo RESTAPI Service"
  systemctl stop serverinfo_restapi
  systemctl disable serverinfo_restapi
  systemctl daemon-reload
  rm -rf "/etc/systemd/system/serverinfo_restapi.service"
fi

#Opening necessary port
if [ -f "/usr/bin/firewall-cmd" ]; then
  echo "Close unused Firewall port (firewall-cwd)"
  firewall-cmd --zone=public --remove-port=9701/tcp &> /dev/null
  firewall-cmd --runtime-to-permanent &> /dev/null
  firewall-cmd --reload &> /dev/null
fi

# Delete files
if [ -d "/opt/serverinfo_restapi" ]; then
  echo "Removing /opt/serverinfo_restapi"
  rm -rf "/opt/serverinfo_restapi"
fi

echo "Bye bye"
