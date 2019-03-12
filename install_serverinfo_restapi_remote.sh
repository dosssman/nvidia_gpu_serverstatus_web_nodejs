#!/bin/bash
# To be ran as root

# Distro check Helper
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

# Installing NodeJS 11.x and Dependencies
echo "${OS}"" was detected on ""${HOSTNAME}"
echo "Installing NodeJS Dependencies"
if [ "${OS}" == "Ubuntu" ] ; then
  curl -sL https://deb.nodesource.com/setup_11.x | bash -
  apt-get install -y nodejs
fi
if [ "${OS}" == "CentOS Linux" ] ; then
  # Install from Binaries
  # NODEJS_VERSION="v11.11.0"
  # NODEJS_DISTRO="linux-x64"
  # NODEJS_INSTALLDIR="/usr/local/lib/nodejs"
  # if [ ! -d "${NODEJS_INSTALLDIR}" ]; then
  #   mkdir -p "${NODEJS_INSTALLDIR}"
  # fi
  # NODEJS_URL="https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-${NODEJS_DISTRO}.tar.xz"
  # wget "${NODEJS_URL}"
  # tar -xJvf "node-$NODEJS_VERSION-$NODEJS_DISTRO.tar.xz" -C /usr
  # rm -rf "node-$NODEJS_VERSION-$NODEJS_DISTRO.tar.xz"
  #
  # ln -s "/usr/local/lib/nodejs/node-$NODEJS_VERSION-$NODEJS_DISTRO/bin/node" "/usr/bin/node"
  # ln -s "/usr/local/lib/nodejs/node-$NODEJS_VERSION-$NODEJS_DISTRO/bin/npm" "/usr/bin/npm"
  # ln -s "usr/local/lib/nodejs/node-$NODEJS_VERSION-$NODEJS_DISTRO/bin/npx" "/usr/bin/npx"

  # Straight forward ver but not working in script
  curl --silent --location https://rpm.nodesource.com/setup_11.x | bash -
  yum install -y nodejs

  # Install from source
  # yum install gcc-c++ make -y
  # wget "https://nodejs.org/dist/v11.11.0/node-v11.11.0.tar.gz"
  # tar xvf "node-v11.11.0.tar.gz"
  # cd "node-v11.11.0"
  # ./configure
  # make -j $(nproc)
  # make install
  # cd ..
  # rm -rf "node-v11.11.0"
fi

echo .
echo "Cloning serverinfo_restapi to /opt/serverinfo_restapi"
git clone "https://github.com/dosssman/serverstatus_nodejs.git" "/opt/serverstatus_nodejs"
mv "/opt/serverstatus_nodejs/serverinfo_restapi" "/opt/serverinfo_restapi"
rm -rf "/opt/serverstatus_nodejs"

# Install server App
npm install --prefix /opt/serverinfo_restapi /opt/serverinfo_restapi

# Create Service and forward necessary command
if [ "${OS}" == "Ubuntu" ] ; then
  ln -s "/opt/serverinfo_restapi/serverinfo_restapi_ubuntu.service" "/etc/systemd/system/serverinfo_restapi.service"
fi
if [ "${OS}" == "CentOS Linux" ] ; then
  ln -s "/opt/serverinfo_restapi/serverinfo_restapi_centos.service" "/etc/systemd/system/serverinfo_restapi.service"
fi

#Opening necessary port
if [ -f "/usr/bin/firewall-cmd" ]; then
  firewall-cmd --zone=public --add-port=9701/tcp --permanent
fi

# Enable and start service
systemctl enable serverinfo_restapi
systemctl start serverinfo_restapi
