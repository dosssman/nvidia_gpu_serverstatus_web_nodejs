# GPU Server Status Monitor with NodeJS (NVIDIA SMI Javascript Wrapper + Web Interface)

Web Browser interface for GPU Server Monitoring
![Preview](https://github.com/dosssman/serverstatus_nodejs/raw/master/BrowserPreview.png)

## Usage

Access the local ip address / domain name of the machine running "ServerInfo Webserver"
module with a Web Browser (Tested on Chromium)

## Server Info RESTAPI

When installed and activated on a specific server, provides a REST API to cccess
the later's info, namely GPU usage status, RAM Memory usage and HDD info (!)

### Setup
! The scripts support Ubuntu and Centos only for now

- If installing from the "to be monitored" GPU server directly, just run "install_serverinfo_restapi_remote.sh".
- Else, when installing on multiple servers, first make sure to have root access on each of the remote GPU servers as well
as root ssh access, edit the "HOSTS" variable "install_serverinfo_restapi.sh" with the hostnames (requires DNS config on your network)
or ip addresses of the target GPU machines, then run the script.

## Central Monitoring WebApp

Provide a Web Browser accessible interface to monitor GPU server status of machines
where the "Server Info RESTAPI" counterpart is installed.

### Setup
```
- Copy the "serverinfo_webserver" sub module to desired location (/opt recommended)
- Make sure you have NodeJS >= 10 intalled  (Tested on 11.6 and 11.11 Arch Linux, Centos 7 and Ubuntu 16.04)
- Access the folder with a terminal and run "npm install" to install necessary dependencies
Either:
- Run "node main.js" directly from the directory (dirty, as "killall nodejs" and similar command will stop the nodejs server, etc ...)
- Copy the appropriate systemd service unit file to "/etc/systemd/system/" and run "systemctl daemon-reload && systemctl enable serverinfo_webserver_XXX && systemctl start serverinfo_webserver_XXX"
```

# Improvement (?)
- Easy to understand General / GPU Usage state summary
- get_meminfo: Active memory vs Used Memory
- get_hddinfo: Doesn't display HDD info for Ubuntu based server, wut !?
- Add Alert in Webapp when a full HD detected somewhere
- Optimize variables mgmt in central monitor app
- Collapse Storage Info
- Badge close to "Online" to signlal harddrive critical condition
- Slack Notification on full hard drives
- Service units: Node ~app.js or npm start: Which is better ?

# Credits
- NodeJS SystemInforation wrapper [insert link]
- Bootstrap Admin Dashboard template [insert link]

# Other
- NVIDIA SMI Javascript Wrapper can be found in serverinfo_restapi/hw_info.js
