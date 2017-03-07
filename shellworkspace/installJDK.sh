#!/bin/bash
# A shell to install jdk for centos
# the jdk package should be put the same directory with the shell script.
# writen by zhangshy 2016/9/23
# this is only writen for jdk-7u76-linux-x64.tar.gz
mkdir -p /usr/lib/jvm
tar -zxvf jdk-7u76-linux-x64.tar.gz -C /usr/lib/jvm
mv /usr/lib/jvm/jdk1.7.0_76 /usr/lib/jvm/java7
cp -f /etc/profile /etc/profile`date +%Y%m%d`.bak #back up the profile file `data +%Y%m%d`
echo "# JRE_PATH
export JAVA_HOME=/usr/lib/jvm/java7
export JRE_HOME=\${JAVA_HOME}/jre  
export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib  
export PATH=\${JAVA_HOME}/bin:\$PATH" >> /etc/profile #\${var}
source /etc/profile #make profile take effect immediately
java -version
