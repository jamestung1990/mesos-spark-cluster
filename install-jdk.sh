#!/bin/bash

#declare -r VERSION=${0:-"8u112"}

if [ ! -f "jdk-8u112-linux-x64.tar.gz" ]
then
  wget --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.tar.gz
fi

mkdir /opt/jdk
mv jdk-8u112-linux-x64.tar.gz /opt/jdk
cd /opt/jdk
tar -zvxf jdk-8u112-linux-x64.tar.gz
rm jdk-8u112-linux-x64.tar.gz

update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_112/bin/java 100
update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_112/bin/javac 100

echo "Verify Java version:"
update-alternatives --display java
update-alternatives --display javac
java -version

export JAVA_HOME="/opt/jdk/jdk1.8.0_112"
echo "export JAVA_HOME=/opt/jdk/jdk1.8.0_112" >> ~/.profile
echo "export PATH=\"$PATH:$JAVA_HOME/bin\""
echo "export PATH=\"$PATH:$JAVA_HOME/bin\"" >> ~/.profile

