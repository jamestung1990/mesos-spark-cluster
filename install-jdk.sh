#!/bin/bash

declare -r VERSION=${0:-"8u112"}
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.tar.gz

mkdir /opt/jdk
cd /opt/jdk
tar -zxf jdk-8u112-linux-x64.tar.gz

update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_112/bin/java 100
update-laternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_112/bin/javac 100

echo "Verify Java version:"
update-alternatives --display java
update-alternatives --display javac
java -version

echo "export JAVA_HOME=/opt/jdk/jdk1.8.0_112"
echo "export JAVA_HOME=/opt/jdk/jdk1.8.0_112" >> ~/.profile
echo "export PATH=\"$PATH:$JAVA_HOME/bin\""
echo "export PATH=\"$PATH:$JAVA_HOME/bin\"" >> ~/.profile

