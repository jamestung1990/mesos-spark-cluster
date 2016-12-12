
wiseCloudDir=${1:-"/opt/wisecloud"}

zookeeperVersion=${2:-"3.4.9"}

if [ ! -f "zookeeper-$zookeeperVersion.tar.gz" ]
then
  wget http://ftp.tc.edu.tw/pub/Apache/zookeeper/stable/zookeeper-$zookeeperVersion.tar.gz
fi

tar zxvf zookeeper-$zookeeperVersion.tar.gz

mkdir -p $wiseCloudDir
mv zookeeper-$zookeeperVersion $wiseCloudDir/

ZOOKEEPER_HOME="$wiseCloudDir/zookeeper-$zookeeperVersion"
echo "export ZOOKEEPER_HOME=$ZOOKEEPER_HOME" >> $HOME/.profile

echo "export PATH=\"$PATH:$ZOOKEEPER_HOME/bin\"" >> $HOME/.profile
PATH="$PATH:$ZOOKEEPER_HOME/bin"

source "$HOME/.profile"

#config
touch "$ZOOKEEPER_HOME/conf/zoo.cfg"
echo "tickTime=2000" >> "$ZOOKEEPER_HOME/conf/zoo.cfg"
echo "dataDir=/var/lib/zookeeper" >> "zookeeper-$zookeeperVersion/conf/zoo.cfg"
echo "clientPort=2181" >> "zookeeper-$zookeeperVersion/conf/zoo.cfg"

zkServer.sh start
