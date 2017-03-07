#!/bin/bash
mv tomcat7 /opt/tomcat7
# cp -f /etc/profile /etc/profile`date +%Y%m%d`.bak #back up the profile file `data +%Y%m%d`
# echo "# Tomcat
# CATALINA_HOME=/opt/tomcat7">> /etc/profile #\${var}
# source /etc/profile #make profile take effect immediately
cd /opt/tomcat7/bin
chmod 755 *.sh
sh startup.sh

 

